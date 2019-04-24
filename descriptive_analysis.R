#Set Working Directory
setwd("~/Documents/2019 Winter/DSB 6100/goodbelly")

#call read excel library
library("readxl")
df.clean <- data.frame(read_excel (file.choose()));

head(df.clean);
View(df.clean);

#df.raw$Sales_Week <- as.Date(df.raw$Date, "%m/%d/%Y");
#df.raw$Sales_Amount <- round(df.raw$Sales,digits = 2);

#transform to factor variables

df.clean <- transform(df.clean, Sales_Rep = as.factor(Sales_Rep), Endcap = as.factor(Endcap),
                      Demo = as.factor(Demo),Demo1.3 = as.factor(Demo1.3),
                      Demo4.5 = as.factor(Demo4.5), Date = as.Date(Date,"%m/%d/%Y"));

df.clean$Sales_Dollar <- df.clean$Sales * df.clean$ARP

plot(table(df.raw$Region));
plot(table(df.raw$Store));

summary(df.clean)

df.2 <- df.clean[df.clean$Sales < 600,]

# ggplot2 visualizations

library(ggplot2)

plt <- ggplot(data = df.clean)

plt +
  geom_point(mapping = aes(x = Date, y = Sales, color = Region))

plt +
  geom_point(mapping = aes(x = Region, y = Sales))

plt+
  geom_boxplot(mapping = aes(x = factor(Sales_Rep), y = Sales))
#, outlier.colour="black", outlier.shape=16,
 #              outlier.size=2, notch=FALSE)

plt+
  geom_point(mapping = aes(x = factor(Sales_Rep), y = Sales))

plt+
  geom_point(mapping = aes(x = Fitness, y = Sales, color = Region))

plt+
  geom_point(mapping = aes(x = Fitness, y = Sales, color = Region))

plt +
  geom_point(mapping = aes(x = Date, y= Sales_Dollar))
#models

linearMod_1 <- lm(Sales ~ Sales_Rep, data=df.raw)
linearMod_2 <- lm(Sales ~ Demo + Demo1.3 + Demo*Demo1.3, data=df.clean)
linearMod_3 <- lm(Sales ~ Sales_Rep + Endcap +Sales_Rep*Endcap + Demo + Demo4.5, data=df.clean)
linearMod_4 <- lm(Sales ~ Sales_Rep + Endcap +Sales_Rep*Endcap + Demo + Demo4.5, data=df2.clean)
#Residual analysis
par(mfrow = c(2, 2))
plot(linearMod_3,which = (1:4))
summary(linearMod_2)