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

