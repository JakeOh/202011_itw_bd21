# ggplot2::midwest 데이터 셋 - Help 페이지에서 내용 확인.
# poptotal(인구수), popadults(성인 인구수), popasian(아시아계 인구수)
# 1) '인구 대비 미성년 인구 백분율' 파생 변수를 추가.
# 2) 미성년 인구 비율이 높은 상위 5개 county와 백분율을 출력.
# 3) 미성년 인구 비율 등급 파생 변수를 추가. 각 등급의 빈도수.
#    40% 이상 large, 30 ~ 40% 미만 middle,  30% 미만 small
# 4) '인구 대비 아시아계 인구 백분율' 파생 변수를 추가하고, 상위 10개 지역의
# state, county, 아시아계 인구 비율을 출력.
#> midwest에는 이미 percasian 변수가 있습니다. 그 값과 비교해보세요.

# tidyverse 패키지를 검색 경로에 추가(메모리에 로딩)
library(tidyverse)
search()

# ggplot2::midwest 데이터 셋 확인.
# str(midwest)
str(ggplot2::midwest)
head(midwest)

# 1) 미성년 인구 비율(백분율)
midwest_df <- midwest %>% 
  mutate(child_pct = (poptotal - popadults) / poptotal * 100)
# (1 - popadults / poptotal) * 100

select(midwest_df, county, poptotal, popadults, child_pct)

# 2) 미성년 인구 비율 상위 5개
midwest_df %>% 
  arrange(desc(child_pct)) %>%  # 미성년 인구 비율 내림차순 정렬
  head(n = 5) %>%               # 상위 5개 row 선택
  select(county, child_pct)     # 변수(column) 선택

# 3) 미성년 인구 비율 등급
midwest_df <- midwest_df %>% 
  mutate(child_grade = ifelse(child_pct >= 40, 'large',
                              ifelse(child_pct >= 30, 'middle', 'small')))
midwest_df %>% select(county, child_pct, child_grade)

# child_grade 빈도수(frequency table)
table(midwest_df$child_grade)

midwest_df %>% 
  group_by(child_grade) %>% 
  summarize(n = n())

midwest_df %>% count(child_grade)

# count() 함수: 
# group_by() %>% summarize(n = n())를 간단히 하는 도우미 함수.

# 4) 아시아계 인구 비율 상위 10개 지역
midwest_df %>% 
  mutate(asia_pct = (popasian / poptotal) * 100) %>% 
  arrange(desc(asia_pct)) %>% 
  head(n = 10) %>% 
  select(state, county, asia_pct)


# dplyr::count() 함수
exam <- read.csv(file = 'data/csv_exam.csv')

exam %>% summarize(n = n())  # 데이터 프레임의 row(observation) 개수
exam %>% count()
#> count()는 summarize(n = n())과 같은 결과.

# class별 학생 수
exam %>% group_by(class) %>% summarize(n = n())
# exam %>% group_by(class) %>% count()
exam %>% count(class)
#> count(var_name)는 group_by(var_name) %>% summarize(n = n())과 같은 결과.
