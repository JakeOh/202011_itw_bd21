# ggplot

library(tidyverse)

# 히스토그램(histogram): 연속형 변수의 분포
# 고속도로 연비의 분포
ggplot(data = mpg) +
  geom_histogram(mapping = aes(x = hwy), bins = 10)

# 시내 연비 분포
ggplot(data = mpg) +
  geom_histogram(mapping = aes(x = cty), bins = 10)

# 막대 그래프: 범주형 변수 분포
# 자동차 종류(class)별 모델 개수
ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class))

# 자동차 구동 방식(drv)별 모델 개수
ggplot(data = mpg) +
  geom_bar(mapping = aes(x = drv), fill = 'green')
# 막대 그래프(bar, histogram, ...)에서 color 속성은 막대의 테두리 색깔을 의미.
# 막대 그래프에서 막대 내부 색깔은 fill 속성을 사용함.

# box plot - 기술 통계량
# hwy의 기술 통계량
ggplot(data = mpg) + 
  geom_boxplot(mapping = aes(y = hwy))

# hwy ~ drv scatter plot
qplot(x = drv, y = hwy, data = mpg)
# 자동차 구동방식(drv)별 고속도로연비(hwy)의 boxplot
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = drv, y = hwy))

qplot(x = drv, y = hwy, data = mpg, geom = 'boxplot')

# 실린더 개수(cyl)별 고속도로 연비(hwy)의 scatter plot
qplot(x = cyl, y = hwy, data = mpg)

# 실린더 개수(cyl)별 고속도로 연비(hwy)의 box plot
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = as.factor(cyl), y = hwy))
# as.factor(변수): 변수를 factor로 바꿈(범주형 변수로 바꿈).

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(y = hwy, group = cyl))
