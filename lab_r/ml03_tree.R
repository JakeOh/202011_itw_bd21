# 의사결정 나무(Decision Tree) 알고리즘을 사용한 붓꽃 분류(classification)

# -----
# 필요한 라이브러리 설치 및 메모리에 로드
# install.packages('C50')
# C5.0 알고리즘을 사용해서 Decision Tree를 구현한 패키지.

library(tidyverse)
library(C50)
search()


# 1. 데이터 준비 -----
# 붓꽃(iris) 품종(Species) 분류
iris <- datasets::iris  # datasets 패키지의 iris 데이터셋을 메모리에 복사.
str(iris)  #> data.frame(150 x 5)
head(iris)
tail(iris)
summary(iris)


# 2. 데이터 탐색, 전처리(가공) -----

# Petal.Length ~ Petal.Width 산점도 그래프(scatter plot)
# 점의 색깔은 Species의 따라서 다르게 시각화.
ggplot(data = iris) +
  geom_point(mapping = aes(x = Petal.Width, y = Petal.Length, color = Species)) +
  geom_hline(yintercept = 2.0, linetype = 'dashed') +  # 수평선(horizontal line)
  geom_vline(xintercept = 1.7, linetype = 'dashed')  # 수직선(vertical line)
  # xintercept: x 절편, yintercept: y 절편

