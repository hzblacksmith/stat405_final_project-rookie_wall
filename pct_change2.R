library(ggplot2)
library(scales)
library(zoo)
library(dplyr)
df <- read.csv("Downloads/AllRookieData7.0.csv")
lvl2 = c(10,11,12,1,2,3,4,5,6)

df = subset(df, Game_id < 40000000)

df7 <-
  df %>%
  filter(draft_group == 3) %>%
  group_by(pre_nba_group, Month) %>%
  dplyr::summarise(size = n(), mean_gs=mean(game_score_per_36))
df7 = subset(df7, size > 10)

df7$type[df7$pre_nba_group <= 4] = "NCAA"
df7$type[df7$pre_nba_group > 4 & df7$pre_nba_group < 9] = "INTL"
df7$type[df7$pre_nba_group == 9] = "HIGH"
df7$type[df7$pre_nba_group == 10] = "BOTH"

new_df2 = df7[order(df7$pre_nba_group, factor(df7$Month, levels = lvl2)),]

new_df2 = new_df2 %>%
  mutate(pct_change = (mean_gs/lag(mean_gs) - 1) * 100)

# new_df = read.csv("Desktop/new2.csv")
df8 = aggregate(new_df2[, 6], list(new_df2$type, new_df2$Month), mean)
names(df8)[1]<-paste("type")
names(df8)[2]<-paste("month")
names(df8)[3]<-paste("mean_pct_change")

df9 = merge(x = new_df2, y = df8, by.x=c("type","Month"), by.y=c("type","month"), all.x = TRUE)
df9 = df9[order(factor(df9$Month, levels = lvl2)),]

df9 = subset(df9, df9$pre_nba_group < 5 | df9$pre_nba_group == 10)

df1 <-
  df %>%
  group_by(pre_nba_group, Month) %>%
  dplyr::summarise(size = n(), mean_gs=mean(game_score_per_36))
# summarise(group_by(df, pre_nba_group, Month), mean_gs=mean(game_score), size = n())
df1 = subset(df1, size > 10)

df1$type[df1$pre_nba_group <= 4] = "NCAA"
df1$type[df1$pre_nba_group > 4 & df1$pre_nba_group < 9] = "INTL"
df1$type[df1$pre_nba_group == 9] = "HIGH"
df1$type[df1$pre_nba_group == 10] = "BOTH"


new_df = df1[order(df1$pre_nba_group, factor(df1$Month, levels = lvl2)),]

new_df = new_df %>%
  mutate(pct_change = (mean_gs/lag(mean_gs) - 1) * 100)

# new_df = read.csv("Desktop/new2.csv")
df2 = aggregate(new_df[, 6], list(new_df$type, new_df$Month), mean)
names(df2)[1]<-paste("type")
names(df2)[2]<-paste("month")
names(df2)[3]<-paste("mean_pct_change")

df4 = merge(x = new_df, y = df2, by.x=c("type","Month"), by.y=c("type","month"), all.x = TRUE)
df4 = df4[order(factor(df4$Month, levels = lvl2)),]

df5 = subset(df4, type == "NCAA")

df4$college[df4$pre_nba_group == 1 | df4$pre_nba_group == 9] = "T"
df4$college[!(df4$pre_nba_group == 1 | df4$pre_nba_group == 9)] = "F"

df6 = subset(df4, college == "T")

cols <- c('1'='greenyellow','2'='forestgreen','3'='dodgerblue','4'='darkorchid1','5'='yellow',
          '6'='orange','7'='darksalmon','8'='firebrick3', '9'="black",'10'='slateblue1')

ggplot(df4, aes(x = factor(Month, levels = lvl2), y = pct_change, group = pre_nba_group, color = 'pre_nba_group')) + 
  # geom_point(aes(color = factor(pre_nba_group), shape = '.')) +
  xlab("Months") +
  ylab("Percentage") + 
  ggtitle("Change in percentage of regular season game score through month") + 
  theme(
    title = element_text(size = 12),
    axis.text.x = element_text(size = 8)) +
  scale_color_manual(
    values = cols,
    labels=c(
      'Col 1-35 Gms','Col 36-70 Gms','Col 71-105 Gms','Col 106+ Gms',
      'Intl 1-681 Mins','Intl 682-1248 Mins','Intl 1249-3278 Mins','Intl 3279+ Mins',
      'HS', 'Both experiences')) +
  geom_line(aes(color = factor(pre_nba_group)))

ggplot(df4, aes(x = factor(Month, levels = lvl2), y = mean_pct_change, group = type, color = 'type')) + 
  geom_point(aes(color = factor(type), size = size)) +
  xlab("Months") +
  ylab("Percentage") + 
  ggtitle("Change in percentage of regular season game score through month") + 
  theme(
    title = element_text(size = 12),
    axis.text.x = element_text(size = 8)) +
  geom_line(aes(color = factor(type)))

ggplot(df5, aes(x = factor(Month, levels = lvl2), y = pct_change, group = pre_nba_group, color = 'pre_nba_group')) + 
  geom_point(aes(color = factor(pre_nba_group), size = size)) +
  xlab("Months") +
  ylab("Percentage") + 
  ggtitle("Change in percentage of regular season game score through month") + 
  theme(
    title = element_text(size = 12),
    axis.text.x = element_text(size = 8)) +
  scale_color_manual(
    values = c('1'='greenyellow','2'='orange','3'='dodgerblue','4'='firebrick3'),
    labels=c('Col 1-35 Gms','Col 36-70 Gms','Col 71-105 Gms','Col 106+ Gms')) +
  geom_line(aes(color = factor(pre_nba_group)))

df6$pre_nba_group[df6$pre_nba_group == 1] = "Col 1-35 Gms"
df6$pre_nba_group[df6$pre_nba_group == 9] = "High School"
ggplot(data = df6, mapping = aes(x = factor(Month, levels = lvl2), y = pct_change, group = pre_nba_group)) + 
  geom_point(aes(color = factor(pre_nba_group), size = size)) +
  xlab("Months") +
  ylab("Percentage") +
  ggtitle("Change in percentage of regular season game score through month") +
  theme(
    title = element_text(size = 12),
    axis.text.x = element_text(size = 8)) +
  geom_line(aes(color = factor(pre_nba_group)))

ggplot(df9, aes(x = factor(Month, levels = c(10, 11,12,1,2,3,4)), y = mean_pct_change, group = type, color = type)) + 
  geom_point(aes(color = factor(type), size = size)) +
  xlab("Months") +
  ylab("Percentage") + 
  ggtitle("College Undrafted Players vs Oversea Undrafted Players") + 
  theme(
    title = element_text(size = 12),
    axis.text.x = element_text(size = 8)) +
  geom_line(aes(color = factor(type)))
