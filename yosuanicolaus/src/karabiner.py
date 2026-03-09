import json

import pyperclip

rule_map = {
    "description": "APPS (ctrl/both_cmds + (jkl;u/12345))",
    "manipulators": [
        {
            "from": {"key_code": key_code, "modifiers": {"mandatory": modifier}},
            "to": [{"shell_command": f"open -a '{app}'"}],
            "type": "basic",
        }
        for key_codes, app in (
            [["j", "1"], "Google Chrome"],
            [["k", "2"], "kitty"],
            [["l", "3"], "Finder"],
            [["semicolon", "4"], "Discord"],
            [["u", "5"], "sioyek"],
        )
        for modifier in (
            ["left_command", "right_command"],
            ["left_control"],
        )
        for key_code in key_codes
    ],
}

json_rule = json.dumps(rule_map, indent=4)

pyperclip.copy(json_rule)

print(json_rule)

print("copied to clipboard!")
