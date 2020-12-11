# ggplot2::ggplot() 함수를 사용한 데이터 시각화(visualization)

library(tidyverse)
search()

# ggplot2::mpg 데이터 셋: mile per gallon
# cty(시내 연비) ~ displ(배기량) scatter plot
ggplot(data = mpg) +  # 그래프 (배경) 활성화
  geom_point(mapping = aes(x = displ, y = cty))  # 그래프 종류

# ggplot 사용방법: ggplot() + geom_xxx() + 옵션들() + ...

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = cty))

# ggplot(data = mpg) 
# +  geom_point(mapping = aes(x = displ, y = cty))

# aes() 함수: aesthetic mapping (심미적 매핑) 함수.
#   데이터 프레임의 "변수들을 사용"해서 그래프의 심미적 요소들을 설정.
#   x축/y축 매핑 변수, 색상, 크기, 모양, ...

# hwy(고속도로 연비) ~ displ(배기량) scatter plot
# drv(구동 방식)에 따라서 점의 색상을 다르게 표현
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv))

# ggplot(data = mpg) +
#   geom_point(mapping = aes(x = displ, y = hwy), color = drv)
#> 에러 발생

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = 'blue')
#> 모든 point들의 색깔을 blue로 함 - aesthetic mapping이 아님!

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = 'blue'))
#> 경고 없이 실행은 되지만, 의미상 맞지 않는 문장.

qplot(x = class, data = mpg)

# hwy ~ displ scatter plot
# drv에 따라서 점의 색깔 설정. class에 따라서 점의 모양을 설정.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv, shape = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), shape = 1)
#> aesthetic mapping이 아니라, 모든 점의 shape을 한가지 shape으로 설정.

# 여러가지 옵션 설정
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  xlab('배기량(L)') +
  ylab('고속도로연비(mile/gallon)') +
  ggtitle('배기량 vs 연비')

# ggplot 객체는 변수에 저장할 수 있음.
g <- ggplot(data = mpg)
g + geom_point(mapping = aes(x = displ, y = hwy))
g + geom_point(mapping = aes(x = cyl, y = hwy))
g + geom_point(mapping = aes(x = fl, y = hwy))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = drv), shape = 1) +
  geom_point(mapping = aes(x = displ, y = cty, color = drv), shape = 2)
