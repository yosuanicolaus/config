import json

import pyperclip

rule_map = {
    "description": "YONIAPPS",
    "manipulators": [
        {
            "from": {"key_code": key_code, "modifiers": {"mandatory": modifier}},
            "to": [{"shell_command": f"open -a '{app}'"}],
            "type": "basic",
        }
        for key_codes, app in (
            [["a", "1"], "Google Chrome"],
            [["s", "2"], "kitty"],
            [["d", "3"], "Finder"],
            [["f", "4"], "Discord"],
            [["z", "5"], "sioyek"],
            [["x", "6"], "pycharm"],  # change to IDE later? and only when IDE is open?
            [["c", "7"], "obsidian"],
        )
        for modifier in (
            ["left_command", "right_command"],
            ["left_control", "left_gui"],
        )
        for key_code in key_codes
    ],
}

json_rule = json.dumps(rule_map, indent=4)

pyperclip.copy(json_rule)

print(json_rule)

print("copied to clipboard!")
