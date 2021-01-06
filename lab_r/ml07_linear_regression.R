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

# graphics::pairs() 함수: 산포도 행렬(scatter plot matrix, pair plot)
pairs(insurance[c('age', 'bmi', 'children', 'expenses')])
pairs(insurance)

# psych::pairs.panels() 함수: 향상된 scatter plot matrix
#   대각선: 각 변수의 분포도(히스토그램, 막대 그래프)
#   대각선 아래쪽: 두 변수 간의 scatter plot
#   대각선 위쪽: 두 변수 간의 상관 계수(correaltion coefficient)
pairs.panels(insurance[c('age', 'bmi', 'children', 'expenses')])

# 상관계수 cor(x, y) = cov(x, y) / (sd(x) * sd(y))
#   -1 <= corrleation coefficinet <= 1
#   +1에 가까울 수록 양의 상관 관계가 크다고 말함.
#   -1에 가까울 수록 음의 상관 관계가 크다고 말함.
#   0에 가까울 수록 상관 관계가 없다고 말함.
#   (주의) 상관 관계와 인과 관계는 다르다!!!
# expenses, age의 상관 계수
cov(insurance$expenses, insurance$age) / (sd(insurance$expenses) * sd(insurance$age))
# expenses, bmi의 상관 계수
cov(insurance$expenses, insurance$bmi) / (sd(insurance$expenses) * sd(insurance$bmi))

cor(insurance$expenses, insurance$age)
cor(insurance$expenses, insurance$bmi)

pairs.panels(insurance)

# 3. 모델 훈련 -----
# 다항 선형 회귀 모델 생성, 훈련

# 데이터를 훈련 셋/테스트 셋으로 분리
train_size <- round(1338 * 0.8)

train_set <- insurance[1:train_size, ]
test_set <- insurance[(train_size + 1):1338, ]

summary(train_set$expenses)
summary(test_set$expenses)

# 선형 회귀 모델을 훈련 셋으로 학습시킴(fitting to linear model).
# formula = expenses ~ .
# expenses ~ age + sex + bmi + children + smoker + region
lin_reg1 <- lm(formula = expenses ~ ., data = train_set)
lin_reg1
# expenses = b0 + b1 * age + b2 * sexmale + b3 * bmi + b4 * children +
#            b5 * sm_yes + b6 * r_nw + b7 * r_se + b8 * r_sw
# 카테고리 타입의 변수들은 one-hot encoding돼서 선형회귀식에 포함됨.

# 선형회귀식의 계수들(절편과 각 변수의 기울기들)
lin_reg1$coefficients

# 모델이 찾은 선형회귀식을 사용해서 계산한 훈련 셋의 각 샘플들의 (의료비) 예측값.
lin_reg1$fitted.values[1:5]

# 훈련 셋에서 (의료비) 실제값
train_set$expenses[1:5]

# residual: 오차 = 실제값 - 예측값
train_set$expenses[1:5] - lin_reg1$fitted.values[1:5]
lin_reg1$residuals[1:5]

# residual들의 기술 통계량 요약
summary(lin_reg1$residuals)
summary(train_set$expenses)

# 훈련 셋에서의 평가 지표: MSE, RMSE, MAE
mse(actual = train_set$expenses, predicted = lin_reg1$fitted.values)
rmse(actual = train_set$expenses, predicted = lin_reg1$fitted.values)  #> 6030.798
sqrt(mean(lin_reg1$residuals ^ 2))

mae(actual = train_set$expenses, predicted = lin_reg1$fitted.values)  #> 4151.354
mean(abs(lin_reg1$residuals))

# lm 모델에서는 mse와 rmse를 간단히 계산할 수 있음.
mse(modelObject = lin_reg1)
rmse(modelObject = lin_reg1)
# lm 모델에서 mae()는 모델 객체로 계산할 수 없음!

# lm 모델 객체의 summary
summary(lin_reg1)




