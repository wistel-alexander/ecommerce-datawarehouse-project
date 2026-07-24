from config import REPORTS_DIR


def generate_markdown_report(
    filename: str,
    title: str,
    content: str
):
    """
    Generate a Markdown report.
    """

    analysis_dir = REPORTS_DIR / "analysis"

    analysis_dir.mkdir(
        parents=True,
        exist_ok=True
    )

    report_path = analysis_dir / filename

    with open(
        report_path,
        "w",
        encoding="utf-8"
    ) as report:

        report.write(f"# {title}\n\n")
        report.write(content)

    print(f"\nReport generated successfully:")
    print(report_path)