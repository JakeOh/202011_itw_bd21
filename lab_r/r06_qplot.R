# 데이터 프레임 파악하기.

# 필요한 패키지를 메모리에 로딩
library(tidyverse)
search()  # 메모리에 로딩된 패키지 확인

# ggplot2::mpg 예제 데이터 셋이 있음.
# mpg 데이터 프레임의 앞에서 5개 row를 출력
head(mpg, n = 5)
# tibble: 데이터 프레임(data.frame)에 속성들이 추가된 데이터 타입.

tail(mpg, n = 5)

# 기술 통계량(최솟값, 백분위값, 평균, 최댓값, 개수(빈도수))
summary(mpg)

# 데이터 프레임 구조
str(mpg)

# Quick Plot을 사용한 데이터 시각화
# 고속도로 연비의 분포
summary(mpg$hwy)
qplot(x = hwy, data = mpg, bins = 8)  # 히스토그램(histogram)
qplot(y = hwy, data = mpg, geom = 'boxplot')  # box plot(상자그림)

# 고속도로 연비와 배기량의 관계(hwy ~ displ)
# y = ax + b: y ~ x
qplot(x = displ, y = hwy, data = mpg)  # 산점도 그래프(scatter plot)

# 명목형 변수(범주형 변수)의 분포 - 빈도수(개수)
# 구동방식별 자동차 모델 개수
qplot(x = drv, data = mpg)  # 막대 그래프
qplot(y = drv, data = mpg, geom = 'bar')  # 가로 막대 그래프

# 연료 타입별 자동차 모델 개수
qplot(x = fl, data = mpg)

# hwy ~ cyl 그래프
qplot(x = cyl, y = hwy, data = mpg)

# hwy ~ drv 그래프
qplot(x = drv, y = hwy, data = mpg)

# hwy ~ cty 그래프
qplot(x = cty, y = hwy, data = mpg)
