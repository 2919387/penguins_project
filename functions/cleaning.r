#Script name: cleaning.r
#Purpose of script: Provides functions needed to clean and filter Palmer Penguin data

#"Cleaning" function: cleans column names, removes empty rows and columns, removes columns starting with delta, and removes the comments column.
cleaning <- function(raw_data){
  raw_data %>%
    clean_names() %>%
    remove_empty(c("rows", "cols")) %>%
    select(-starts_with("delta")) %>%
    select(-comments)
}

#"cleaning_adlie" function: filters the clean data to only include Adelie penguins, removes absent data (NA) for culmen length and body mass, and selects body mass and culmen length as the variables to keep in the data.
cleaning_adelie <- function(data_clean){
  data_clean %>%
    filter(species == "Adelie Penguin (Pygoscelis adeliae)") %>%
    filter(!is.na(culmen_length_mm)) %>%
    filter(!is.na(body_mass_g)) %>%
    select(culmen_length_mm, body_mass_g)
}
