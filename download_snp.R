library(tidyverse)
library(tidyquant)

tickers <- tq_index("SP500")$symbol

clean_symbol <- function(x) {
  getSymbols(x, from = '2021-11-14',
             to = "2022-11-14", warnings = FALSE,
             auto.assign = FALSE) %>%
    data.frame() %>%
    rownames_to_column("time") %>%
    mutate(time = as.Date(time)) %>%
    rename_all(str_remove_all, "\\w*[.]") %>%
    janitor::clean_names()
}

snp_df <- tq_index("SP500") %>%
  splitted_mutate(
    data = map(symbol, clean_symbol)
  )

snp_df <- snp_df %>%
  select(symbol, data) %>%
  unnest(data)


write_csv(snp_df, "visualisation2_files/snp.csv")

granatlib::notification()
