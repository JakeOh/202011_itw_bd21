# wisc_bc_data.csv: 위스콘신 대학 유방암 데이터 프레임
# 암 데이터 분류 - kNN

# 0. -----
# 필요한 패키지들을 메모리에 로드.
library(tidyverse)  # 데이터 전처리, 가공, 시각화, ...
library(class)      # knn() 함수
library(gmodels)    # CrossTable() 함수
search()

# 1. 데이터 준비 ----
# csv 파일을 읽어서 데이터 프레임을 생성
wisc_bc <- read.csv(file = 'data/wisc_bc_data.csv')
head(wisc_bc)
tail(wisc_bc)
str(wisc_bc)
summary(wisc_bc)

# 2. 데이터 전처리(가공) -----
# id 변수: 환자 아이디 -> 데이터 프레임에서 제거
# diagnosis 변수: 암인지 아닌지가 진단된 데이터 - 관심 변수(레이블)
# knn() 함수에서 cl 파라미터에 전달하는 레이블은 factor 타입이어야 함.
# -> diagnosis 변수를 factor 타입으로 변환.

table(wisc_bc$diagnosis)
# B: Benign. 양성 종양(암 X)
# M: Malignant. 악성 종양(암 O)

wisc_bc$diagnosis <- factor(x = wisc_bc$diagnosis,
                            levels = c('B', 'M'),
                            labels = c('Benign', 'Malignant'))
str(wisc_bc$diagnosis)
table(wisc_bc$diagnosis)

# id 변수 제거, 데이터와 레이블 분리
bc_data <- wisc_bc[, 3:32]  #> 데이터
bc_label <- wisc_bc[, 2]  #> 레이블

# 데이터 셋(데이터 & 레이블)을 훈련 셋과 테스트 셋으로 분리(8:2)
# wisc_bc 데이터 셋은 B(Benign)과 M(Malignant)이 랜덤하게 섞여 있는 상태이기 때문에,
# sample() 함수를 이용하지 않고, 순서대로 분리해도 괜찮다.
tr_size <- round(569 * 0.8)  # 훈련 셋의 observation 개수

train_set <- bc_data[1:tr_size, ]  #> 455 x 30 데이터 프레임
train_label <- bc_label[1:tr_size]  # 455 벡터

test_set <- bc_data[(tr_size + 1):569, ]  #> 114 x 30 데이터 프레임
test_label <- bc_label[(tr_size + 1):569]  #> 114 벡터

table(train_label)
prop.table(table(train_label))

table(test_label)
prop.table(table(test_label))

# 3. knn 알고리즘 적용 -----
# knn() 함수 사용해서 테스트 셋의 예측값 찾음.
predicts <- knn(train = train_set,
               test = test_set,
               cl = train_label,
               k = 1)

# 4. knn 성능 평가 -----
# 정확도 계산
mean(predicts == test_label)
wrong_idx <- which(predicts != test_label)
test_label[wrong_idx]
predicts[wrong_idx]

# 오차 행렬(Confusion Matrix) 생성
CrossTable(x = test_label, y = predicts, prop.chisq = FALSE)
#          | 예측값              |
# 실제값   | Negative | Positive |
# ---------+----------+----------+
# Negative |    TN    |    FP    |
# ---------+----------+----------+
# Positive |    FN    |    TP    |
# ---------+----------+----------+
# TN(True Negative, 진짜 음성): 실제 음성을 음성으로 예측.
# FP(False Positive, 가짜 양성): 실제로는 음성인데 양성으로 잘못 예측.
# FN(False Negative, 가짜 음성): 실제로는 양성인데 음성으로 잘못 예측.
# TP(True Positive, 진짜 양성): 실제 양성을 양성으로 예측.
tn <- 68
fp <- 2
fn <- 4
tp <- 40

# 분류(classification)의 성능 지표(metrics)
# 1) 정확도(accuracy): 전체 샘플들 중에서 정확하게 예측(TP, TN)한 비율
# accuracry = (TN + TP) / (TN + FP + FN + TP)
(tn + tp) / (tn + fp + fn + tp)

# 2) 정밀도(precision): 양성(positive) 예측들 중에서 정답의 비율
# precision = TP / (FP + TP)
precision <- tp / (fp + tp)
precision

# 3) 재현율(recall): 실제 양성(positive) 샘플들 중에서 정답의 비율
# recall = TP / (FN + TP)
# 재현율 = 민감도(sensitivity) = TPR(True Positive Rate, 진짜 양성 비율)
recall <- tp / (fn + tp)
recall

# 4) F1-score: 정밀도와 재현율의 조화 평균(역수들의 평균의 역수)
# f1 = 1 / ((1/precision + 1/recall) / 2) = 2 / (1/precision + 1/ recall)
f1 = 2 / (1/precision + 1/recall)
f1

# 정밀도/재현율 트레이드오프(precision/recall trade-off)
# 정밀도가 좋아지면 재현율이 나빠짐. 반대로, 재현율이 좋아지면 정밀도 나빠짐.

# k = 5, 11, 21일 때 결과 비교
predicts <- knn(train = train_set,
                test = test_set,
                cl = train_label,
                k = 11)
mean(predicts == test_label)
CrossTable(x = test_label, y = predicts, prop.chisq = FALSE)

# 5. 모델 향상 -----
# 1) 변수 정규화(normalization)
normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

# 데이터 셋 정규화
normalized_bc_data <- data.frame(lapply(bc_data, normalize))
summary(normalized_bc_data)

# 데이터 셋을 훈련/테스트 셋으로 분리
train_normalized <- normalized_bc_data[1:tr_size, ]
test_normalized <- normalized_bc_data[(tr_size + 1):569, ]

predicts <- knn(train = train_normalized,
                test = test_normalized,
                cl = train_label,
                k = 5)
mean(predicts == test_label)
CrossTable(x = test_label, y = predicts, prop.chisq = FALSE)

# 2) 변수 표준화(standardization)
standardize <- function(x) {
  return((x - mean(x)) / sd(x))
}

# 데이터 셋 표준화
standardized_bc_data <- data.frame(lapply(bc_data, standardize))
summary(standardized_bc_data)

# 표준화된 데이터 셋을 훈련/테스트 셋으로 분리
train_standardized <- standardized_bc_data[1:tr_size, ]
test_standardized <- standardized_bc_data[(tr_size + 1):569, ]

# knn 적용
predicts <- knn(train = train_standardized,
                test = test_standardized,
                cl = train_label,
                k = 5)
mean(predicts == test_label)
CrossTable(x = test_label, y = predicts, prop.chisq = FALSE)
