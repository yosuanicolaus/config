import sys


def generate_stars(trigger: str):
    n = 10 if trigger[-1] == "T" else int(trigger[-1])
    total_stars = 5 if trigger[0].islower() else 10

    if trigger.lower().startswith("ss"):
        return "★ " * n + "☆ " * (total_stars - n)
    else:  # trigger is 's'
        return "★" * n + "☆" * (total_stars - n)


if __name__ == "__main__":
    result = generate_stars(sys.argv[1])
    print(result, end="")
