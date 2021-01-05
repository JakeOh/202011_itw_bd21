# 의사결정 나무(decision tree) 알고리즘을 사용한 대출 위험 예측

# 필요한 라이브러리들을 메모리에 로드.
library(tidyverse)
library(C50)
library(gmodels)
search()

# 1. 데이터 준비 -----
# 독일 은행 대출 상환 정보
credit_df <- read.csv(file = 'data/credit.csv', encoding = 'UTF-8',
                      stringsAsFactors = TRUE)
# stringsAsFactors = TRUE: 문자열 타입의 모든 컬럼을 factor 변수로 변환해서 데이터프레임을 생성.
str(credit_df)
head(credit_df)
summary(credit_df)

# 목적: default(채무 불이행, 파산) 여부 예측.
# default = yes: 채무 불이행, 파산.
# default = no: 채무 이행, 빚 상환.

# default 여부 시각화
table(credit_df$default)
ggplot(data = credit_df) +
  geom_bar(mapping = aes(x = default))


# 2. 데이터 탐색 -----
# checking_balance별 default=yes의 개수
credit_df %>% 
  filter(default == 'yes') %>% 
  count(checking_balance) %>% 
  ggplot() + geom_col(mapping = aes(x = checking_balance, y = n))

# saving_balance별 default=yes의 개수
credit_df %>% 
  filter(default == 'yes') %>% 
  count(savings_balance) %>% 
  ggplot() + geom_col(mapping = aes(x = savings_balance, y = n))

# amount(대출금) ~ age(나이) scatter plot
# 점의 색깔을 default 여부에 따라서 다르게 시각화.
ggplot(data = credit_df) +
  geom_point(mapping = aes(x = age, y = amount, color = default))

# amount(대출금) ~ months_loan_duration(대출기간) scatter plot
# 점의 색깔을 default 여부에 따라서 다르게 시각화.
ggplot(data = credit_df) +
  geom_point(mapping = aes(x = months_loan_duration, y = amount, color = default))

# 3. 의사결정 나무 알고리즘 훈련 -----
# 훈련 셋(9):테스트 셋(1) 분리. 훈련/테스트 레이블 분리.
train_set <- credit_df[1:900, 1:16]
head(train_set)
train_label <- credit_df[1:900, 17]
table(train_label)
prop.table(table(train_label))

test_set <- credit_df[901:1000, 1:16]
test_label <- credit_df[901:1000, 17]
prop.table(table(test_label))

# C5.0() 함수 의사결정 나무를 생성
tree <- C5.0(x = train_set, y = train_label)
summary(tree)
plot(tree, subtree = 10)  # node 10부터 시작하는 subtree

# 훈련 셋의 정확도, 오차 행렬
train_predict <- predict(tree, train_set)
mean(train_label == train_predict)  #> 학습셋 정확도 = 87.6%
CrossTable(x = train_label, y = train_predict, prop.chisq = FALSE)

# 4. 의사결정 나무 알고리즘 평가 -----
# 테스트 셋의 정확도, 오차 행렬
test_predict <- predict(tree, test_set)
mean(test_label == test_predict)  #> 테스트 셋의 정확도: 67%
CrossTable(x = test_label, y = test_predict, prop.chisq = FALSE)

# 과적합(overfitting):
# 머신 러닝 알고리즘(모델)이 훈련 셋은 잘 설명하지만, 
# 테스트 셋을 잘 설명하지 못하는 경우.


## 5. 의사결정 나무 알고리즘 성능 개선 -----
# 1) decision tree를 여러개를 만들어서, 다수결로 결정을 하는 방식
tree2 <- C5.0(x = train_set, y = train_label, trials = 10)
tree2
summary(tree2)

# 훈련 셋의 예측
train_predict2 <- predict(tree2, train_set)

# 훈련 셋의 정확도
mean(train_label == train_predict2)  #> 96.3%
CrossTable(x = train_label, y = train_predict2, prop.chisq = FALSE)

# 테스트 셋 예측
test_predict2 <- predict(tree2, test_set)
# 테스트 셋 정확도
mean(test_label == test_predict2)  #> 67%

#> tree2은 tree1보다 훈련 셋에 더 많이 overfitting

# 2) 오류(error)에 대한 비용(손실, cost)의 가중치를 설정해서,
# 비용(손실)이 큰 오류가 작아지도록 tree를 만드는 방법.
# default(파산) 여부인 경우에는 FP보다 FN가 비용(손실) 더 큰 오류.
# -> FN의 개수가 줄어들도록 tree를 만듦.

# matrix(행렬)의 행과 열의 이름을 지정하기 위해서
cost_dim_names <- list(predict = c('no', 'yes'),  # 행(row)의 이름
                       actual = c('no', 'yes'))   # 열(column)의 이름
cost_dim_names

# 비용 행렬: 예측은 행(row), 실제는 열(column)으로 설정.
# 오차 행렬: 실제값을 행(row), 예측값을 열(column)으로 보여줌.
cost_matrix <- matrix(data = c(0, 1, 2, 0),
                      nrow = 2,
                      dimnames = cost_dim_names)
cost_matrix

# 비용(손실)을 고려한 의사결정 나무
tree3 <- C5.0(x = train_set, y = train_label, costs = cost_matrix)

train_predict3 <- predict(tree3, train_set)  # 훈련 셋 예측값
mean(train_label == train_predict3)  #> 훈련 셋 정확도: 83%
CrossTable(x = train_label, y = train_predict3, prop.chisq = FALSE)
#> FP가 늘어나고, FN이 줄어듦.

test_predict3 <- predict(tree3, test_set)  # 테스트 셋 예측값
mean(test_label == test_predict3)  #> 테스트 셋 정확도: 59%
CrossTable(x = test_label, y = test_predict3, prop.chisq = FALSE)
