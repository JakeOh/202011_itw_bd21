# 데이터 프레임 구조, 요약 정보 파악.

# data/csv_exam.csv 파일을 읽어서 데이터 프레임을 생성.
exam <- read.csv(file = 'data/csv_exam.csv')

# 데이터 프레임 전체 출력
exam

# head(): 데이터 프레임의 앞에 있는 일부 row만 출력.
# tail(): 데이터 프레임의 뒤에 있는 일부 row만 출력.
head(exam, n = 5)  # n = 6(기본값): 출력할 row 개수.
tail(exam)

# dim(): 데이터 프레임의 dimension(차원) - 행(row), 열(column)의 개수
dim(exam)
dim(exam)[1]  # 행의 개수
dim(exam)[2]  # 열의 개수

# str(): 데이터 프레임의 structure(구조) - 컬럼 이름/타입/일부 원소, ...
str(exam)

# 데이터 타입:
#   int: integer. 정수
#   dbl: double. 실수
#   chr: character. 문자열
#   logi: logical. 논리값

# summary(): 데이터 프레임의 요약 기술 통계량(descriptive statistics)
summary(exam)

# summary()는 컬럼 하나의 요약 정보를 볼 수도 있음.
summary(exam$math)

# 시각화를 통한 데이터 탐색
# tidyverse 패키지를 메모리에 로딩(검색 경로에 등록)
library(tidyverse)
# 패키지가 메모리에 로딩됐는지(검색 경로에 등록됐는지) 확인
search()

# 히스토그램(histogram):
# 연속형 변수를 구간으로 나눠서 그 구간에 포함된 데이터 개수를
# 막대로 표현한 그래프.
qplot(x = math, data = exam, bins = 5)
qplot(x = english, data = exam, bins = 5)
qplot(x = science, data = exam, bins = 5)

# 상자 그림(box plot):
# 기술 통계량(최솟값, 1사분위값, 중앙값, 3사분위값, 최댓값)을
# 상자(box)와 수염으로 그린 그래프.
qplot(y = math, data = exam, geom = 'boxplot')
summary(exam$math)

qplot(y = english, data = exam, geom = 'boxplot')
summary(exam$english)

# 산점도 그래프(scatter plot):
# 두 변수 간의 상관 관계를 파악하고자 할 때 많이 사용.
qplot(x = math, y = science, data = exam)
