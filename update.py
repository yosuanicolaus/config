# © yosuanicolaus 2024
# made for my linux mint system
# reads all config files from various locations and updates the matching counterpart here

import shutil

################################################################################
# Copy Files
################################################################################

file_counterpart_locations = {
    # [config file name]: [real file name]
    ".zshrc": "~/.zshrc",
    ".xbindkeysrc": "~/.xbindkeysrc",
    ".Xmodmap": "~/.Xmodmap",
    ".ideavimrc": "~/.ideavimrc",
    "kitty.conf": "~/.config/kitty/kitty.conf",
    "espanso.yml": "~/.config/espanso/match/base.yml",
    "rust-competitive-helper.toml": "~/.config/rust-competitive-helper/rust-competitive-helper.toml",
    "vscode_keybindings.json": "~/.config/Code - Insiders/User/keybindings.json",
    "vscode_settings.json": "~/.config/Code - Insiders/User/settings.json",
    "zed_keymap.json": "~/.config/zed/keymap.json",
    "zed_settings.json": "~/.config/zed/settings.json",
    "zathurarc": "~/.config/zathura/zathurarc",
}

for config_file, real_file in file_counterpart_locations.items():
    # Construct absolute paths
    real_file = real_file.replace("~", "/home/yosuanicolaus")

    try:
        # Read content from real_file
        with open(real_file, "r") as real_file_content:
            content = real_file_content.read()

        # Write content to config_file
        with open(config_file, "w") as config_file_content:
            _ = config_file_content.write(content)

        print(f"[FILE] - Successfully updated {config_file} from {real_file}")

    except Exception as e:
        print(f"[ERROR] - Error when updating {config_file}: {str(e)}")


################################################################################
# Copy Folders
################################################################################

folder_counterpart_locations = {
    # [config folder name]: [real folder name]
    "/home/yosuanicolaus/repos/config/nvim/": "/home/yosuanicolaus/.config/nvim/",
    "/home/yosuanicolaus/repos/config/wezterm/": "/home/yosuanicolaus/.config/wezterm/",
}

for config_folder_loc, real_folder_loc in folder_counterpart_locations.items():
    try:
        # remove existing config folder
        shutil.rmtree(config_folder_loc, ignore_errors=True)
        # copy content from real folder to config folder
        shutil.copytree(
            real_folder_loc, config_folder_loc, ignore=shutil.ignore_patterns("*.git*")
        )
        print(
            f"[FOLDER] Successfully updated {config_folder_loc} from {real_folder_loc}"
        )

    except Exception as e:
        print(f"[ERROR] - Error when updating {config_folder_loc} folder: {str(e)}")
