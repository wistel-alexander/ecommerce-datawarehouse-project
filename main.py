from etl.extract.dataset_profiler import generate_report
from etl.analysis.customer_analysis import analyze_customers
from etl.analysis.orders_analysis import analyze_orders
from etl.analysis.order_items_analysis import analyze_order_items
from etl.analysis.products_analysis import analyze_products
from etl.analysis.payments_analysis import analyze_payments
from etl.analysis.reviews_analysis import analyze_reviews
from etl.analysis.sellers_analysis import analyze_sellers


def main():

    print("=" * 60)
    print("DATA ENGINEERING PROJECT")
    print("=" * 60)

    pipeline = [
        ("Dataset Profiling", generate_report),
        ("Customer Analysis", analyze_customers),
        ("Orders Analysis", analyze_orders),
        ("Order Items Analysis", analyze_order_items),
        ("Products Analysis", analyze_products),
        ("Payments Analysis", analyze_payments),
        ("Reviews Analysis", analyze_reviews),
        ("Sellers Analysis", analyze_sellers),
    ]

    total_steps = len(pipeline)

    for index, (name, task) in enumerate(pipeline, start=1):
        print(f"\n[{index}/{total_steps}] {name}...")
        task()

    print("\n" + "=" * 60)
    print("PIPELINE FINISHED SUCCESSFULLY")
    print("=" * 60)


if __name__ == "__main__":
    main()