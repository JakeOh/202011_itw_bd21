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

# 3. -----
# 데이터 셋(150개 관찰값)을 훈련 셋(training set)과 테스트 셋(test set)으로 분리.
# 훈련 셋 : 테스트 셋 = 100 : 50
# 데이터 프레임을 단순히 순서대로 100개, 50개 분리 -> 문제가 생김.
# 데이터들이 섞여 있지 않기 때문에 virginica 품종은 훈련이 되지 않는 문제가 생김.
# 데이터 셋을 분리하기 전에 무작위 섞어줘야 함.

sample(10)
# sample(n): 1 ~ n까지 정수를 무작위 순서 섞인 벡터를 반환.
idx <- sample(10)
idx
idx[1:7]   # random하게 섞인 10개의 숫자들 중에서 앞에서 7개 선택
idx[8:10]  # random하게 섞인 10개의 숫자들 중에서 뒤에서 3개 선택

idx <- sample(150)
idx

train_set <- iris[idx[1:100], 1:4]
head(train_set)

train_label <- iris[idx[1:100], 5]
head(train_label)

test_set <- iris[idx[101:150], 1:4]
head(test_set)

test_label <- iris[idx[101:150], 5]
head(test_label)

# train_label의 품종별 빈도수
table(train_label)

# test_label의 품종별 빈도수
table(test_label)

# 4. -----
# kNN 모델에 훈련 셋/레이블, 테스트 셋을 적용해서 테스트 셋의 예측값을 찾음.
test_predicts <- knn(train = train_set,  # 훈련 셋
                     test = test_set,    # 테스트 셋
                     cl = train_label,   # 훈련 셋의 레이블
                     k = 11)  # 가장 가까운 이웃을 몇개 사용
#> 테스트 셋의 예측값을 반환.
test_predicts

# 테스트 셋의 실제값
test_label

# 예측값과 실제값을 비교 -> 평가(정확도 계산)
test_predicts == test_label
sum(test_predicts == test_label)  #> 예측이 맞은 개수
# logical 값들 합: TRUE는 1, FALSE는 0으로 계산됨.
mean(test_predicts == test_label)  #> mean = sum / 전체개수: 정확도(accuracy)

# 예측값과 실젝값이 다른 인덱스(위치)
wrong_idx <- which(test_predicts != test_label)
wrong_idx
test_label[wrong_idx]  # 실제값: virginica
test_predicts[wrong_idx]  # 예측값: versicolor

# Confusion Matrix(혼동/오차 행렬)
CrossTable(x = test_label,     # x = 실제값
           y = test_predicts)  # y = 예측값

# 예측 결과 시각화
ggplot(data = test_set) +
  geom_point(mapping = aes(x = Petal.Width, y = Petal.Length, color = test_label)) +
  geom_point(data = test_set[wrong_idx, ],
             mapping = aes(x = Petal.Width, y = Petal.Length),
             shape = 'x', size = 5, color = 'red')

ggplot(data = train_set) +
  geom_point(mapping = aes(x = Petal.Width, y = Petal.Length, color = train_label)) +
  geom_point(data = test_set[wrong_idx, ],
             mapping = aes(x = Petal.Width, y = Petal.Length),
             shape = 'x', size = 5, color = 'red')
