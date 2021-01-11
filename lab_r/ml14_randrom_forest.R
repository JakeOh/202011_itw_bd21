# Random Forest 회귀(Regression)
# concrete 강도(strength) 예측

# 라이브러 메모리 로드
library(tidyverse)
library(randomForest)  # rondomForest()
library(ModelMetrics)  # mse(), rmse(), mae()
search()


# 1. 데이터 준비
concrete <- read.csv(file = 'data/concrete.csv')
str(concrete)

psych::pairs.panels(concrete)

# 2. 훈련 셋:테스트 셋 = 8:2
N <- nrow(concrete)
train_size <- round(N * 0.8)

X_train <- concrete[1:train_size, ]  # 훈련 셋
X_test <- concrete[(train_size + 1):N, ]  # 테스트 셋

summary(X_train$strength)
summary(X_test$strength)

# 3. Random Forest 모델을 훈련 셋에서 학습
forest_reg <- randomForest(formula = strength ~ ., data = X_train)
forest_reg
#> Mean of squared residuals: 32.57222

# 훈련된 모델을 훈련 셋에서 평가
train_pred <- predict(object = forest_reg, newdata = X_train)
mse(X_train$strength, train_pred)

# 훈련된 모델을 테스트 셋에서 평가
test_pred <- predict(object = forest_reg, newdata = X_test)
mse(X_test$strength, test_pred)  #> 32.9608
rmse(X_test$strength, test_pred)  #> 5.74115


# Random Forest 회귀를 사용한 의료비 지출 예측.
# 1. 데이터 준비
insurance <- read.csv(file = 'data/insurance.csv', stringsAsFactors = TRUE)
str(insurance)
summary(insurance)

# 2. 훈련 셋/테스트 셋 분리
N <- nrow(insurance)
train_size <- round(N * 0.8)
X_train <- insurance[1:train_size, ]
X_test <- insurance[(train_size + 1):N, ]

# random forest 모델 학습
forest_reg <- randomForest(formula = expenses ~., data = X_train)
forest_reg