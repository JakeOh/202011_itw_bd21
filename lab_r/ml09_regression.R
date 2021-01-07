# lm(), rpart()를 사용한 red wine 품질 예측

library(tidyverse)     # 데이터 전처리, 가공, 시각화
library(ModelMetrics)  # 모델 평가 지표
library(psych)         # pairs.panels()
library(rpart)         # rpart() - regression tree
library(rpart.plot)    # regression tree 시각화
search()

# 1. 데이터 준비 -----
red_wine <- read.csv(file = 'data/redwines.csv')
head(red_wine)
str(red_wine)
summary(red_wine)
# 관심(종속) 변수: quality(와인 품질/별점)
# 대부분의 와인의 점수는 5 ~ 6점.
ggplot(data = red_wine) +
  geom_bar(mapping = aes(x = quality))

# 훈련/테스트 셋 분리(8:2)
N <- nrow(red_wine)  # 전체 샘플 개수
train_size <- round(N * 0.8)  # 테스트 샘플: 전체 샘플의 80%
X_train <- red_wine[1:train_size, ]  # 훈련 셋
X_test <- red_wine[(train_size + 1):N, ]  # 테스트 셋

# 훈련 셋/테스트 셋이 고르게 분포하는 지 확인.
prop.table(table(X_train$quality))
prop.table(table(X_test$quality))

# 2. Linear Regression -----
# Linear Regression 모델을 학습
lin_reg1 <- lm(formula = quality ~ ., data = X_train)
lin_reg1
summary(lin_reg1)
#> Residual standard error: 0.6505
#> Multiple R-squared:  0.3443,	Adjusted R-squared:  0.3386

# 훈련 셋의 RMSE, MAE 계산
train_predicts1 <- predict(lin_reg1)
# lin_reg1$fitted.values
rmse(actual = X_train$quality, predicted = train_predicts1)  #> 0.6474834
mae(actual = X_train$quality, predicted = train_predicts1)  #> 0.5012938

# 테스트 셋의 RMSE, MAE 계산
test_predicts1 <- predict(object = lin_reg1, newdata = X_test)
rmse(actual = X_test$quality, predicted = test_predicts1)  #> 0.641315
mae(actual = X_test$quality, predicted = test_predicts1)  #> 0.5065519

# 테스트 셋에서 residual(= 실제값 - 예측값)들의 분포
test_residuals <- X_test$quality - test_predicts1
summary(test_residuals)

# 3. Scaling + Linear Regression -----
# quality를 제외한 모든 변수들을 scaling(정규화, 표준화) 후
# Linear Regression 모델을 학습시키고 위의 결과와 비교

# 표준화(standardization): 변수들의 평균을 0, 표준편차 1로 스케일링.
std_scaler <- function(x) {
  return((x - mean(x)) / sd(x))
}

df <- red_wine[, 1:11]  # quality를 제외한 데이터 프레임
head(df)

# df의 모든 변수들에 std_scaler를 적용
df_scaled <- data.frame(lapply(X = df, FUN = std_scaler))
summary(df_scaled)
sd(df_scaled$alcohol)

# 스케일링이 끝난 데이터 프레임에 quality를 추가.
df_scaled$quality <- red_wine$quality
head(df_scaled)

# 훈련 셋/테스트 셋 분리
X_train2 <- df_scaled[1:train_size, ]
X_test2 <- df_scaled[(train_size + 1):N, ]

# 훈련 셋 학습
lin_reg2 <- lm(formula = quality ~ ., data = X_train2)
summary(lin_reg2)
#> Residual standard error: 0.6505
#> Multiple R-squared:  0.3443,	Adjusted R-squared:  0.3386

# 테스트 셋 평가
test_predicts2 <- predict(object = lin_reg2, newdata = X_test2)
test_residuals2 <- X_test2$quality - test_predicts2
summary(test_residuals2)
rmse(X_test2$quality, test_predicts2)  #> 0.641315
mae(X_test2$quality, test_predicts2)  #> 0.5065519

# 3. Regression Tree -----
# Regression Tree 모델을 학습(scaling되지 않은 변수들을 사용)
# 훈련 셋/테스트 셋의 RMSE, MAE 계산해서 Linear Regression의 결과들과 비교

reg_tree <- rpart(formula = quality ~ ., data = X_train)
reg_tree
rpart.plot(reg_tree)

# 훈련 셋 예측
train_predicts3 <- predict(object = reg_tree, newdata = X_train)
# 훈련 셋 residuals 요약
summary(X_train$quality - train_predicts3)
# 훈련 셋 RMSE, MAE
rmse(X_train$quality, train_predicts3)  #> 0.6245433
mae(X_train$quality, train_predicts3)  #> 0.5066823

# 테스트 셋 예측
test_predicts3 <- predict(object = reg_tree, newdata = X_test)
# 테스트 셋 residuals 요약
summary(X_test$quality - test_predicts3)
# 테스트 셋 RMSE, MAE
rmse(X_test$quality, test_predicts3)  #> 0.6603269
mae(X_test$quality, test_predicts3)  #> 0.5405416
