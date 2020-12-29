# -----
# kNN(k-Nearest Neighbor, k-최근접이웃) 알고리즘을 사용한 Iris(붓꽃) 품종 분류

# 필요한 라이브러리 설치 & 로딩
# install.packages('class')  # classification(분류)
# install.packages('gmodels')  # 혼동(오차) 행렬
library(tidyverse)
library(class)
library(gmodels)
search()

# 1. -----
# 데이터 셋 준비(datasets::iris 데이터 셋 복사)
?datasets::iris
iris <- as.data.frame(datasets::iris)
head(iris)
tail(iris)
str(iris)

# 2. -----
# 데이터 셋 탐색, 가공(전처리)
# iris 품종(species)의 분포
table(iris$Species)
iris %>% count(Species)

# 데이터 프레임에서 인덱스(row와 column의 위치)로 원소를 선택
iris[1, 1]
iris[1, 2]
iris[1, 3]
iris[1, 4]
iris[1, 5]
iris[1,]  # iris 데이터 프레임의 첫번째 row의 모든 column 데이터
iris[1:5,]  # iris 데이터 프레임의 1 ~ 5 row의 모든 column 데이터
iris[, 1:2]  # iris 데이터 프레임의 1 ~ 2 column의 모든 row 데이터

# Petal.Length(꽃잎 길이) ~ Petal.Width(꽃잎 너비) 산점도 그래프.
# 점의 색깔은 Species에 따라서 다르게 시각화.
ggplot(data = iris) +
  geom_point(mapping = aes(x = Petal.Width, y = Petal.Length, color = Species))

qplot(data = iris, x = Petal.Width, y = Petal.Length, color = Species)

# Sepal.Length(꽃받침 길이) ~ Sepal.Width(꽃받침 너비) 산점도 그래프.
# Species(품종)에 따라서 점의 색깔을 다르게 시각화.
qplot(data = iris, x = Sepal.Width, y = Sepal.Length, color = Species)

# Species(품종)별 4개 특성(S.L, S.W., P.L., P.W.)의 분포를 시각화.
ggplot(data = iris) +
  geom_boxplot(mapping = aes(x = Species, y = Sepal.Length))

ggplot(data = iris) +
  geom_boxplot(mapping = aes(x = Species, y = Sepal.Width))

ggplot(data = iris) +
  geom_boxplot(mapping = aes(x = Species, y = Petal.Length))

ggplot(data = iris) +
  geom_boxplot(mapping = aes(x = Species, y = Petal.Width))
