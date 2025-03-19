import os
import threading
import time
def get_readme_description(readme_path):
    try:
        with open(readme_path, 'r') as readme_file:
            # Read the first few lines of the README.md file for a small description
            description = ''.join(readme_file.readlines()[:5])
            return description.strip()
    except Exception as e:
        return f"Error reading {readme_path}: {e}"

def check_folders_for_flake_nix():
    dir = '/etc/nixos/'
    number=0
    shells = []
    for folder_name in os.listdir(dir):
        folder_path = os.path.join(dir, folder_name)
        if os.path.isdir(folder_path):
            flake_nix_path = os.path.join(folder_path, "flake.nix")
            readme_path = os.path.join(folder_path, "README.md")
            if os.path.isfile(flake_nix_path):
                shells.append(folder_path)
                if os.path.isfile(readme_path):
                    description = get_readme_description(readme_path)
                    print(f"\t({number}) {folder_name}: {description}\n")
                else:
                    print(f"\t({number}) {folder_name}: README.md not found\n")
                number+=1
    return shells
asciiart='''
     __         ______      ____       __  __       __        _
 ___/ ___ _  __/ __/ / ___ / / ___   _/_/ / / __ __/ /__ __  | |
/ _  / -_| |/ _\\ \\/ _ / -_/ / (_-<  / /  / _ / // / __\\ \\ /  / /
\\_,_/\\__/|___/___/_//_\\__/_/_/___/ / /  /_//_\\_, /\\__/_\\_\\ _/_/
                                   |_|      /___/         /_/
'''

if __name__ == "__main__":
    print(asciiart)
    print("Available devShells:")
    shells = check_folders_for_flake_nix()
    while True:
        inp=input("Would you like to start a devShell? (y/n): ").lower()
        if  inp== 'y':
            shell_number = int(input("Enter the number of the shell you want to start: "))
            shell_path = shells[shell_number]
            os.system(f"nix develop {shell_path}")
            break
        elif inp=='n':
            print("Goodbye!")
            exit(0)
        else:
            print("Invalid input, please try again.")
            continue
