from fastapitableau import FastAPITableau
from joblib import load
from pydantic import BaseModel
import pandas as pd

# Load model
model = load("model.joblib")

# Define the extension
app = FastAPITableau(
    title = "Predicted Profit",
    description = "A simple linear prediction of sales profit given new input data",
    version = "0.1.0"
)

# Define input object
class InputData(BaseModel):
    days_to_ship_actual: list[int]
    days_to_ship_scheduled: list[int]
    quantity: list[int]
    sales: list[float]
    discount: list[float]

@app.post("/predict")
async def predict(data: InputData):
    model_data = pd.DataFrame(data.dict())
    model_data["ship_diff"] = model_data.days_to_ship_actual - model_data.days_to_ship_scheduled
    pred_columns = [
        "ship_diff",
        "quantity",
        "sales",
        "discount"
    ]
    return model.predict(model_data.loc[:, pred_columns]).tolist()
