# install.packages("raster")  #설치시 rgdal을 같이 설치해야 함.
# install.packages("rgdal")
# install.packages("e1071")


# Load and plot the scanned map
library(raster)

setwd("D:/R_files/RWorkspace/R/R/ADSP")
iraq.img <- brick("iraq_oil_2003.jpg")
plotRGB(iraq.img)

# Load images with the (pre-classified) training data
training.ppl.img <- brick("iraq_pipelines_train.jpg")
training.noppl.img <- brick("iraq_nopipelines_train.jpg")

# Put training data into data frame
training.ppl.df <- data.frame(getValues(training.ppl.img))
names(training.ppl.df) <- c("r", "g", "b")
# Remove white background pixels
training.ppl.df <- training.ppl.df[(training.ppl.df$r < 254 & training.ppl.df$g < 254 & training.ppl.df$b < 254),]
# Create new variable indicating pipeline pixels
training.ppl.df$pipeline <- "P"
# Do the same for the non-pipeline image
training.noppl.df <- data.frame(getValues(training.noppl.img))
# etc...
names(training.noppl.df) <- c("r", "g", "b")
# Remove white background pixels
training.noppl.df <- training.noppl.df[(training.noppl.df$r < 254 & training.noppl.df$g < 254 & training.noppl.df$b < 254),]
# Create new variable indicating pipeline pixels
training.noppl.df$pipeline <- "B"

# Combine data frames and subset only 5000 random values from the non-pipeline training data
training.df <- rbind(training.ppl.df, training.noppl.df[sample(nrow(training.noppl.df), 5000),])
# Turn classification variable into factor
training.df$pipeline <- as.factor(training.df$pipeline)

# Divide training data into a train-subset and a test-subset
train <- sample(nrow(training.df), round((nrow(training.df) - 1) / 2, 0))
test <- c(1:nrow(training.df))[!(c(1:nrow(training.df)) %in% train)]
trainset.df <- training.df[train,]
testset.df <- training.df[test,]

# Fit best SVM using tuning
require(e1071)
svm.fit <- best.svm(pipeline~., data = trainset.df, gamma = 10^(-6:-1), cost = 10^(-1:1))
# Fit predictions and print error matrix
svm.pred <- predict(svm.fit, testset.df[,1:3])
svm.tab <- table(pred = svm.pred, true = testset.df[,4])
print(svm.tab)

# Fit tuned SVM to entire training set
svm.fit <- best.svm(pipeline~., data = training.df, gamma = 10^(-6:-1), cost = 10^(-1:1))
# Prepare Iraq map for predictions
iraq.df <- data.frame(getValues(iraq.img))
names(iraq.df) <- c("r", "g", "b")
# Assign predicted values to target map
iraq.pred <- predict(svm.fit, iraq.df)
iraq.class <- ifelse(iraq.pred == "P", 1, 0)
classified.img <- iraq.img[[1]]
values(classified.img) <- iraq.class