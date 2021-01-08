# SVM(Support Vector Machine) Classification(분류)

# 필요한 패키지 설치 및 로드.
# install.packages('kernlab')  # kernel SVM 알고리즘을 구현한 패키지

library(tidyverse)  # 데이터 전처리, 가공, 시각화
library(kernlab)    # kernel SVM을 구현한 함수 사용. ksvm()
library(gmodels)    # CrossTable() - confusion matrix
search()

# 1. 데이터 준비 -----
iris <- datasets::iris
str(iris)
head(iris)
tail(iris)

# 2. 데이터 탐색 -----
# Petal.Length ~ Peata.Width scatter plot
# Species에 따라서 점의 색깔을 다르게 시각화
ggplot(data = iris) +
  geom_point(mapping = aes(x = Petal.Width, y = Petal.Length, color = Species))

# 3. SMV 알고리즘 학습 -----
# 훈련 셋/테스트 셋 분리 - random sampling. 8:2
set.seed(42)
idx <- sample(150)
idx

iris_train <- iris[idx[1:120], ]
iris_test <- iris[idx[121:150], ]

head(iris_train)
head(iris_test)

# 붓꽃 세가지 품종이 골고루 섞여 있는지 확인
table(iris_train$Species)
table(iris_test$Species)

# SVM 모델을 훈련 셋으로 학습시킴.
svm_clf <- ksvm(x = Species ~ .,         # x = formula(종속변수 ~ .)
                data = iris_train,       # data = (훈련 셋) 데이터 프레임
                kernel = 'vanilladot')  # kernel = 'vanilladot': 선형 커널
svm_clf

# 훈련 셋 예측 결과
train_pred <- predict(object = svm_clf, newdata = iris_train)
mean(iris_train$Species == train_pred)  #> 0.9833333
CrossTable(x = iris_train$Species, y = train_pred, prop.chisq = FALSE)

# 4. SVM 모델 평가 -----
# 테스트 셋으로 예측, 평가 지표 계산.
test_pred <- predict(object = svm_clf, newdata = iris_test)
mean(iris_test$Species == test_pred)  # 0.9666667
CrossTable(x = iris_test$Species, y = test_pred, prop.chisq = FALSE)





