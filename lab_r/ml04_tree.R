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


