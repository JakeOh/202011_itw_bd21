# 선형 회귀(Linear Regression) - 의료비 예측

# 필요한 라이브러리 로드
# install.packages('psych')
# install.packages('rpart')
# install.packages('rpart.plot')

library(tidyverse)     # 데이터 전처리, 시각화
library(ModelMetrics)  # 모델 성능 지표 계산 함수
library(psych)         # 향상된 scatter plot matrix(산포도 행렬)
library(rpart)         # Regression Tree(decision tree regression)
library(rpart.plot)    # Regression Tree 시각화
search()

# 1. 데이터 준비 -----
insurance <- read.csv(file = 'data/insurance.csv',
                      stringsAsFactors = TRUE)
str(insurance)
# bmi(body mass index) = 몸무게/키^2 (kg/m^2)
# expenses: 의료비 지출 - 관심(종속) 변수.
# expenses ~ age + sex + bmi + children + smoker + region
# expenses = b0 + b1 * age + b2 * sex + b3 * bmi + b4 * children + b5 * smoker + b6 * region
# 선형 회귀를 할 수 없는 문제점:
#   sex, smoker, region 변수들은 문자열(character) 타입이어서 산술연산을 할 수 없음.
#   문자열 타입을 Factor 타입으로 변환해야 함!
#   lm() 함수가 Factor 타입 변수들을 숫자(0, 1, 2, ...)로 변환해서 회귀식을 찾아줌!


# 2. 데이터 탐색 -----
summary(insurance)  #> 기술 통계량(descriptive statistics)

# age(나이) 분포 시각화 - histogram, boxplot
ggplot(data = insurance, mapping = aes(y = age)) +
  geom_boxplot()
ggplot(data = insurance, mapping = aes(x = age)) +
  geom_histogram(bins = 6, color = 'black', fill = 'lightgray')

# bmi 분포 시각화
ggplot(data = insurance, mapping = aes(y = bmi)) +
  geom_boxplot()
ggplot(data = insurance, mapping = aes(x = bmi)) +
  geom_histogram(bins = 10, color = 'black', fill = 'lightgray')

# expenses(의료비 지출) 분포 시각화
ggplot(data = insurance, mapping = aes(y = expenses)) +
  geom_boxplot()
ggplot(data = insurance, mapping = aes(x = expenses)) +
  geom_histogram(bins = 15, color = 'black', fill = 'lightgray')

# expenses ~ age scatter matrix
ggplot(data = insurance, mapping = aes(x = age, y = expenses)) + 
  geom_point()

# expenses ~ bmi scatter matrix
ggplot(data = insurance, mapping = aes(x = bmi, y = expenses)) +
  geom_point()

# graphics::pairs() 함수: 산포도 행렬(scatter plot matrix)
pairs(insurance[c('age', 'bmi', 'children', 'expenses')])
pairs(insurance)

