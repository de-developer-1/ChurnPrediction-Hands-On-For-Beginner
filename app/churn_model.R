library(data.table)
library(caret)
library(xgboost)

data <- fread("app/telco_churn.csv")
data$Churn <- as.factor(data$Churn)
data$customerID <- NULL
data <- na.omit(data)

set.seed(123)
index <- createDataPartition(data$Churn, p = 0.8, list = FALSE)
train <- data[index, ]
test <- data[-index, ]

dummies <- dummyVars(Churn ~ ., data = train)
x_train <- predict(dummies, newdata = train)
y_train <- as.numeric(train$Churn) - 1

dtrain <- xgb.DMatrix(data = as.matrix(x_train), label = y_train)

model <- xgboost(data = dtrain, objective = "binary:logistic", nrounds = 50)
xgb.save(model, "app/xgb_churn.model")
saveRDS(dummies, "app/preproc.rds")