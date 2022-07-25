from typing import List

from fastapitableau import FastAPITableau
from sklearn.ensemble import RandomForestRegressor
import numpy as np

app = FastAPITableau(
    title="Random Forest Regression",
    description="Fit a random forest to the input data",
    version="0.1.0"
)

@app.post("/rf")
def rf(x: List[float], y: List[float]) -> List[float]:
    X = np.array(x).reshape(-1, 1)
    regr = RandomForestRegressor(max_depth = 2, random_state = 0)
    regr.fit(X, y)
    preds = regr.predict(X)
    return preds.tolist()