library(XML)
library(RCurl)
#milos teodosic
data <- read.csv('Downloads/AllRookieDataWithURL.csv')
f2 <- function(x) { u <- unique(x) ; data.frame(uniqueValue=u, firstIndex=match(u, x))}
# select first index of unique elements (matching the draft year)
index = f2(data$br_url)$firstIndex
urls <- unique(as.character(data$br_url))
nurls <- length(urls)
#url, year, games, minutes
intl_df = data.frame(
  Name=numeric(),
  Year=numeric(),
  Game=numeric(), 
  Minute=numeric()) 
compute_intl_df <- function(nurls) {
  
}

for (i in 1:nurls) {
  name = urls[i]
  cur_url <- paste0("https://www.basketball-reference.com/international/players/", urls[i],".html")
  count = 1
  if (url.exists(url = cur_url)) {
    # print(cur_url)
    download.file(cur_url, destfile = "international.html")
    doc <- htmlParse("international.html")
    draft_year = data[index[i], ]$season_id
    
    # //*[@id="totals-all-reg"]/tbody/tr[1]/th/a
    xpath_yr = paste0("//*[@id=\"totals-all-reg\"]/tbody/tr[", count,"]/th/a")
    yr <- getNodeSet(doc, xpath_yr)
    year = as.numeric(substr(as.character(xmlValue(yr[[1]])), 1, 4))
    
    xpath_g = paste0("//*[@id=\"totals-all-reg\"]/tbody/tr[", count, "]/td[4]")
    g = getNodeSet(doc, xpath_g)
    games = as.numeric(xmlValue(g[[1]]))
    
    xpath_mi = paste0("//*[@id=\"totals-all-reg\"]/tbody/tr[", count, "]/td[5]")
    mi <- getNodeSet(doc, xpath_mi)
    minutes = as.numeric(xmlValue(mi[[1]]))
    # print(minutes)
    # print(name)
    while (!is.na(year) & year < draft_year) {
      if (urls[i] == "milos-teodosic-1") {
        print(year)
      }
      intl_df[nrow(intl_df) + 1, ] = c(name, as.numeric(year), as.numeric(games), as.numeric(minutes))
      count = count + 1
      xpath_yr = paste0("//*[@id=\"totals-all-reg\"]/tbody/tr[", count,"]/th/a")
      yr <- getNodeSet(doc, xpath_yr)
      year = as.numeric(substr(as.character(xmlValue(yr[[1]])), 1, 4))
      
      xpath_g = paste0("//*[@id=\"totals-all-reg\"]/tbody/tr[", count, "]/td[4]")
      g = getNodeSet(doc, xpath_g)
      games = as.numeric(xmlValue(g[[1]]))
      
      xpath_mi = paste0("//*[@id=\"totals-all-reg\"]/tbody/tr[", count, "]/td[5]")
      mi <- getNodeSet(doc, xpath_mi)
      minutes = as.numeric(xmlValue(mi[[1]]))
    }
    free(doc)
  }
}

intl_df$Game = as.numeric(intl_df$Game)
intl_df$Minute = as.numeric(intl_df$Minute)
# sum up minutes and points
new_df = aggregate(cbind(Game_INTL=intl_df$Game, Minute_INTL=intl_df$Minute), by=list(Name=intl_df$Name), FUN=sum)

quantile(new_df$Minute)
new_df$group[new_df$Minute >= 2 & new_df$Minute < 530] = 1
new_df$group[new_df$Minute >= 530 & new_df$Minute < 1125] = 2
new_df$group[new_df$Minute >= 1125 & new_df$Minute < 3061] = 3
new_df$group[new_df$Minute >= 3061 & new_df$Minute <= 13659] = 4
write.csv(intl_df,"Desktop/intl_game_min_per_season_before_NBA.csv", row.names = FALSE)
write.csv(new_df,"Desktop/intl_game_min_before_NBA.csv", row.names = FALSE)

rookie <- read.csv('Desktop/AllRookieDataGS.csv')
rookie <- read.csv('Desktop/AllRookieDataGS.csv')
# str(rookie)
# head(rookie$Date_EST)
rookie$Month = as.numeric(substr(rookie$Date_EST, 1, 2))
rookie$MonthBin[as.numeric(substr(rookie$Date_EST, 4, 5)) <= 10] = 1
rookie$MonthBin[as.numeric(substr(rookie$Date_EST, 4, 5)) <= 20 & as.numeric(substr(rookie$Date_EST, 4, 5)) > 10] = 2
rookie$MonthBin[as.numeric(substr(rookie$Date_EST, 4, 5)) > 20] = 3

