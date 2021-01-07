# lm(), rpart()를 사용한 red wine 품질 예측

library(tidyverse)     # 데이터 전처리, 가공, 시각화
library(ModelMetrics)  # 모델 평가 지표
library(psych)         # pairs.panels()
library(rpart)         # rpart() - regression tree
library(rpart.plot)    # regression tree 시각화
search()

# 1. 데이터 준비 -----
red_wine <- read.csv(file = 'data/redwines.csv')
head(red_wine)
str(red_wine)
summary(red_wine)
# 관심(종속) 변수: quality(와인 품질/별점)
# 대부분의 와인의 점수는 5 ~ 6점.
ggplot(data = red_wine) +
  geom_bar(mapping = aes(x = quality))

# 훈련/테스트 셋 분리(8:2)

# Linear Regression 모델을 학습
# 훈련 셋의 RMSE, MAE 계산
# 테스트 셋의 RMSE, MAE 계산

# quality를 제외한 모든 변수들을 scaling(정규화, 표준화) 후
# Linear Regression 모델을 학습시키고 위의 결과와 비교

# Regression Tree 모델을 학습(scaling되지 않은 변수들을 사용)
# 훈련 셋/테스트 셋의 RMSE, MAE 계산해서 Linear Regression의 결과들과 비교



