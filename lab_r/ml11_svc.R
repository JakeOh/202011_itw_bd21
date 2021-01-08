# SVM(Support Vector Machine)를 사용한 암(cancer) 예측

# 라이브러리 로드
library(tidyverse)  # 데이터 전처리, 가공, 시각화
library(kernlab)    # kernel SVM을 구현한 함수 사용. ksvm()
library(gmodels)    # CrossTable() - confusion matrix
search()


# 1. 데이터 준비 -----
# wisc_bc_data.csv
wisc_bc <- read.csv(file = 'data/wisc_bc_data.csv')
head(wisc_bc)
str(wisc_bc)


# 2. 데이터 탐색, 전처리, 가공 -----
# id 변수 제거
df <- wisc_bc[, -1]
# diagnosis 변수를 Factor 타입으로 변환
df$diagnosis <- factor(df$diagnosis,
                       levels = c('B', 'M'),
                       labels = c('Benign', 'Malignant'))
str(df)
summary(df$diagnosis)


# 3. SVM 분류기를 학습 -----
# 훈련 셋:테스트 셋 = 8:2
N <- nrow(df)  # 전체 샘플 개수
train_size <- round(N * 0.8)
X_train <- df[1:train_size, ]  # 훈련 셋
X_test <- df[(train_size + 1):N, ]  # 테스트 셋

prop.table(table(X_train$diagnosis))
prop.table(table(X_test$diagnosis))

# 훈련 셋으로 학습시킴.
svm_clf <- ksvm(x = diagnosis ~ ., data = X_train, kernel = 'vanilladot')
svm_clf

# 훈련 셋에서 정확도, 오차 행렬
train_pred <- predict(object = svm_clf, newdata = X_train)
mean(X_train$diagnosis == train_pred)  #> 0.989011
CrossTable(x = X_train$diagnosis, y = train_pred, prop.chisq = FALSE)


# 4. SVM 분류기 평가 -----
# 테스트 셋에서 정확도, 오차 행렬
test_pred <- predict(object = svm_clf, newdata = X_test)
mean(X_test$diagnosis == test_pred)  #> 0.9824561
CrossTable(x = X_test$diagnosis, y = test_pred, prop.chisq = FALSE)


# 5. SVM 분류기를 여러가지 kernel에서 비교 테스트 -----
