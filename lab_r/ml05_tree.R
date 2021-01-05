# Decision Tree 알고리즘을 사용한 위스콘신 암 데이터 분류

# 필요한 패키지
library(tidyverse)
library(C50)
library(gmodels)
search()

# 1. 데이터 준비 -----
wisc_df <- read.csv(file = 'data/wisc_bc_data.csv', 
                    stringsAsFactors = TRUE)
str(wisc_df)

# 2. 데이터 전처리 -----
# id 변수 제거
# diagnosis - 관심 변수(레이블). factor.

train_size <- round(569 * 0.8)  #> Train:Test = 455:114
train_set <- wisc_df[1:train_size, 3:32]
train_label <- wisc_df[1:train_size, 2]
test_set <- wisc_df[(train_size + 1):569, 3:32]
test_label <- wisc_df[(train_size + 1):569, 2]

prop.table(table(train_label))
prop.table(table(test_label))

# 3. Decision Tree 알고리즘 학습 -----
tree <- C5.0(x = train_set, y = train_label)
tree
summary(tree)
plot(tree)

# 훈련 셋 예측, 정확도, 오차 행렬
train_predict <- predict(tree, train_set)
mean(train_label == train_predict)  #> 99.1%
CrossTable(x = train_label, y = train_predict, prop.chisq = FALSE)

# 4. Decision Tree 알고리즘 평가 -----
# 훈련되지 않은 테스트 셋을 사용해서 예측, 정확도, 오차 행렬 계산
test_predict <- predict(tree, test_set)
mean(test_label == test_predict)  #> 94.7%
CrossTable(x = test_label, y = test_predict, prop.chisq = FALSE)
