self: super:

let
  helpers = (import ./cosmic-hashes.nix) { inherit self super; };

  greeterOwner = "pop-os";
  greeterRepo = "cosmic-greeter";
  greeterRev = "2d2543094e04ae3167f71a5986626f03663beb79";
  greeterSha = "128iagf46mwx4b6vx23h8qh70bm8269qgcqwhk0fhvmj1hrckfl2";

  editOwner = "pop-os";
  editRepo = "cosmic-edit";
  editRev = "020342119d0ac4d362f7642a97eecade3d766177";
  editSha = "0m6abgn2x05iw9i6zxiq89jb8vdxgn1fzp4i1byghz92xipgxq88";

  attrsList = [
    builtins.optionalAttrs
    (builtins.hasAttr "popos-cosmic-greeter" super)
    {
      popos-cosmic-greeter = super."popos-cosmic-greeter".overrideAttrs (old: {
        src = helpers.fetchGithubArchive greeterOwner greeterRepo greeterRev greeterSha;
      });
    }

    builtins.optionalAttrs
    (builtins.hasAttr "cosmic-greeter" super)
    {
      "cosmic-greeter" = super."cosmic-greeter".overrideAttrs (old: {
        src = helpers.fetchGithubArchive greeterOwner greeterRepo greeterRev greeterSha;
      });
    }

    builtins.optionalAttrs
    (builtins.hasAttr "popos-cosmic-edit" super)
    {
      popos-cosmic-edit = super."popos-cosmic-edit".overrideAttrs (old: {
        src = helpers.fetchGithubArchive editOwner editRepo editRev editSha;
      });
    }

    builtins.optionalAttrs
    (builtins.hasAttr "cosmic-edit" super)
    {
      "cosmic-edit" = super."cosmic-edit".overrideAttrs (old: {
        src = helpers.fetchGithubArchive editOwner editRepo editRev editSha;
      });
    }
  ];
in
# Merge all optional attrsets into a single overlay attrset.
builtins.foldl' (acc: item: acc // item) { } attrsList
