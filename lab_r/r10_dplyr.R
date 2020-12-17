# dplyr 패키지를 사용한 데이터 가공
# filter(): 데이터 프레임에서 조건에 맞는 행(observation)을 선택.
# select(): 데이터 프레임에서 원하는 열(variable)을 선택.
# arrange(): 데이터 프레임의 출력할 때, 변수를 기준으로 행(row)을 정렬.
# mutate(): 파생 변수를 추가.
# group_by(): 그룹별 묶기.
# summarize(), summarise(): 통계 값 계산(통계 함수 적용).

# dplyr 패키지의 대부분의 함수에서, 첫번째 argument는 데이터 프레임!
# dplyr 패키지의 대부분의 함수는 새로운 데이터 프레임을 생성해서 리턴!

library(tidyverse)
search()

exam <- read.csv(file = 'data/csv_exam.csv')
head(exam)

# filter(): 조건에 맞는 row(observation)들을 선택.
# select * from exam where class = 1;
# class가 1인 레코드들만 선택
filter(exam, class == 1)
filter(exam, class == 2)

# 과학 점수가 60점 이상인 학생들
filter(exam, science >= 60)

# 수학 점수가 평균 이상인 학생들
mean(exam$math)  # 수학 점수 평균(mean)
filter(exam, math >= mean(math))

# &: and(그리고)
# |: or(또는)
# !: not(부정)

# 1반, 2반 학생
filter(exam, class == 1 | class == 2)
# filter(exam, class == 1 & class == 2)
filter(exam, class %in% c(1, 2))  # var_name %in% vector

# 1반에서 수학 점수가 50점 이상인 학생
filter(exam, class == 1 & math >= 50)

# 1반이 아닌 학생
filter(exam, class != 1)

# 1반, 2반이 아닌 학생
filter(exam, (class != 1) & (class != 2))
filter(exam, !(class == 1 | class ==2))  
# !(a | b) = !a & !b
# !(a & b) = !a | !b
filter(exam, !(class %in% c(1, 2)))

# 4반에서 수학 점수가 평균 이상인 학생
filter(exam, class == 4 & math >= mean(math))

# 수학, 영어 모두 평균 이상인 학생
filter(exam, math >= mean(math) & english >= mean(english))

# select(): 컬럼 선택/제외
# id와 class 변수만 선택
select(exam, id, class)
# class 변수 제외
select(exam, -class)

# 수학점수가 50점 이상인 학생들의 id와 math를 출력
sub_df <- filter(exam, math >= 50)  # 수학점수 50점 이상인 학생들의 부분집합
sub_df
select(sub_df, id, math)

# dplyr 패키지의 pipe 연산자: %>%
# data_frame %>% function(): data_frame을 function의 첫번째 argument로 전달
filter(exam, class == 1)
exam %>% filter(class == 1)

select(exam, id, math)
exam %>% select(id, math)

# Ctrl+Shift+M: %>% 입력

exam %>% filter(math >= 50) %>% select(id, class)

exam %>% select(id, math) %>% filter(math >= 50)

exam %>% 
  filter(math >= 50) %>% 
  select(id, math)

# arrange(): 정렬
# math의 오름차순 정렬
arrange(exam, math)
exam %>% arrange(math)

# math의 내림차순 정렬
exam %>% arrange(desc(math))
exam %>% arrange(-math)

# 정렬 순서: class 오름차순 -> math 오름차순
exam %>% arrange(class, math)

# 정렬 순서: class 오름차순 -> math 내림차순
exam %>% arrange(class, desc(math))

# 수학점수 상위 5명 출력
exam %>% arrange(desc(math)) %>% head(n = 5)

# 과학점수 하위 5명 출력
exam %>% arrange(science) %>% head(n = 5)
exam %>% arrange(desc(science)) %>% tail(n = 5)

# 1반 학생들 중에서 수학 점수 상위 2명의 id, math를 출력
exam %>%                    # exam 데이터 프레임에서
  filter(class == 1) %>%    # class가 1인 학생들로 이루어진 부분집합
  arrange(desc(math)) %>%   # 수학 점수 내림차순으로 정렬
  head(n = 2) %>%           # 상위 2명 선택
  select(id, math)          # id, math 선택.

# 1, 2반 학생들 중에서 수학 점수 상위 3명의 id, class, math, science를 출력
exam %>% 
  filter(class %in% c(1, 2)) %>% 
  arrange(desc(math)) %>% 
  head(n = 3) %>% 
  select(id, class, math, science)  # select(-english)

# ggplot2::mpg 데이터 셋
# cyl가 4인 자동차들의 고속도로 연비의 평균
mpg_cyl4 <- mpg %>% filter(cyl == 4)  # cyl가 4인 부분집합
mean(mpg_cyl4$hwy)  # 부분집합에서 hwy 변수의 평균

# cly가 6인 자동차들의 고속도로 연비의 평균
mpg_cly6 <- mpg %>% filter(cyl == 6)
mean(mpg_cly6$hwy)

mean((mpg%>%filter(cyl==4))$hwy)
