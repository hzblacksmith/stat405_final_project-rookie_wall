import pandas as pd
import numpy as np

df = pd.read_csv("AllRookieData_GS.csv")
print(df.columns)
def change_wl_to_10(df):
    outcome = {'W': 1, "L": 0}
    df['outcome'] = [outcome[i] for i in df['outcome']]


def calc_gs(df):
    gs = np.empty([len(df['X']), 1])
    for i in range(len(df['X'])):
        gs[i] = df["Points"][i] + 0.4 * df['Field_Goals'][i] + \
                              0.7 * df['Offensive_Rebounds'][i] + 0.3 * df['Defensive_Rebounds'][i] + \
                              df['Steals'][i] + 0.7 * df['Assists'][i] + 0.7 * df['Blocked_Shots'][i] - \
                              0.7 * df['Field_Goals_Attempted'][i] - \
                              0.4 * (df['Free_Throws_Attempted'][i] - df['Free_Throws'][i]) - \
                              0.4 * df['Personal_Fouls'][i] - df['Turnovers'][i]
        print(("{} is done!").format(i))
        print(gs[i])
    print(gs)
    df = pd.concat([df, pd.DataFrame(gs)], axis=1)
    df.rename(columns={0: 'game_score'}, inplace=True)
    print('Finished!')
    print(df.head(20))
    return df

# (Points)+0.4*(Field Goals Made)+0.7*(Offensive Rebounds)+0.3*(Defensive rebounds)+(Steals)+0.7*(Assists)+
# 0.7*(Blocked Shots)- 0.7*(Field Goal Attempts)-0.4*(Free Throws Missed) – 0.4*(Personal Fouls)-(Turnovers)


df = calc_gs(df)
df.to_csv('AllRookieDataGS.csv')
