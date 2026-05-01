import json

import pyperclip


def get_open_script(app: str):
    if app == "IDE":
        # If CLion is open, open it. Else if PyCharm is open, open it. Otherwise, do nothing
        return "pgrep -x clion > /dev/null && open -a clion || (pgrep -x pycharm > /dev/null && open -a pycharm)"
    else:
        return f"open -a '{app}'"


rule_map = {
    "description": "YOSUA's APPS",
    "manipulators": [
        {
            "from": {"key_code": key_code, "modifiers": {"mandatory": modifier}},
            "to": [{"shell_command": get_open_script(app)}],
            "type": "basic",
        }
        for key_codes, app in (
            [["a", "1"], "Discord"],
            [["s", "2"], "IDE"],
            [["d", "3"], "kitty"],
            [["f", "4"], "Google Chrome"],
            [["z", "5"], "Finder"],
            [["x", "6"], "obsidian"],
            [["c", "7"], "tldraw"],
            [["v", "8"], "sioyek"],
        )
        for modifier in (
            ["left_command", "right_command"],
            ["left_control", "left_gui"],
        )
        for key_code in key_codes
    ],
}

# rule_map['manipulators'].append()

json_rule = json.dumps(rule_map, indent=4)

pyperclip.copy(json_rule)

print(json_rule)

print("copied to clipboard!")
