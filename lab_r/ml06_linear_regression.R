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

