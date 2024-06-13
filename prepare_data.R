library(magrittr)

system("trident fetch -d aadr-archive --downloadAll --archive aadr-archive")

aadr_archive <- janno::read_janno("aadr-archive", validate = F)

requested_inds <- readr::read_lines(file = "IDselectionDay3.txt", skip = 1)

requested_inds_cleaned <- requested_inds %>%
  stringr::str_split(pattern = " ") %>%
  purrr::map_df(
    \(x) tibble::tibble(
      master_id = x[1],
      publication = x[2],
      group_id = tail(x, n = 1)
    )
  ) %>%
  unique()

aadr_archive_simple <- aadr_archive %>%
  dplyr::transmute(
    Poseidon_ID,
    first_group_name = purrr::map_chr(Group_Name, \(x) x[1]),
    first_alternative_id = purrr::map_chr(Alternative_IDs, \(x) x[1]),
    first_publication = purrr::map_chr(Publication, \(x) x[1])
  )

requested_samples <- dplyr::semi_join(
  aadr_archive_simple,
  requested_inds_cleaned,
  by = c(
    "first_alternative_id" = "master_id",
    "first_group_name" = "group_id",
    "first_publication" = "publication"
  )
)

requested_samples$Poseidon_ID %>%
  paste0("<", ., ">") %>%
  readr::write_lines(file = "forge_list.txt")
