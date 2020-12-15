# dplyr 패키지를 사용한 데이터 가공.

library(tidyverse)

# ggplot2::mpg 데이터 셋의 일부를 출력
head(mpg)

# 자동차의 종류(class)가 'compact'인 자동차들의 고속도로연비(hwy)의 평균
df_compact <- mpg %>% filter(class == 'compact')
df_compact
mean(df_compact$hwy)

mean(filter(mpg, class == 'compact')$hwy)

# 자동차의 class가 'suv'인 자동차들의 hwy의 평균
df_suv <- mpg %>% filter(class == 'suv')
df_suv
mean(df_suv$hwy)

# 범주형(카테고리 타입) 변수들의 빈도수(frequency)
table(mpg$class)
table(mpg$manufacturer)

# 막대 그래프(geom_bar)가 table 함수를 시각화.
qplot(x = class, data = mpg, fill = class)

# 자동차 제조사(manufacturer)들 중에서 가장 많은 모델을 가지고 있는 2개 제조사를 찾으세요.
table(mpg$manufacturer)
#> dodge: 37, toyota: 34
# 두 제조사 자동차들의 고속도로연비 평균을 각각 찾아서 비교하세요.
df_dodge <- mpg %>% filter(manufacturer == 'dodge')
df_dodge
mean(df_dodge$hwy)

df_toyota <- mpg %>% filter(manufacturer == 'toyota')
df_toyota
mean(df_toyota$hwy)

# 데이터 프레임에 파생 변수를 추가:
# data_frame$new_var <- (데이터 프레임의 기존 변수들을 사용해서 공식을 작성.)
# 원본 데이터 프레임이 변경!
df_test <- data.frame(kor = c(10, 20, 30),
                      eng = c(11, 22, 33),
                      math = c(1, 2, 3))
df_test
# 세과목 총점 파생 변수
df_test$total <- df_test$kor + df_test$eng + df_test$math
df_test

# dplyr 패키지의 mutate() 함수를 사용한 파생 변수 추가:
# mutate(data_frame, new_var = 파생변수 공식)
# 파생 변수가 추가된 새로운 데이터 프레임을 만들어서 리턴함!
# 원본 데이터 프레임은 변경되지 않음!
mutate(df_test, average = total / 3)
df_test

df_test2 <- mutate(df_test, average = total / 3)
df_test2

# ifelse(조건식, 조건식이 TRUE일 때 리턴할 값, 조건식이 FALSE일 때 리턴할 값)
numbers <- c(-1, 0, 1)
is_positive <- ifelse(numbers > 0, '양수', '양수 아님')
is_positive

check <- ifelse(numbers > 0, 'positive',  
                ifelse(numbers < 0, 'negative', 'zero'))
check

df_test2
# df_test2에 grade 파생 변수 추가
#   average >= 20, grade = 'A'
#   average >= 10, grade = 'B',
#   average < 10, grade = 'C'
df_test2 %>% mutate(grade = ifelse(average >= 20, 'A',
                                   ifelse(average >= 10, 'B', 'C')))
df_test2$grade <- ifelse(df_test2$average >= 20, 'A',
                         ifelse(df_test2$average >= 10, 'B', 'C'))
df_test2

# exam 데이터 프레임에 total 파생 변수(수학, 영어, 과학 세과목 총점) 추가.
# exam 데이터 프레임에 average 파생 변수(세과목 평균) 추가.
# exam 데이터 프레임에 grade 파생 변수 추가
#   average >= 80, 'A',
#   average >= 60, 'B',
#   average >= 40, 'C',
#   average < 40, 'F'
# mutate() 함수 사용.
exam %>% 
  mutate(total = math + english + science,
         average = total / 3,
         grade = ifelse(average >= 80, 'A',
                        ifelse(average >= 60, 'B', 
                               ifelse(average >= 40, 'C', 'F'))))

# exam 데이터 프레임에 세과목의 총점 total 파생 변수를 추가하고,
# 총점 상위 5명의 레코드를 출력.
exam %>% 
  mutate(total = math + english + science) %>%  # 총점 파생 변수 추가
  arrange(desc(total)) %>%                      # 총점 내림차순 정렬
  head(n = 5)                                   # 상위 5명 출력

# ggplot2::mpg 데이터 셋에 avg_mpg(도시, 고속도로 연비 평균) 파생 변수를 추가하고,
# avg_mpg의 상위 5개 자동차의 제조사, 모델, avg_mpg를 출력
mpg %>% 
  mutate(avg_mpg = (cty + hwy) / 2) %>% 
  arrange(desc(avg_mpg)) %>% 
  head(n = 5) %>% 
  select(manufacturer, model, avg_mpg)

# mpg 데이터 셋에 avg_mpg(도시, 고속도로 연비 평균) 파생 변수를 추가하고,
#   avg_mpg >= 30, grade = 'A',
#   avg_mpg >= 20, grade = 'B',
#   avg_mpg < 20, grade = 'C' 
# 파생변수 avg_mpg 추가.
mpg %>% 
  mutate(avg_mpg = (cty + hwy) / 2,
         grade = ifelse(avg_mpg >= 30, 'A',
                        ifelse(avg_mpg >= 20, 'B', 'C'))) %>% 
  select(cty, hwy, avg_mpg, grade)
