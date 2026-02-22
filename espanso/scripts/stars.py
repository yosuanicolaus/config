import sys


def generate_stars(trigger: str):
    output = ""

    if trigger.startswith("-"):
        output = "- "
        trigger = trigger[1:]
    elif trigger.startswith("j"):
        output = "・"
        trigger = trigger[1:]

    n = 10 if trigger[-1] == "T" else int(trigger[-1])
    total_stars = 5 if trigger[0].islower() else 10

    if trigger.lower().startswith("ss"):
        output += "★ " * n + "☆ " * (total_stars - n)
    else:  # trigger is 's'
        output += "★" * n + "☆" * (total_stars - n)

    return output


def convert_to_double_width(s: str):
    return s.translate(str.maketrans("0123456789", "０１２３４５６７８９"))


if __name__ == "__main__":
    result = generate_stars(sys.argv[1])
    print(result)
