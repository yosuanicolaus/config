# © yosuanicolaus 2024
# made for my linux mint system
# reads all config files from various locations and updates the matching counterpart here

import shutil

file_counterpart_locations = {
    # [config file name]: [real file name]
    '.zshrc': '~/.zshrc',
    '.xbindkeysrc': '~/.xbindkeysrc',
    '.Xmodmap': '~/.Xmodmap',
    '.ideavimrc': '~/.ideavimrc',
    'kitty.conf': '~/.config/kitty/kitty.conf',
    'espanso.yml': '~/.config/espanso/match/base.yml',
    'rust-competitive-helper.toml': '~/.config/rust-competitive-helper/rust-competitive-helper.toml',
    'vscode_keybindings.json': '~/.config/Code - Insiders/User/keybindings.json',
    'vscode_settings.json': '~/.config/Code - Insiders/User/settings.json',
    'wezterm.lua': '~/.config/wezterm/wezterm.lua',
    'zed_keymap.json': '~/.config/zed/keymap.json',
    'zed_settings.json': '~/.config/zed/settings.json',
}

for config_file, real_file in file_counterpart_locations.items():
    # Construct absolute paths
    real_file = real_file.replace('~', '/home/yosuanicolaus')

    try:
        # Read content from real_file
        with open(real_file, 'r') as real_file_content:
            content = real_file_content.read()

        # Write content to config_file
        with open(config_file, 'w') as config_file_content:
            config_file_content.write(content)

        print(f'Successfully updated {config_file} from {real_file}')

    except Exception as e:
        print(f'Error updating {config_file}: {str(e)}')


# copy nvim (nvchad) folder content
try:
    real_folder_loc = '/home/yosuanicolaus/.config/nvim/'
    config_folder_loc = '/home/yosuanicolaus/repos/config/nvim/'

    # remove existing custom/ folder
    shutil.rmtree(config_folder_loc, ignore_errors=True)

    # copy content from nvchad config to custom/
    shutil.copytree(real_folder_loc, config_folder_loc)
    print(f'Successfully updated NvChad custom file')

except Exception as e:
    print(f'Error updating nvim folder: {str(e)}')
