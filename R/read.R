jn_read <- function(path = 'data-raw/cnj') {
  arqs <- dir(path, full.names = TRUE)
  m <- purrr::map(arqs, purrr::quietly(~{
    readr::read_csv2(.x, locale = readr::locale(encoding = 'latin1'))
  })) %>%
    purrr::map('result') %>%
    rlang::set_names(basename(arqs)) %>%
    tibble::enframe('nome', 'dados') %>%
    dplyr::mutate(dados = rlang::set_names(dados, basename(arqs)))
  m
}
