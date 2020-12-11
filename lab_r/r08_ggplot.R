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

# ggplot 하나에 두개 이상의 geom 함수를 사용하는 경우:
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

# 두개 이상의 geom 함수에서 공통으로 사용하는 aesthetic mapping은 
# ggplot 함수 안에서 설정하는 것이 더 나음.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

# hwy ~ displ의 scatter plot + 회귀 곡선
# 점의 색깔을 drv에 따라서 다르게 설정.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth()

# hwy ~ displ의 point + smooth 그래프
# 점의 색깔과 선의 색깔을 drv에 따라서 다르게 설정
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth()

# hwy ~ displ의 point + smooth 그래프
# 점의 색깔과 선의 색깔을 drv에 따라서 다르게 설정.
# 선의 타입을 drv에 따라서 다르게 설정.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(mapping = aes(linetype = drv))

# 위 그래프와 아래 그래프의 차이점? 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(linetype = drv))
