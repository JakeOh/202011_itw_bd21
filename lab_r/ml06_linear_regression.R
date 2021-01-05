# Linear Regression(선형 회귀)

library(tidyverse)
search()

# data/heights.csv 파일을 읽어서 데이터프레임 생성
heights_df <- read.csv(file = 'data/heights.csv')
str(heights_df)
summary(heights_df)
head(heights_df)

# 데이터 탐색
# 아버지의 키(father), 아들의 키(son) 분포 시각화
ggplot(data = heights_df) +
  geom_boxplot(mapping = aes(y = father))

ggplot(data = heights_df) +
  geom_histogram(mapping = aes(x = father),
                 bins = 10,           # bins = 막대 개수
                 color = 'black',     # color = 막대 테두리 색깔
                 fill = 'lightgray')  # fill = 막대를 채우는 색깔

ggplot(data = heights_df) +
  geom_boxplot(mapping = aes(y = son))

ggplot(data = heights_df) +
  geom_histogram(mapping = aes(x = son),
                 bins = 10, color = 'black', fill = 'lightgray')

# son ~ father scatter plot
ggplot(data = heights_df, mapping = aes(x = father, y = son)) +
  geom_point(color = 'darkgray') +
  geom_smooth(method = 'lm')
# lm: linear modeling(선형 모델링)
#   선형 회귀(linear regression)
#   y(종속변수) ~ x(독립변수)의 "선형(linear) 관계"를 찾는 것.
#   y = a + b * x 관계식에서 y절편 a와 x의 기울기 b를 찾는 것.
# 선형 회귀의 목적:
#   실제 데이터: (x_i, y_i)
#   예측 데이터: (x_i, y_hat_i), y_hat_i = a + b * x_i
#   오차(error) = 실제값 - 예측값: e_i = y_i - y_hat_i
#   오차들의 제곱의 합을 최소화하는 절편 a와 기울기 b를 찾는 것.
#   sum(e_i ^ 2)을 최소화.

# N: 변수 x의 개수.
# x_bar: 변수 x의 평균. x_bar = sum(x_i) / N
N <- 1078
father_bar <- sum(heights_df$father) / N
mean(heights_df$father)

# 분산(variance): 데이터가 평균으로부터 떨어져 있는 정도 표현하는 값
# variance = sum((x_i - x_bar) ^ 2) / (N - 1)
father_variance <- sum((heights_df$father - father_bar) ^ 2) / (N - 1)
var(heights_df$father)  #> 아버지 키의 분산 = 48.61361

# 표준편차(standard deviation) = sqrt(variance)
father_std <- sqrt(father_variance)
sd(heights_df$father)

# 두 변수 x, y의 공분산: 
# Covariance(x, y) = sum((x_i - x_bar)*(y_i - y_bar)) / (N - 1)
# father, son의 공분산
son_bar <- mean(heights_df$son)  # son의 평균
covariance <- sum((heights_df$father - father_bar) * (heights_df$son - son_bar)) / (N-1)
cov(x = heights_df$father, y = heights_df$son)  #> 24.98318

# R 통계 함수: mean(평균), var(분산), sd(표준편차), cov(공분산)

# OLS(Ordinary Least Squares):
# 선형 회귀식 y = a + b*x에서 변수 x의 기울기 b는 다음과 같이 계산됨.
# b = cov(x, y) / var(x)
b <- cov(heights_df$father, heights_df$son) / var(heights_df$father)

# 선형 회귀식 y = a + b*x로 만들어지는 직선은 두 변수 x, y의 평균을 지남.
# y_bar = a + b * x_bar
# a = y_bar - b * x_bar
a <- mean(heights_df$son) - b * mean(heights_df$father)

# lm() 함수: 선형 회귀식의 계수들(y절편, 기울기)을 찾아주는 함수.
lin_reg <- lm(formula = son ~ father, data = heights_df)
lin_reg
lin_reg$coefficients #> intercept(절편), 기울기
lin_reg$coefficients[1]  #> y절편(y-intercept)
lin_reg$coefficients[2]  #> 변수 father의 기울기

ggplot(data = heights_df, mapping = aes(x = father, y = son)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = 'lm') +
  geom_vline(xintercept = mean(heights_df$father), 
             color = 'darkgreen', size = 1, linetype = 'dashed') +
  geom_hline(yintercept = mean(heights_df$son),
             color = 'darkgreen', size = 1, linetype = 'dashed') +
  geom_abline(slope = b, intercept = a, 
              color = 'red', size = 1.5, linetype = 'dotted')

# 선형 회귀 방정식 y_hat = a + b * x의 예측값은 오차들의 제곱의 합을 최소화.
y <- heights_df$son  # 아들 키 - 종속 변수
x <- heights_df$father  # 아버지 키 - 독립 변수
# 선형 모델(lm)에서 예측한 아들 키
y_hat <- a + b * x
# 오차(=실제값-예측값)들의 제곱의 합계
sum((y - y_hat) ^ 2)  #> 41242.11

# lm 모형과 다른 모형
y_hat2 <- 85 + 0.6 * x
sum((y - y_hat2) ^ 2)  #> 243898

# 회귀(regression: 수치 예측)의 성능 지표:
# MSE(Mean Square Errors): 오차들의 제곱의 평균
# RMSE(Root Mean Square Errors): 오차들의 제곱의 평균의 제곱근

# lm에서 MSE
mse_son <- mean((y - y_hat) ^ 2)  #> 38.25799
rmse_son <- sqrt(mse_son)  #> 6.1853
