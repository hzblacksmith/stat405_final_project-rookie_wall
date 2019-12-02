import pandas as pd

df = pd.read_csv("data/nba_draft_1997_2018.csv")
data = pd.read_csv("data/AllRookieDataWithDraftPos.csv")
data['year'].fillna(data.season_id, inplace=True)
data['round'].fillna(3, inplace=True)
data['pick'].fillna(61, inplace=True)
data['intl_game'].fillna(0, inplace=True)
data['intl_minutes'].fillna(0, inplace=True)
data['intl_group'].fillna(0, inplace=True)
data['cbb_games'].fillna(0, inplace=True)
data['cbb_minutes'].fillna(0, inplace=True)
data['cbb_group'].fillna(0, inplace=True)

data.to_csv("data/AllRookieData4.0.csv", index=False)
# df['First'] = df['First'].replace({'\'': '', '\\.': ''}, regex=True)

# df.to_csv("data/nba_draft_1997_2018_parsed.csv", index=False)


