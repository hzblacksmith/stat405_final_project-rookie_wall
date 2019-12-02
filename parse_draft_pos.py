import pandas as pd

df = pd.read_csv("data/nba_draft_1997_2018.csv")

df['First'] = df['First'].replace({'\'': '', '\\.': ''}, regex=True)

df.to_csv("data/nba_draft_1997_2018_parsed.csv", index=False)
