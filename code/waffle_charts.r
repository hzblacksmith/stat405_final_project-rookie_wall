data <- read.csv('AllRookieData6.0.csv')

bin=rep(0,length(data$pre_nba_group))
for (i in 1:length(bin)){
  if (data$pre_nba_group[i] <= 4 && data$pre_nba_group[i] >= 1) {
  bin[i]="College"
  } else if (data$pre_nba_group[i] >= 5 && data$pre_nba_group[i] <= 8) {
  bin[i]="Intl"
  } else if (data$pre_nba_group[i] == 9) {
  bin[i]="High Schl"
  } else if (data$pre_nba_group[i] == 10) {
  bin[i]="College+Intl"
  }
}
data$pre_nba_group_gen = bin
head(data)

library(ggplot2)
library(dplyr)
library(plyr)
count(data$pre_nba_group_gen)
attach(data)

#################################################################################

# Waffle chart for 4 groups
var <- data$pre_nba_group_gen  # the categorical data 

## Prep data (nothing to change here)
nrows <- 10
df <- expand.grid(y = 1:nrows, x = 1:nrows)
categ_table <- round(table(var) * ((nrows*nrows)/(length(var))))
categ_table

# categ_table[[4]] <- categ_table[[4]]-1
# sum(categ_table)
# 
# df$category <- factor(rep(names(categ_table), categ_table))  
# # NOTE: if sum(categ_table) is not 100 (i.e. nrows^2), it will need adjustment to make the sum to 100.
# 
# ## Plot
# ggplot(df, aes(x = x, y = y, fill = category)) + 
#   geom_tile(color = "black", size = 0.5) +
#   scale_x_continuous(expand = c(0, 0)) +
#   scale_y_continuous(expand = c(0, 0), trans = 'reverse') +
#   scale_fill_brewer(palette = "Set3", labels=c("College","Intl","High Schl","High Schl+Intl")) +
#   xlab("") + 
#   ylab("")

# Use library Waffle
library(waffle)
waffle(categ_table, rows=5, colors=c("#c7d4b6", "#969696", "#1879bf", "#009bda"), 
       title="Rookies Composition",
       xlab="One square ~ 460 ppl")

#################################################################################

# Waffle chart for 10 groups
var <- data$pre_nba_group
bin <- var
cats <- c('Col-1 1-35 Gms','Col-2 36-70 Gms',
         'Col-3 71-105 Gms','Col-4 106+ Gms','Intl-1 1-669 Mins',
         'Intl-2 670-1221 Mins','Intl-3 1222-3328 Mins',
         'Intl-4 3329+ Mins','High School','College+Intl')
for (i in 1:length(bin)) {
  bin[i] = cats[var[i]]
}
var <- bin

## Prep data (nothing to change here)
nrows <- 10
df <- expand.grid(y = 1:nrows, x = 1:nrows)
categ_table <- round(table(var) * ((nrows*nrows)/(length(var))))
categ_table

# categ_table[[2]] <- categ_table[[2]]-1
# categ_table[[4]] <- categ_table[[4]]-1
# sum(categ_table)
# 
# df$category <- factor(rep(names(categ_table), categ_table))  
# # NOTE: if sum(categ_table) is not 100 (i.e. nrows^2), it will need adjustment to make the sum to 100.
# 
# ## Plot
# ggplot(df, aes(x = x, y = y, fill = category)) + 
#   geom_tile(color = "black", size = 0.5) +
#   scale_x_continuous(expand = c(0, 0)) +
#   scale_y_continuous(expand = c(0, 0), trans = 'reverse') +
#   scale_fill_brewer(palette = "Set3", labels=c('Col 1-35 Gms','Col 36-70 Gms',
#                                                'Col 71-105 Gms','Col 106+ Gms','Intl 1-669 Mins',
#                                                'Intl 670-1221 Mins','Intl 1222-3328 Mins',
#                                                'Intl 3329+ Mins','High Schl','High Schl+Intl')) +
#   xlab("") + 
#   ylab("") + 
#   theme(axis.title=element_blank(),
#         axis.text=element_blank(),
#         axis.ticks=element_blank())

# Use library Waffle
library(waffle)
waffle(categ_table, rows=5, colors=c("#C0C0C0","#000000","#FF0000","#FFFF00","#00FF00","#008000","#00FFFF","#0000FF","#FF00FF","#800080"), 
       title="Rookies Composition",
       xlab="One square ~ 472 ppl")

