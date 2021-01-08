# SVM(Support Vector Machine) Regression(회귀) - 수치 예측

# 패키지를 메모리에 로드
library(tidyverse)
library(kernlab)       # ksvm()
library(ModelMetrics)  # mse(), rmse(), mae()
library(psych)         # pairs.panel()
search()

# 1. 데이터 준비 -----
# SVM을 사용한 콘크리트 강도(strength) 예측
concrete <- read.csv(file = 'data/concrete.csv')
head(concrete)
str(concrete)
# strength: 콘크리트 강도. 관심(종속) 변수.
# strength ~ .

# 2. 데이터 탐색 -----
pairs.panels(concrete)

# 3. SVM 회귀 모델 학습 -----
# 훈련 셋/테스트 셋 분리
N <- nrow(concrete)
train_size <- round(N * 0.8)
X_train <- concrete[1:train_size, ]  # 훈련 셋
X_test <- concrete[(train_size + 1):N, ]  # 테스트 셋

summary(X_train$strength)
summary(X_test$strength)

# SVM 예측기(regressor)를 훈련 셋으로 학습시킴
svm_reg <- ksvm(x = strength ~ ., data = X_train, kernel = 'vanilladot')
svm_reg

# 훈련 셋 평가
train_pred <- predict(object = svm_reg, newdata = X_train)
train_pred[1:10]
X_train$strength[1:10]
rmse(actual = X_train$strength, predicted = train_pred)  #> 11.8534

# 4. 테스트 셋으로 모델 평가 -----
test_pred <- predict(object = svm_reg, newdata = X_test)
rmse(actual = X_test$strength, predicted = test_pred)

# 5. kernel 변경에 따른 효과 -----
# 1) Gaussian RBF 커널:
svr_rbf <- ksvm(x = strength ~ ., data = X_train, kernel = 'rbfdot')
svr_rbf
rbf_pred <- predict(object = svr_rbf, newdata = X_test)
summary(X_test$strength - rbf_pred)  # residuals 분포
rmse(actual = X_test$strength, predicted = rbf_pred)  #> 6.911415

# 2) Polynomial 커널:
svr_poly <- ksvm(x = strength ~ ., data = X_train,
                 kernel = 'polydot',       # kernel = 커널 종류
                 kpar = list(degree = 3))  # kpar = 커널 파라미터(kernel parameter)
svr_poly
poly_pred <- predict(object = svr_poly, newdata = X_test)
summary(X_test$strength - poly_pred)  # residuals 분포
rmse(actual = X_test$strength, predicted = poly_pred)  #> 6.503291


# 6. SVM 이외의 ML 알고리즘과 비교 -----
# lm(): Linear Regression, rpart(): Regression Tree

