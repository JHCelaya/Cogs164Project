for (package in c("httr", "jsonlite", "glue", "utils", "here", "dplyr")) {
  suppressWarnings(
    suppressPackageStartupMessages(
      library(package, character.only = TRUE)
      )
    )
}

get_raw_data <- function(osf_address = "xmjz9") {

  print(glue("\nDownloading data\n"))

  zip_path <- here("..","data","raw_data.zip")

  glue::glue("https://files.osf.io/v1/resources/{osf_address}/providers/osfstorage/?zip=") %>%
    curl::curl_download(zip_path, quiet = FALSE)

  utils::unzip(
    zip_path,
    overwrite = TRUE,
    exdir = fs::path_ext_remove(zip_path)
  )

  file.remove(zip_path)
}
