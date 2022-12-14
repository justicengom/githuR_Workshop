#### Install packages ----
install.packages('tidyverse') # dplyr and ggplot2
install.packages('janitor') # cleaning names
install.packages('lubridate') # extracting dates
install.packages('stringr') # extracting strings
install.packages('patchwork') # combining plots
install.packages('palmerpenguins') # the penguin data!

#### Load libraries ----
library(tidyverse)
library(janitor)
library(lubridate)
library(stringr)
library(patchwork)
library(palmerpenguins)

#### Load data ----
data(package = 'palmerpenguins')

#### Explore data ----
penguins_raw <- palmerpenguins::penguins_raw
str(penguins_raw)

penguins <- palmerpenguins::penguins
str(penguins)

#### Wrangle data ----
# clean the column names
# janitor::clean_names()

# select columns to work on & clean names
names(penguins_clean_1)
penguins_clean_1 %>% select(species, island, bill_length_mm = culmen_length_mm, bill_depth_mm = culmen_depth_mm, flipper_length_mm, body_mass_g, sex, year = date_egg) -> penguins_clean_2

# select only year from dates 
# lubridate::year()

# check that they are the same

# select only first name from species list and convert to factor
penguins_clean_2$species <- as.factor(word(penguins_clean_2$species, 1))

# change sex to lower case
penguins_clean_2$sex <- as.factor(tolower((penguins_clean_2$sex)))

# final check
str(penguins_clean_2)
penguins <- penguins_clean_2

#### Data visualisation ----
# correlation plot with all variables
plot(penguins)

# ggplot
ggplot()

# chose the data
ggplot(data = penguins)

# add in mapping aesthetics
# x = body_mass_g, y = bill_length_mm

# chose a geometry to plot

# add the data and mapping arguments to the geom

# add in a 3rd variable as colour

# add in a 3rd variable as colour and shape

# change the opacity of the points

# change the colour of the points and the legend name (for both scales)
# use c('darkorange', 'purple', 'cyan4')

# change the labels of the x and y axes

# change the limits and breaks of the x and y axes

# change the default theme

# change the legend position
# ?theme

#### Facets ----
ggplot(penguins %>% drop_na()) +
  geom_point(aes(body_mass_g, bill_length_mm, col = species, shape = species), alpha = 0.8) +
  scale_colour_manual(values = c('darkorange', 'purple', 'cyan4')) +
  labs(x = 'Body mass (g)', y = 'Bill length (mm)',
       colour = 'Penguin species', shape = 'Penguin species') +  theme_bw() +
  facet_grid(cols = vars(sex))

#### Patchwork ----
plot1 <- ggplot(penguins) +
  geom_point(aes(body_mass_g, bill_length_mm, col = species, shape = species), alpha = 0.8) +
  scale_colour_manual(values = c('darkorange', 'purple', 'cyan4')) +
  labs(x = 'Body mass (g)', y = 'Bill length (mm)',
       colour = 'Penguin species', shape = 'Penguin species') 

plot2 <- ggplot(penguins) +
  geom_point(aes(body_mass_g, flipper_length_mm, col = species, shape = species), alpha = 0.8) +
  scale_colour_manual(values = c('darkorange', 'purple', 'cyan4')) +
  labs(x = 'Body mass (g)', y = 'Flipper length (mm)',
       colour = 'Penguin species', shape = 'Penguin species')  

# combine plots (cols and rows)
combined_plot <- plot1 + plot2
combined_plot

# add annotation
combined_plot + plot_annotation(tag_levels = 'a', tag_suffix = ')')

# control the guides
combined_plot + plot_layout(guides = 'collect')

# add theme style to all plots
combined_plot  &
  theme_minimal() &
  theme(legend.position = 'bottom')

# bring it all together
combined_plot + 
  plot_annotation(tag_levels = 'a', tag_suffix = ')') + 
  plot_layout(guides = 'collect') &
  theme_minimal() &
  theme(legend.position = 'bottom')

#### Save your plot ----
# using ggsave()
ggsave("output/figs/peng_mass_bill_flipper_length.png", device = 'png', bg = 'white', width = 180, height = 80, units = 'mm', dpi = 320)

#### Save plot for Publication ----
ggplot(penguins) +
  geom_point(aes(body_mass_g, bill_length_mm, col = species, shape = species), alpha = 0.8, size = 0.8) +
  scale_colour_manual(values = c('darkorange', 'purple', 'cyan4')) +
  labs(x = 'Body mass (g)', y = 'Bill length (mm)',
       colour = 'Penguin species:', shape = 'Penguin species:') + theme_classic() +
  theme(legend.position = 'top',
        legend.title = element_text(size = 8),
        legend.text = element_text(size = 6),
        axis.title = element_text(size = 8),
        axis.text = element_text(size = 6))

ggsave("output/figs/peng_mass_bill_flipper_length_publication.png", device = 'png', bg = 'white', width = 80, height = 60, units = 'mm', dpi = 600)
