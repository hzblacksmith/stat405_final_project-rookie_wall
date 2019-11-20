library(XML)
library(RCurl)
data <- read.csv('Downloads/AllRookieDataWithURL.csv')
urls <- unique(as.character(data$br_url))
nurls <- length(urls)
#url, year, games, minutes
intl_df = data.frame(
  Name=numeric(),
  Year=numeric(),
  Game=numeric(), 
  Minute=numeric()) 

for (i in 1:nurls) {
  name = urls[i]
  cur_url <- paste0("https://www.basketball-reference.com/international/players/", urls[i],".html")
  count = 1
  if (url.exists(url = cur_url)) {
    # print(cur_url)
    download.file(cur_url, destfile = "international.html")
    doc <- htmlParse("international.html")
    
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
    print(name)
    while (!is.na(year)) {
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




