import pandas as pd

df = pd.read_csv("data/nba_draft_1997_2018.csv")
data = pd.read_csv("data/AllRookieData7.0.csv")
data['pre_nba_group_str'] = data['pre_nba_group'].astype(str).replace({
    str(1): '1 (NCAA)',
    str(2): '2 (NCAA)',
    str(3): '3 (NCAA)',
    str(4): '4 (NCAA)',
    str(5): '5 (INTL)',
    str(6): '6 (INTL)',
    str(7): '7 (INTL)',
    str(8): '8 (INTL)',
    str(9): '9 (HS)',
    str(10): '10 (Both)'})

# data['MonthStr'] = data['Month'].astype(str).replace({str(1): '4 (Jan)', str(2): '5 (Feb)', str(3): '6 (Mar)', str(4): '7 (Apr)',
#                                    str(5): '8 (May)', str(6): '9 (June)', str(10): '1 (Oct)', str(11): '2 (Nov)',
#                                    str(12): '3 (Dec)'})
# data['year'].fillna(data.season_id, inplace=True)
# data['round'].fillna(3, inplace=True)
# data['pick'].fillna(61, inplace=True)
# data['intl_game'].fillna(0, inplace=True)
# data['intl_minutes'].fillna(0, inplace=True)
# data['intl_group'].fillna(0, inplace=True)
# data['cbb_games'].fillna(0, inplace=True)
# data['cbb_minutes'].fillna(0, inplace=True)
# data['cbb_group'].fillna(0, inplace=True)

data.to_csv("data/AllRookieData7.0.csv", index=False)
# df['First'] = df['First'].replace({'\'': '', '\\.': ''}, regex=True)

# df.to_csv("data/nba_draft_1997_2018_parsed.csv", index=False)


