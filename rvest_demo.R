# install.packages("rvest")


# definiraj staticni dio URL-a
url_root <- "http://www.index.hr/arhiva/vijesti/"
# definiraj pocetni datum
datum <- as.Date("2018-01-01")

# format(datum, "%Y/%m/%d")
datum_string <- paste(
    format(datum,"%Y"),
    as.numeric(format(datum, "%m")),
    as.numeric(format(datum, "%d")),
    sep = "/"
)
# napravi puni URL
url <- paste0(url_root, datum_string) 
url

# inicijaliziraj df
index_arhiva <- data.frame()
# procitaj stranicu
arhiva_html <- read_html(url)
# procitaj trenutnu stranicu kao data.frame
trenutne_vijesti <- arhiva_html %>%
    html_nodes(".arhivaBox") %>% # trazi class
    ldply(obradi.node) # parsiraj svaki node funkcijom koja izvlaci atribute

# data "cleaning"
trenutne_vijesti <- trenutne_vijesti %>% # razbij podnaslov na dvije kolone
    mutate(
        vrijeme = gsub("/.*", "", podnaslov) %>% # uzmi sve prije '/'
                    trimws() %>% # trim whitespace
                    strptime("%d.%m.%Y. %H:%M:%S") %>% # pretvori u datetime
                    as.POSIXct(), # cast as.POSIXct
        kategorija = gsub(".*/", "", podnaslov) %>% # uzmi sve nakon '/'
                        trimws() # trim whitespace
    ) %>% 
    select(
        -podnaslov # makni staru kolonu
    ) # %>% View()

# dodaj sve procitano u glavnu kolekciju
index_arhiva <- rbind(index_arhiva, trenutne_vijesti)    

# TODO: dodati petlju koja ide po danima ...

