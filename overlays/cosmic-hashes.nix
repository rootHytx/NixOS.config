self: super:

/*
  Safer fetch-wrapper overlay for Cosmic fixed-output sources.

  Purpose
  - Export small, safe helper functions that wrap `fetchurl` for Github archive
    tarballs and provide a convenience factory for producing a dedicated overlay
    that only overrides a package's `src` when that package attribute actually
    exists in `super`.

  Design goals
  - Avoid evaluating arbitrary package attributes at overlay load time.
  - Avoid causing infinite recursion by not eagerly forcing `pkgs` evaluation.
  - Keep behavior explicit: the overlay exports helpers; to actually override
    packages you call `makeSrcOverride` in a separate overlay (applied after
    this one) or compose it into your overlays list intentionally.

  Usage
  1) Add this file to your flake and include it in `nixpkgs.overlays`:
     overlays = [ (import ./overlays/cosmic-hashes.nix) ... ];

  2) After that, create a small overlay (applied after this one) that uses
     `makeSrcOverride` to override the packages you need. Example (in your
     flake's overlays list, after this overlay is present):

     (self: super: let helpers = (import ./overlays/cosmic-hashes.nix) { inherit self super; }; in
       helpers.makeSrcOverride "popos-cosmic-greeter" "pop-os" "cosmic-greeter" "2d2543094e04ae3167f71a5986626f03663beb79" "128iagf46mwx4b6vx23h8qh70bm8269qgcqwhk0fhvmj1hrckfl2")

     That expression returns a small overlay that will override `popos-cosmic-greeter`'s
     `src` only if `super` contains that attribute.

  Notes
  - The helpers in this overlay are intentionally minimal and do not themselves
    override any package attributes automatically. This avoids surprising
    evaluation ordering and recursion issues in complex flakes / module setups.
  - Always compute sha256 with `nix hash-file --type sha256 --base32 /tmp/archive.tar.gz`
    and place the base32 string into the call to `makeSrcOverride`.
*/

let
  # Convenience wrapper around super.fetchurl (don't evaluate any other attrs).
  fetchFromUrl =
    url: sha256:
    super.fetchurl {
      inherit url sha256;
    };

  # Helper for GitHub tarball archives using codeload URL (stable across GitHub).
  # owner: e.g. "pop-os"
  # repo:  e.g. "cosmic-greeter"
  # rev:   commit/tag string
  fetchGithubArchive =
    owner: repo: rev: sha256:
    fetchFromUrl (builtins.concatStringsSep "" [
      "https://codeload.github.com/"
      owner
      "/"
      repo
      "/tar.gz/"
      rev
    ]) sha256;

  # Factory that returns a small overlay which overrides the named package's `src`
  # to the specified GitHub archive + sha256. The returned value is itself an
  # overlay: (self: super: { ... }).
  #
  # - pkgAttrName : string - the attribute name in `pkgs` you want to override,
  #                         e.g. "popos-cosmic-greeter" or "cosmic-greeter".
  # - owner, repo, rev, sha256 : strings for the GitHub archive and its base32 sha256.
  #
  # IMPORTANT: This factory does not attempt to call or evaluate `super.<attr>`
  # unless the attribute exists (checked via `builtins.hasAttr`). Even then the
  # override happens lazily as part of the returned overlay; apply it after
  # including this helper to avoid ordering issues.
  makeSrcOverride =
    pkgAttrName: owner: repo: rev: sha256:
    (
      self: super:
      let
        exists = builtins.hasAttr pkgAttrName super;
      in
      builtins.optionalAttrs exists {
        # dynamic attribute name via interpolation; safe because we only construct
        # the attrset when `exists` is true.
        "${pkgAttrName}" = super."${pkgAttrName}".overrideAttrs (old: {
          src = fetchGithubArchive owner repo rev sha256;
        });
      }
    );

in
{
  # Expose helpers for other overlays / users of this overlay.
  # - use `cosmicFetch` / `fetchGithubArchive` for direct fetches in expressions.
  # - use `makeSrcOverride` to create a small overlay that replaces `src` safely.
  inherit fetchFromUrl fetchGithubArchive makeSrcOverride;

  # Additionally export a short alias for convenience.
  cosmicFetch = fetchFromUrl;
}
