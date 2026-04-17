import json

import pyperclip

rule_map = {
    "description": "both-cmds+tab -> cmd+`",
    "manipulators": [
        {
            "from": {"key_code": "tab", "modifiers": {"mandatory": ["left_command", "right_command"]}},
            "to": [{"key_code": "grave_accent_and_tilde", "modifiers": ["left_command"]}],
            "type": "basic",
        }
    ],
}

json_rule = json.dumps(rule_map, indent=4)

pyperclip.copy(json_rule)

print(json_rule)

print("copied to clipboard!")
