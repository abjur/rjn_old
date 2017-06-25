jn_download <- function(dest = 'data-raw/cnj') {
  u_inicial <- 'http://www.cnj.jus.br/programas-e-acoes/pj-justica-em-numeros/2013-01-04-19-13-21'
  r <- httr::GET(u_inicial)
  u_download <- r %>%
    httr::content('text') %>%
    xml2::read_html() %>%
    rvest::html_node(xpath = '//a[contains(text(), "dados")]') %>%
    rvest::html_attr('href')
  u_download <- sprintf('http://www.cnj.jus.br%s', u_download)
  dir.create(dest, recursive = TRUE, showWarnings = FALSE)
  zip_file <- sprintf('%s/%s', dest, "dados.zip")
  r_download <- httr::GET(u_download, httr::write_disk(zip_file, overwrite = TRUE))
  unzip(zipfile = zip_file, exdir = dest)
  file.remove(zip_file)
  invisible(dest)
}
