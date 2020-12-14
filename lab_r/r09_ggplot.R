library(tidyverse)

head(mpg)
tail(mpg)

# mpg 데이터 프레임에서, class별 자동차의 빈도수 시각화
ggplot(data = mpg, mapping = aes(x = class)) +
  geom_bar()

# class별 자동차의 빈도수. 자동차의 drv별로 막대 색깔을 다르게 시각화.
# class별, drv별 자동차 빈도수 시각화.
ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = drv))

ggplot(data = mpg) +
  geom_bar(mapping = aes(x = drv, fill = class))

ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = drv),
           position = 'dodge')
#> position = 'dodge': 막대를 옆으로 나란히 표시.

ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = drv),
           position = 'identity', alpha = 0.3)
#> position = 'identity': 막대들을 겹쳐서 그림.
#> alpha: 투명도(0: 투명 ~ 1.0: 불투명)

ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = drv),
           position = 'stack')
#> position = 'stack': 막대들을 위로 쌓아서 표시. 기본값 - 생략 가능.

ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = drv),
           position = 'fill')
#> position = 'fill': 그룹들 간의 비율을 막대로 표시.

# 선그래프(line graph): 시계열(time series) 데이터를 표현할 때 많이 사용.
# 시계열 데이터: 날씨, 주식, 환율, 인구수, 감염자수.

# ggplot2:economics 예제 데이터 셋
head(economics)
tail(economics)
str(economics)

# 인구수(pop)의 시계열 그래프
ggplot(data = economics) +
  geom_line(mapping = aes(x = date, y = pop))

# 실업자수(unemploy)의 시계열 그래프
ggplot(data = economics) +
  geom_line(mapping = aes(x = date, y = unemploy))

# 인구대비 실업자비율 시계열 그래프.

# 개인저축률(psavert)의 시계열 그래프
ggplot(data = economics) +
  geom_line(mapping = aes(x = date, y = psavert))


# Faceting: 한개의 plot에 여러개의 그래프를 그리는 것.
# 구동방식(drv)별 고속도로연비(hwy) ~ 배기량(displ)의 산점도 그래프
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(facets = ~ drv)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(facets = drv ~ .)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(facets = . ~ drv)

# drv(구동방식), cyl(실린더 개수)별 hwy ~ displ 산점도 그래프
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, 
                           color = drv, 
                           shape = as.factor(cyl)))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(facets = cyl ~ drv)

# drv별 hwy의 boxplot을 시각화. facet을 사용.
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(y = hwy)) +
  facet_grid(facets = . ~ drv)

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(y = hwy)) +
  facet_grid(facets = drv ~ .)

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = hwy)) +
  facet_grid(facets = drv ~ .)
