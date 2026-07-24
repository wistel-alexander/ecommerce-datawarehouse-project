def print_section(title: str):
    """
    Print a formatted section title.
    """

    print("\n" + "=" * 60)
    print(title.upper())
    print("=" * 60)


def print_subsection(title: str):
    """
    Print a formatted subsection title.
    """

    print(f"\n{title}")
    print("-" * 60)