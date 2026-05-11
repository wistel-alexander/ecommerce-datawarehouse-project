import pandas as pd
import os

# Directorio de los datasets
data_dir = 'datasets/raw/'

# Lista de archivos CSV
csv_files = [
    'olist_customers_dataset.csv',
    'olist_orders_dataset.csv',
    'olist_order_items_dataset.csv',
    'olist_order_payments_dataset.csv',
    'olist_order_reviews_dataset.csv',
    'olist_products_dataset.csv',
    'olist_sellers_dataset.csv'
]

# Analizar cada archivo
for file in csv_files:
    file_path = os.path.join(data_dir, file)
    if os.path.exists(file_path):
        print(f"\n=== Análisis de {file} ===")
        df = pd.read_csv(file_path)
        print(f"Shape: {df.shape}")
        print(f"Columnas: {list(df.columns)}")
        print("Primeras 5 filas:")
        print(df.head())
        print(f"Tipos de datos:\n{df.dtypes}")
        print(f"Valores nulos:\n{df.isnull().sum()}")
    else:
        print(f"Archivo {file} no encontrado.")