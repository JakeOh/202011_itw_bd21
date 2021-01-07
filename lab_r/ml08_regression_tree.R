# Regression Tree(회귀 나무): Decision Tree를 사용한 수치 예측

# 필요한 패키지 로드
library(tidyverse)
library(ModelMetrics)
library(psych)
library(rpart)
library(rpart.plot)
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

mean(X_train$expenses)
