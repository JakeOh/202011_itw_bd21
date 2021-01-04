# 의사결정 나무(decision tree) 알고리즘을 사용한 대출 위험 예측

# 필요한 라이브러리들을 메모리에 로드.
library(tidyverse)
library(C50)
library(gmodels)
search()

# 1. 데이터 준비 -----
# 독일 은행 대출 상환 정보
credit_df <- read.csv(file = 'data/credit.csv', encoding = 'UTF-8')
str(credit_df)
head(credit_df)

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

# C5.0() 함수 의사결정 나무를 생성

# 훈련 셋의 정확도, 오차 행렬


# 4. 의사결정 나무 알고리즘 평가 -----
# 테스트 셋의 정확도, 오차 행렬

