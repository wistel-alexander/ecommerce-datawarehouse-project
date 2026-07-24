from etl.extract.dataset_profiler import generate_report
from etl.analysis.customer_analysis import analyze_customers


def main():

    print("=" * 60)
    print("DATA ENGINEERING PROJECT")
    print("=" * 60)

    print("\n[1/2] Dataset Profiling...")
    generate_report()

    print("\n[2/2] Customer Analysis...")
    analyze_customers()


if __name__ == "__main__":
    main()