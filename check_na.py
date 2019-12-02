import pandas as pd

data = pd.read_csv("data/AllRookieDataGrouped.csv")

for i in range(len(data['cbb_group'])):
    if data['cbb_group'].isnull().values.any() & data['intl_group'].isnull().values.any():
        print(data['First_Name'][i] + data['Last_Name'][i])
