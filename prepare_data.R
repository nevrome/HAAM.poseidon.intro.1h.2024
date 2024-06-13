library(magrittr)

aadr_archive <- janno::read_janno("~/agora/aadr-archive/", validate = F)

requested_inds <- readr::read_lines(file = "~/Downloads/IDselectionDay3.txt", skip = 1)

requested_inds_cleaned <- requested_inds %>%
  stringr::str_split(pattern = " ") %>%
  purrr::map_df(\(x) tibble::tibble(master_id = head(x, n = 1), group_id = tail(x, n = 1))) %>%
  unique()

aadr_archive_simple <- aadr_archive %>%
  dplyr::transmute(
    Poseidon_ID,
    first_group_name = purrr::map_chr(Group_Name, \(x) head(x, n = 1)),
    first_alternative_id = purrr::map_chr(Alternative_IDs, \(x) head(x, n = 1))
  )

requested_samples <- dplyr::semi_join(
  aadr_archive_simple,
  requested_inds_cleaned,
  by = c(c("first_alternative_id" = "master_id", "first_group_name" = "group_id"))
)

requested_samples$Poseidon_ID %>%
  paste0("<", ., ">") %>%
  readr::write_lines(file = "forge_list.txt")
