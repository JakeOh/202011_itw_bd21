# dplyr 패키지를 사용한 데이터 가공.

library(tidyverse)

# ggplot2::mpg 데이터 셋의 일부를 출력
head(mpg)

# 자동차의 종류(class)가 'compact'인 자동차들의 고속도로연비(hwy)의 평균
df_compact <- mpg %>% filter(class == 'compact')
df_compact
mean(df_compact$hwy)

mean(filter(mpg, class == 'compact')$hwy)

# 자동차의 class가 'suv'인 자동차들의 hwy의 평균
df_suv <- mpg %>% filter(class == 'suv')
df_suv
mean(df_suv$hwy)

# 범주형(카테고리 타입) 변수들의 빈도수(frequency)
table(mpg$class)
table(mpg$manufacturer)

# 막대 그래프(geom_bar)가 table 함수를 시각화.
qplot(x = class, data = mpg, fill = class)
