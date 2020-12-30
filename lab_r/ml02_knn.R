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

# 2. 데이터 전처리(가공) ---
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
tr_size <- round(569 * 0.8)  # 훈련 셋의 observation 개수

train_set <- bc_data[1:tr_size, ]  #> 455 x 30 데이터 프레임
train_label <- bc_label[1:tr_size]  # 455 벡터

test_set <- bc_data[(tr_size + 1):569, ]  #> 114 x 30 데이터 프레임
test_label <- bc_label[(tr_size + 1):569]  #> 114 벡터

table(train_label)
prop.table(table(train_label))

table(test_label)
prop.table(table(test_label))
