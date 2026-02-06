# Load necessary libraries
library(factoextra)

setwd("a:/ECU/Data Science Masters/Multivar/Module 8/worksheet")

# Load
pizza_data <- read.csv("Pizza-1.csv")

str(pizza_data) # check data

# Extract the features
pizza_features <- pizza_data[, 2:8]; pizza_features

# Standardize 
pizza_features_scaled <- scale(pizza_features)

# Perform PCA
pca.mod <- prcomp(pizza_features_scaled)

# Scree Plot 
fviz_eig(pca.mod)

# Correlation between each original variable and the first three principal components
cor.Moisture.PC1 <- cor(pizza_data$Moisture, pca.mod$x[,1]); cor.Moisture.PC1
cor.Protein.PC1 <- cor(pizza_data$Protein, pca.mod$x[,1]); cor.Protein.PC1
cor.Fat.PC1 <- cor(pizza_data$Fat, pca.mod$x[,1]); cor.Fat.PC1
cor.Ash.PC1 <- cor(pizza_data$Ash, pca.mod$x[,1]); cor.Ash.PC1
cor.Sodium.PC1 <- cor(pizza_data$Sodium, pca.mod$x[,1]); cor.Sodium.PC1
cor.Carbohydrate.PC1 <- cor(pizza_data$Carbohydrate, pca.mod$x[,1]); cor.Carbohydrate.PC1
cor.Calories.PC1 <- cor(pizza_data$Calories, pca.mod$x[,1]); cor.Calories.PC1

cor.Moisture.PC2 <- cor(pizza_data$Moisture, pca.mod$x[,2]); cor.Moisture.PC2
cor.Protein.PC2 <- cor(pizza_data$Protein, pca.mod$x[,2]); cor.Protein.PC2
cor.Fat.PC2 <- cor(pizza_data$Fat, pca.mod$x[,2]); cor.Fat.PC2
cor.Ash.PC2 <- cor(pizza_data$Ash, pca.mod$x[,2]); cor.Ash.PC2
cor.Sodium.PC2 <- cor(pizza_data$Sodium, pca.mod$x[,2]); cor.Sodium.PC2
cor.Carbohydrate.PC2 <- cor(pizza_data$Carbohydrate, pca.mod$x[,2]); cor.Carbohydrate.PC2
cor.Calories.PC2 <- cor(pizza_data$Calories, pca.mod$x[,2]); cor.Calories.PC2

cor.Moisture.PC3 <- cor(pizza_data$Moisture, pca.mod$x[,3]); cor.Moisture.PC3
cor.Protein.PC3 <- cor(pizza_data$Protein, pca.mod$x[,3]); cor.Protein.PC3
cor.Fat.PC3 <- cor(pizza_data$Fat, pca.mod$x[,3]); cor.Fat.PC3
cor.Ash.PC3 <- cor(pizza_data$Ash, pca.mod$x[,3]); cor.Ash.PC3
cor.Sodium.PC3 <- cor(pizza_data$Sodium, pca.mod$x[,3]); cor.Sodium.PC3
cor.Carbohydrate.PC3 <- cor(pizza_data$Carbohydrate, pca.mod$x[,3]); cor.Carbohydrate.PC3
cor.Calories.PC3 <- cor(pizza_data$Calories, pca.mod$x[,3]); cor.Calories.PC3

# Combine the correlations into a matrix
cor.PC1 <- c(cor.Moisture.PC1, cor.Protein.PC1, cor.Fat.PC1, cor.Ash.PC1, cor.Sodium.PC1, cor.Carbohydrate.PC1, cor.Calories.PC1)
cor.PC2 <- c(cor.Moisture.PC2, cor.Protein.PC2, cor.Fat.PC2, cor.Ash.PC2, cor.Sodium.PC2, cor.Carbohydrate.PC2, cor.Calories.PC2)
cor.PC3 <- c(cor.Moisture.PC3, cor.Protein.PC3, cor.Fat.PC3, cor.Ash.PC3, cor.Sodium.PC3, cor.Carbohydrate.PC3, cor.Calories.PC3)
cor.PC <- cbind(cor.PC1, cor.PC2, cor.PC3)

# Assign row names (the original variables)
rownames(cor.PC) <- colnames(pizza_data[, 2:8])

# Display the correlation matrix rounded to 3 decimal places
round(cor.PC, 3)


# Visualize the PCA biplot to show both the variables and the individual data points
fviz_pca_biplot(pca.mod, geom.ind = "point", pointshape = 21, 
                pointsize = 2, 
                fill.ind = pizza_data$Brand, 
                col.ind = "#696969", 
                palette = "jco", 
                addEllipses = TRUE,
                label = "var",
                col.var = "black",
                repel = TRUE,
                legend.title = "Brand")



# Show the proportion of variance explained by each principal component
summary(pca.mod)

library(plotly)

# Get the loadings for each factor
loadings <- pca.mod$rotation[, 1:3]; loadings

# Color palette for the loadings
loading_colors <- c('red', 'blue', 'green', 'purple', 'orange', 'pink')  # Use distinct colors for loadings

# Create the 3D scatter plot 
fig <- plot_ly() %>%
  add_trace(x = PC1, y = PC2, z = PC3, 
            type = "scatter3d", mode = "markers",
            split = pizza_data$Brand,  # Group by Brand to differentiate in legend
            marker = list(size = 5))  # Add label for PCA scores

# Add arrows for each factor
for (i in 1:nrow(loadings)) {
  fig <- fig %>%
    add_trace(type = 'scatter3d', mode = 'lines',
              x = c(0, loadings[i, 1]),  
              y = c(0, loadings[i, 2]), 
              z = c(0, loadings[i, 3]),  
              line = list(color = loading_colors[i], width = 6),  # Assign a different color to each loading
              text = rownames(loadings)[i],
              hoverinfo = 'text',
              name = paste(rownames(loadings)[i]))  # Add a label for each loading
}

# Add axis labels and title
fig <- fig %>% layout(scene = list(xaxis = list(title = 'PC1'),
                                   yaxis = list(title = 'PC2'),
                                   zaxis = list(title = 'PC3')),
                      title = "3D PCA Plot with Loadings",
                      legend = list(x = 1.05, y = 1))  

# Show the plot
fig








