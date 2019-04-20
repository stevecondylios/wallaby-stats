
# Rugby player stats




#----- Scrape data -----#

library(rvest)
library(dplyr)

first_page <- "http://stats.espnscrum.com/statsguru/rugby/stats/index.html?class=1;page=1;team=6;template=results;type=player"

splash <- first_page %>% read_html

number_of_pages <- splash %>% html_nodes("table") %>% .[5] %>% html_nodes("span") %>% .[1] %>%
  html_text %>% strsplit(., " ") %>% .[[1]] %>% tail(1)



# splash %>% html_nodes("table") %>% .[4] %>% html_table %>% a[[1]][0, ] %>% dput
team_data <- structure(list(Player = character(0), Span = character(0), Mat = integer(0),
                            Start = integer(0), Sub = integer(0), Pts = integer(0), Tries = integer(0),
                            Conv = integer(0), Pens = integer(0), Drop = integer(0),
                            GfM = integer(0), Won = integer(0), Lost = integer(0), Draw = integer(0),
                            `%` = numeric(0), logical(0)), row.names = integer(0), class = "data.frame")


get_data <- function(page_number) {

  page_url <- paste0("http://stats.espnscrum.com/statsguru/rugby/stats/index.html?class=1;page=",
  page_number, ";team=6;template=results;type=player")

  page_url %>% read_html %>% html_nodes("table") %>% .[4] %>% html_table %>% .[[1]]


}


for (i in 1:number_of_pages) {
  print(paste0("Scraping page ", i))
  team_data <- rbind(team_data, get_data(i))


}


team_data %>% head
#             Player      Span Mat Start Sub Pts Tries Conv Pens Drop GfM Won Lost Draw     %
# 1        GM Gregan 1994-2007 139   133   6  99    18    0    0    3   0  93   44    2 67.62 NA
# 2         ST Moore 2005-2017 129    97  32  40     8    0    0    0   0  73   54    2 57.36 NA
# 3 AP Ashley-Cooper 2005-2018 117   111   6 185    37    0    0    0   0  66   48    3 57.69 NA
# 4        NC Sharpe 2002-2012 116   109   7  40     8    0    0    0   0  70   44    2 61.20 NA
# 5         GB Smith 2000-2013 111    93  18  45     9    0    0    0   0  65   44    2 59.45 NA
# 6        MJ Giteau 2002-2016 103    89  14 698    30  106  108    4   0  59   42    2 58.25 NA



team_data$Mat %>% hist(20)










