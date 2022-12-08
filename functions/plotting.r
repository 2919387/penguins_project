#Script name: plotting.r
#Purpose of script: Contains functions used to create figures and save them as pdfs

#Create QQ plots with a 95% confidence interval for body mass and culmen length
qqplot_plot <- function(data){
  ggqqplot(data) +
  labs(title = "QQ plot with a 95% Confidence Interval")
}

#Create a scatterplot showing body mass and culmen length
plot_adelie_scatter <- function(data){
  data %>%
  ggplot(aes(x = body_mass_g, y = culmen_length_mm)) +
  geom_point(colour = "black", alpha = 0.4) +
  theme_bw() +
  labs(title = "Scatter-plot of body mass and culmen length in Adelie penguins",
        x = "Body mass (g)",
        y = "Culmen length (mm)")
}

#Create a scatterplot with a correlation line, 95% confidence interval, the correlation coefficient and p-value of the correlation.
plot_adelie_corr <- function(data){
  data %>%
  ggplot(aes(x = body_mass_g, y = culmen_length_mm)) +
  geom_point(colour = "black", alpha = 0.4) +
  sm_statCorr(corr_method = "pearson", colour = "blue", se = TRUE) +
  theme_bw() +
  labs(title = "Correlation between body mass and culmen length in Adelie penguins",
        x = "Body mass (g)",
        y = "Culmen length (mm)")
}

#Save figure as pdf (under given file name), adjust width and height
save_plot <- function(data, filename, width, height){
  pdf(file = filename, width, height)
  print(data)
  dev.off()
}
