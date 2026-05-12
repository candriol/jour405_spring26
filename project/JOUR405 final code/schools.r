eada_raw <- read_csv("final_project.Rmd - Sheet1.csv", show_col_types = FALSE)
success  <- read_csv("mbb_stats.csv", show_col_types = FALSE)
lookup <- read_csv("school_lookup.csv", show_col_types = FALSE) |>
  distinct(UNITID, School)  # drop Institution Name / match_type / name_dist

# Season in success looks like "2013-2014". The EADA Survey Year (2014)
# corresponds to the END of that season, so extract the second year.
success <- success |>
  mutate(season_end_year = as.integer(str_sub(Season, -4)))

success <- success |>
  distinct(School, season_end_year, .keep_all = TRUE)

joined <- eada_raw |>
  inner_join(lookup, by = "UNITID") |>
  inner_join(success,
             by = c("School", "Survey Year" = "season_end_year"))