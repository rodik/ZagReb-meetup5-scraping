library(rvest)
library(magrittr)
library(plyr)
library(dplyr)

# pomocne funkcije

emptyCharToNA <- function(x){
    if (identical(x, character(0)))
        NA_character_
    else
        x
}

obradi.node <- function(node){
    tryCatch({
        data.frame(
            url = node %>% 
                    html_attr("href") %>% 
                    emptyCharToNA(),
            naslov = node %>% 
                        html_node(".naslov") %>% 
                        html_text() %>% 
                        emptyCharToNA(),
            podnaslov = node %>% 
                            html_node(".podnaslov") %>% 
                            html_text() %>% 
                            emptyCharToNA(),
            opis = node %>% 
                    html_children() %>% 
                    extract(3) %>% 
                    html_text() %>% 
                    emptyCharToNA()
        )
    }, warning = function(w) {
        #warning-handler-code
    }, error = function(e) {
        print(node) # printaj node na kojem je puklo
    }, finally = {
        #cleanup-code
    })
}
