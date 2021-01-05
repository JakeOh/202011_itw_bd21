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

