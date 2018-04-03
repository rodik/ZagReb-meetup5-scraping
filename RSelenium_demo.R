# install.packages("RSelenium")
library(RSelenium)

remDr <- remoteDriver(browser = "chrome", port=4444)

# open browser
remDr$open()

# starting url
home_url <- "http://www.google.com/ncr"

# navigate page
remDr$navigate(home_url)

# find textbox
webElem <- remDr$findElement(using = "css", "[name = 'q']")

Sys.sleep(3)
webElem$sendKeysToElement(list("open "))
Sys.sleep(1)
webElem$sendKeysToElement(list("data "))
Sys.sleep(1)
webElem$sendKeysToElement(list("hrvatska", key = "enter"))


# demo 2 with click
# navigate page
remDr$navigate(home_url)

# find textbox
webElem <- remDr$findElement(using = "css", "[name = 'q']")

Sys.sleep(3)
webElem$sendKeysToElement(list("r users zagreb"))
Sys.sleep(1)
btnGoogleSearch <- remDr$findElement(using = "name", "btnK")
Sys.sleep(1)
btnGoogleSearch$highlightElement(wait = 2)
Sys.sleep(1)
btnGoogleSearch$clickElement()
