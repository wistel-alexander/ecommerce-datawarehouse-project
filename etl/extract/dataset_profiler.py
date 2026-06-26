from pathlib import Path

import pandas as pd

from config import RAW_DATA_DIR, REPORTS_DIR


def get_csv_files():
    """
    Obtiene todos los archivos CSV ubicados
    en la carpeta datasets/raw.

    Returns:
        list[Path]: Lista de archivos CSV encontrados.
    """

    csv_files = sorted(RAW_DATA_DIR.glob("*.csv"))

    return csv_files


def load_dataset(file_path: Path) -> pd.DataFrame:
    """
    Carga un archivo CSV en un DataFrame de pandas.

    Args:
        file_path (Path): Ruta del archivo CSV.

    Returns:
        pd.DataFrame: DataFrame con la información del archivo.
    """

    try:
        dataframe = pd.read_csv(file_path)

        return dataframe

    except Exception as error:
        print(f"Error al leer {file_path.name}: {error}")

        return None
    
    
def profile_dataset(dataframe: pd.DataFrame) -> dict:
    """
    Genera un perfil del DataFrame con información
    relevante para el análisis de datos.

    Args:
        dataframe (pd.DataFrame): DataFrame a analizar.

    Returns:
        dict: Diccionario con las estadísticas del dataset.
    """

    profile = {

        "rows": len(dataframe),

        "columns": len(dataframe.columns),

        "column_names": dataframe.columns.tolist(),

        "data_types": dataframe.dtypes.astype(str).to_dict(),

        "null_values": dataframe.isnull().sum().to_dict(),

        "duplicate_rows": int(dataframe.duplicated().sum()),

        "memory_usage_mb": round(
            dataframe.memory_usage(deep=True).sum() / (1024 * 1024),
            2
        )

    }

    return profile


def generate_report():
    """
    Analiza todos los datasets y genera un reporte
    en formato Markdown.
    """

    csv_files = get_csv_files()

    report_lines = []

    report_lines.append("# Dataset Profiling Report\n")

    report_lines.append(
        "Reporte generado automáticamente por el proyecto ETL.\n"
    )

    for file in csv_files:

        print(f"Analizando {file.name}...")

        dataframe = load_dataset(file)

        if dataframe is None:
            continue

        profile = profile_dataset(dataframe)

        report_lines.append(f"## {file.name}\n")

        report_lines.append(f"- Filas: {profile['rows']}")

        report_lines.append(f"- Columnas: {profile['columns']}")

        report_lines.append(
            f"- Duplicados: {profile['duplicate_rows']}"
        )

        report_lines.append(
            f"- Memoria: {profile['memory_usage_mb']} MB\n"
        )

        report_lines.append("### Columnas\n")

        for column in profile["column_names"]:

            dtype = profile["data_types"][column]

            nulls = profile["null_values"][column]

            report_lines.append(
                f"- **{column}** | Tipo: `{dtype}` | Nulos: {nulls}"
            )

        report_lines.append("\n---\n")

    REPORTS_DIR.mkdir(exist_ok=True)

    report_path = REPORTS_DIR / "dataset_profile_report.md"

    with open(report_path, "w", encoding="utf-8") as file:

        file.write("\n".join(report_lines))

    print("\nReporte generado correctamente.")

    print(report_path)

    