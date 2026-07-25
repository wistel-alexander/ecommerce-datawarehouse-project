import pandas as pd

from config import RAW_DATA_DIR


def load_dataset(filename: str) -> pd.DataFrame:
    """
    Load a CSV dataset from the raw datasets folder.

    Parameters
    ----------
    filename : str
        Dataset filename.

    Returns
    -------
    pd.DataFrame
        Loaded dataframe.
    """

    dataset_path = RAW_DATA_DIR / filename

    return pd.read_csv(dataset_path)