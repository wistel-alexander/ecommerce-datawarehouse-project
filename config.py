from pathlib import Path

# ===============================
# Rutas del proyecto
# ===============================

BASE_DIR = Path(__file__).resolve().parent

DATASETS_DIR = BASE_DIR / "datasets"

RAW_DATA_DIR = DATASETS_DIR / "raw"

PROCESSED_DATA_DIR = DATASETS_DIR / "processed"

REPORTS_DIR = BASE_DIR / "reports"

LOGS_DIR = BASE_DIR / "etl" / "logs"