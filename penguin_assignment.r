#Script name: penguin_assignment.r
#Purpose of script: Load and clean Palmer Penguins data, run a statistical test, create a figure


#LOAD THE DATA
#-----------------------------

#The working directory must be set to the directory "penguin_project".

#Install and load packages (found in "libraries.r" in the "functions" directory).
#Note that the package smplot2 (used for the creation the figure) can be downloaded from the following link: https://rdrr.io/github/smin95/sesplot/
source("functions/libraries.r")

#Load function files from "functions" directory
source("functions/cleaning.r")
source("functions/plotting.r")





#CLEANING THE DATA
#-----------------------------
#The raw data (from "palmerpenguins") is saved as a csv file ("penguins_raw_data") in the directory "data_raw". Future modifications will be made to this csv file.
write.csv(penguins_raw, "data_raw/penguins_raw_data.csv")

penguins_raw_data <- read.csv("data_raw/penguins_raw_data.csv")

#The function "cleaning" cleans column names, removes empty rows and columns, removes columns starting with delta, and removes the comments column.
penguins_now_clean <- cleaning(penguins_raw_data)

#Save clean data ("penguins_clean.csv", in "data_clean").
write.csv(penguins_now_clean, "data_clean/penguins_clean.csv")

penguins_clean <- read.csv("data_clean/penguins_clean.csv")

#The function "cleaning_adelie" filters the data to retain only body mass and culmen length for Adelie penguins, and removes rows for which these values are absent.
adelie_now_clean <- cleaning_adelie(penguins_clean)

#Save clean data ("adelie_clean.csv", in "data_clean")
write.csv(adelie_now_clean, "data_clean/adelie_clean.csv")

adelie_clean <- read.csv("data_clean/adelie_clean.csv")





#RUNNING A STATISTICAL TEST
#-----------------------------
#The code below uses a Peason correlation test to investigate if there is a significant correlation between body mass and culmen length in Adelie penguins.

#The Pearson correlation test assumes a normal distribution of both variables. This assumption is investigated by creating QQ plots for culmen length and body mass.
#Create a QQ plot for culmen length
qqplot_culmen <- qqplot_plot(adelie_clean$culmen_length_mm)

#Save QQ plot as pdf ("adelie_culmen_qq_plot.pdf" in "figures")
save_plot(qqplot_culmen, "figures/adelie_culmen_qq_plot.pdf", width = 9, height = 5)

#Create a QQ plot for body length
qqplot_body <- qqplot_plot(adelie_clean$body_mass_g)

#Save QQ plot as pdf ("adelie_body_qq_plot.pdf" in "figures")
save_plot(qqplot_body, "figures/adelie_body_qq_plot.pdf", width = 9, height = 5)

#Both these variables appear normally distributed.

#The Pearson correlation test also assumes a linear relationship between the two variables, with no outliers. This is investigated by creating a scatter-plot of the data.
#Create scatterplot of body mass and culmen length
adelie_scatter <- plot_adelie_scatter(adelie_clean)

#Save scatterplot as pdf ("adelie_scatter.pdf" in "figures")
save_plot(adelie_scatter, "figures/adelie_scatter_plot.pdf", width = 7, height = 5)

#The relationship between the two variables appears linear, with no clear outliers.

#A Pearson correlation test is applied, under the following null and alternative hypotheses.
#H0: The correlation between Adelie body mass and culmen length is equal to 0.
#H1: The correlation between Adelie body mass and culmen length is not equal to 0.
cor.test(adelie_clean$body_mass_g, adelie_clean$culmen_length_mm, method = "pearson")

#Results: This test indicates a significant correlation (p-value = 2.955e-13), with a correlation coefficient (R) of 0.5488658. Thus, the H0 is rejected.





#CREATING A FIGURE
#-----------------------------
#Create a scatterplot with a correlation line
adelie_correlation <- plot_adelie_corr(adelie_clean)

#Save figure as pdf ("adelie_correlation_plot.pdf" in "figures")
save_plot(adelie_correlation, "figures/adelie_correlation_plot.pdf", width = 7, height = 5)
