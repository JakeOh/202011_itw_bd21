# Random Forest: Bagging + Decision Tree Ensemble 학습 방법.
# Bagging(Bootstrap Aggregating):
#   훈련 셋에서 "중복을 허용(bootstrap)"하고 무작위로 샘플링해서 
#   훈련 셋의 부분집합을 만드는(aggregating) 방법.
# Ensemble 학습 방법:
#   1) 여러개의 머신 러닝 알고리즘을 하나의 훈련 셋에서 학습시키는 방법.
#   2) 하나의 머신 러닝 알고리즘을 여러개의 훈련 셋에서 학습시키는 방법.

# 필요한 패키지 설치, 메모리에 로드
# install.packages('randomForest')

library(tidyverse)
library(randomForest)  # randomForest()
library(gmodels)       # CrossTable()
search()


# 1. 데이터 준비 -----
iris <- datasets::iris
str(iris)

# 2. 훈련 셋(120)/테스트 셋(30) 분리
train_size <- 150 * 0.8
set.seed(42)
idx <- sample(150)
idx
X_train <- iris[idx[1:train_size], ]  # 훈련 셋
X_test <- iris[idx[(train_size + 1):150], ]  # 테스트 셋

table(X_train$Species)
table(X_test$Species)


# 3. Random Forest 알고리즘을 학습 -----
forest_clf <- randomForest(formula = Species ~ ., data = X_train)
forest_clf
#> OOB estimate of  error rate: 5.83%

# 훈련 셋 평가
train_pred <- predict(object = forest_clf, newdata = X_train)
mean(X_train$Species == train_pred)  #> 100%
CrossTable(x = X_train$Species, y = train_pred, prop.chisq = FALSE)
# oob estimate의 결과와 훈련 셋의 예측 결과는 다르다!
# oob estimate의 결과는 테스트 셋의 예측 결과와 비슷!

# 테스트 셋 평가
test_pred <- predict(object = forest_clf, newdata = X_test)
mean(X_test$Species == test_pred)  #> 0.9333333
CrossTable(x = X_test$Species, y = test_pred, prop.chisq = FALSE)

# OOB(Out Of Bagging)
#   Bagging(Bootstrap Aggregating)에서 한번도 샘플링되지 않는 훈련 셋의 관찰값들
# OOB Estimate: OOB 샘플들을 사용해서 모델을 테스트하는 방법.

# 4. Random Forest 분류 연습
# wisc_bc_data.csv 데이터(Benign/Malignant)
# credit.csv 데이터(default/not default)
