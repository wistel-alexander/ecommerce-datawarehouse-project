def print_metric(label: str, value):
    """
    Print a formatted metric.
    """

    print(f"{label:<35}: {value:,}" if isinstance(value, int) else f"{label:<35}: {value}")