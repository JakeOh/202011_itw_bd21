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

