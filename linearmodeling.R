set.seed(21)
train_rows = sample(1:nrow(thrunum), nrow(thrunum)*0.6) 
train_data <- thrunum[ train_rows,]  ## thus will copy from d2 all the rows we selected for training
val_data <- thrunum[-train_rows,]  ## this will delete from d2 all the rows we selected for training

lm.thru <- lm(TCP.Downlink.Throughput.Mbps.~., data = train_data)
summary(lm.thru)

predicted_values <- predict(lm.thru, val_data[,-1])

## Categorize "predicted_values"
predicted_values_class = discretize(predicted_values, method = "fixed", categories=c(0,0.75,5,Inf),
                                    labels= c("B","G","E"))

## Categorize the validation output validate_dataSet[,10]
validation_values_class = discretize(val_data[,1], method = "fixed", categories=c(0,0.75,5,Inf),
                                     labels= c("B","G","E"))

### Now compare the predicated values to the actual values and find the mean error
mean_error = length(which(predicted_values_class != validation_values_class))/length(predicted_values_class)
mean_error_percentage = 100*mean_error;
cat("Mean Error = ",mean_error_percentage,"%\n")

x <- confusionMatrix(data=predicted_values_class, reference=validation_values_class, positive = "G")
x

# prepare training scheme
control <- trainControl(method="repeatedcv", number=10, repeats=3)
# train the model
model <- train(TCP.Downlink.Throughput.Mbps.~., data=thrunum, method="lm", preProcess="scale", trControl=control)
# estimate variable importance
importance <- varImp(model, scale=FALSE)
# summarize importance
print(importance)
# plot importance
plot(importance)


# nullthru <- lm(TCP.Downlink.Throughput.Mbps.~1, data = thrunum)
# fullthru <- lm(TCP.Downlink.Throughput.Mbps.~., data = thrunum)
# summary(fullthru)
# 
# step(nullthru, scope = list(lower=nullthru, upper=fullthru),direction = "forward")
ste

# lmret <- lm(
#   as.formula(paste(colnames(retnum)[1], "~",
#                    paste(colnames(retnum)[c(4,5,10,13,15:16)], collapse = "+"),
#                    sep = ""
#   )),
#   data=retnum)
# summary(lmret)
