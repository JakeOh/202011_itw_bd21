# Regression Tree(회귀 나무): Decision Tree를 사용한 수치 예측

# 필요한 패키지 로드
library(tidyverse)
library(ModelMetrics)
library(psych)
library(rpart)       # regression tree 생성
library(rpart.plot)  # regression tree 시각화
search()

# 1. 데이터 셋 준비 -----
insurance <- read.csv(file = 'data/insurance.csv', stringsAsFactors = TRUE)
head(insurance)

# 훈련/테스트 셋 분리
N <- nrow(insurance)  # 데이터프레임의 row(obs.) 개수
train_size <- round(N * 0.8)  # 전체 데이터의 80%를 훈련 셋으로.
X_train <- insurance[1:train_size, ]  # 훈련 셋
X_test <- insurance[(train_size + 1):N, ]  # 테스트 셋

# 2. Regresion Tree 모델을 학습
# RPART: Recursive Partitioning and Regression Tree
reg_tree <- rpart(formula = expenses ~ ., data = X_train)
reg_tree
rpart.plot(reg_tree)

mean(X_train$expenses)  #> 13214.13
X_train %>% 
  filter(smoker == 'no' & age < 42.5) %>% 
  summarize(n = n(), mean = mean(expenses))

# regression tree 객체의 요약 정보
summary(reg_tree)

# 훈련 셋의 RMSE:
train_predicts <- predict(object = reg_tree, newdata = X_train)
rmse(actual = X_train$expenses, predicted = train_predicts)  #> 5012.461

# regression tree를 사용해서 테스트 셋의 expenses 예측값 계산
test_predicts <- predict(object = reg_tree, newdata = X_test)
# regression tree 모델의 RMSE를 추정.
rmse(actual = X_test$expenses, predicted = test_predicts)  #> 5131.619

# reg_tree 모델의 summary에서 변수들의 중요도(variable importance)를 알 수 있음.
# -> smoker(70), bmi(17)
# -> insurance 데이터 프레임에 overweight_smoker 파생 변수 추가
# -> bmi >= 30 & smoker == 'yes'이면 1, 그렇지 않으면 0
# -> 훈련/테스트 셋 분리
# -> Regression Tree를 생성, 테스트 셋의 RMSE를 계산.

head(insurance)

insurance_mod <- insurance %>% 
  mutate(overweight_smoker = ifelse(bmi >= 30 & smoker == 'yes', 1, 0))

head(insurance_mod)
tail(insurance_mod)
insurance_mod %>% filter(overweight_smoker == 1) %>% count()

X_train2 <- insurance_mod[1:train_size, ]
X_test2 <- insurance_mod[(train_size + 1):N, ]

reg_tree2 <- rpart(formula = expenses ~ ., data = X_train2)
reg_tree2
rpart.plot(reg_tree2)

summary(reg_tree2)

# 훈련 셋의 RMSE
train_predicts2 <- predict(object = reg_tree2, newdata = X_train2)
rmse(actual <- X_train2$expenses, predicted = train_predicts2)  #> 5047.828

# 테스트 셋의 RMSE
test_predicts2 <- predict(object = reg_tree2, newdata = X_test2)
rmse(actual = X_test2$expenses, predicted = test_predicts2)  #> 5104.558

# insurance 데이터 프레임에 파생 변수를 추가, 테스트
# age_square = age ^ 2
# overweight = 1 if bmi >= 30, else 0
