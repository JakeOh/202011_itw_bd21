# dplyr 패키지를 사용한 데이터 가공 - 그룹별 요약
# group_by(), summarize() 함수

# summarize(), summarise() 함수와 함께 사용되는 통계(집계) 함수들:
#   n(): 빈도수(개수 세기)
#   mean(): 평균
#   sd(): 표준편차(standard deviation)
#   sum(): 합계
#   max(), min(): 최댓값, 최솟값
#   median(): 중앙값
#   IQR(): 4분위값(Inter-quartile range)

library(tidyverse)

exam <- read.csv(file = 'data/csv_exam.csv')

mean(exam$math)  # 수학 점수 평균

summarize(exam, mean_math = mean(math))

exam %>% 
  summarize(mean_math = mean(math),
            sd_math = sd(math),
            max_math = max(math),
            min_math = min(math),
            median_math = median(math))

summarize(exam, n = n())  # 데이터 프레임의 row 개수(observation 개수)
exam %>% summarise(n = n())
exam %>% count()  # count() 함수는 summarize(n = n()) 호출을 간단히 표현한 함수.

# (주의) summary() vs summarize()
summary(exam)

# IQR() = 3rd Quartile - 1st Quartile: box plot에서 사각형의 폭(높이)
IQR(exam$math)
IQR(exam$english)
IQR(exam$science)

exam %>% summarize(IQR(math), IQR(english), IQR(science))

# exam 데이터 프레임에서 class별 학생 수
exam %>% 
  group_by(class) %>% 
  summarize(n = n())

exam %>% 
  group_by(class) %>% 
  count()

# exam 데이터 프레임에서 class별 수학 점수 평균, 중앙값, 최댓값, 최솟값
df <- exam %>% 
  group_by(class) %>% 
  summarize(mean = mean(math), median = median(math),
            max = max(math), min = min(math))
df

# geom_col(): 원자료를 사용해서(x축, y축을 모두 설정해서) 그리는 막대 그래프.
ggplot(data = df) +
  geom_col(mapping = aes(x = class, y = mean))

# (비교)
# geom_bar(): 카테고리 타입 변수의 빈도수를 막대로 표현.
ggplot(data = exam) +
  geom_bar(mapping = aes(x = as.factor(class)))

# geom_histogram(): 연속형 변수를 구간(bin)으로 나눠서 그 구간에 속하는 빈도수를 막대로 표현.
ggplot(data = exam) +
  geom_histogram(mapping = aes(x = math), bins = 8)

# dplyr 함수와 ggplot2 함수를 %>%로 연결할 수 있음.
exam %>% 
  group_by(class) %>% 
  summarize(mean_math = mean(math)) %>% 
  ggplot() + 
  geom_col(mapping = aes(x = class, y = mean_math, fill = class))


