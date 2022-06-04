library(tidyverse)
library(GGally)

load("StudentUSI.RData")

#Plot 1
plot1 <- ggcorr(grade)
plot1
ggsave(file="t1-plot2.svg", plot=plot1, width=10, height=8)

#Plot 2
df <- grade %>%
  group_by(country) %>%
  count()
df$country <- c("Austria", "Switzerland", "Germany")

plot2 <- ggplot(df, aes(x="", y=n, fill=country)) +
  geom_col() +
  coord_polar(theta = "y") +
  labs(fill="Nationality of Students") +
  theme_void()
plot2

ggsave(file="t1-plot2.svg", plot=plot3, width=10, height=8)

#Plot 3
plot3 <- ggplot(grade, aes(x = econ, fill = gender)) + geom_density(alpha = 0.5) + theme_classic()
plot3
ggsave(file="t1-plot3TaskT", plot=plot3, width=20, height=6)
