# 한국 복지 패널 데이터 분석

# 필요한 라이브러리 로드.
library(tidyverse)
library(readxl)
search()

# .RData 파일 불러오기(load)
load(file = 'data/koweps.RData')

# welfare 데이터 프레임 확인
head(welfare)


# 직종별 소득 차이?

# welfare에 직종 이름(job) 파생 변수 추가
# 직종 이름 엑셀 파일에 정리되어 있음.
# 엑셀 파일에서 직종 코드/이름 데이터 프레임 생성 -> welfare 데이터 프레임과 join
df_job <- read_xlsx(path = 'data/Koweps_Codebook.xlsx',
                    sheet = 2)
head(df_job)
tail(df_job)

welfare <- left_join(welfare, df_job, by = c('job_code' = 'code_job'))
head(welfare)

# 가장 많은 인구가 종사하는 직종 상위 10개의 이름, 인구수
# NA 개수 확인
welfare %>% filter(is.na(job_code)) %>% summarize(n = n())
welfare %>% filter(is.na(job)) %>% summarize(n = n())

job_top10 <- welfare %>% 
  filter(!is.na(job)) %>%  # job이 있는 자료들만 선택
  group_by(job) %>%        # job별 그룹
  summarize(n = n()) %>%   # 그룹별 개수로 요약
  arrange(desc(n)) %>%     # 개수의 내림차순 정렬
  head(n = 10)             # 상위 10개

job_top10

job_top10 <- welfare %>% 
  filter(!is.na(job)) %>% 
  count(job) %>%  # count(var_name): group_by(var_name) %>% summarize(n = n())
  arrange(desc(n)) %>% 
  head(n = 10)

job_top10

ggplot(data = job_top10) +
  geom_col(mapping = aes(x = job, y = n))

ggplot(data = job_top10) +
  geom_col(mapping = aes(x = n, y = reorder(job, n))) +
  ylab('job')

# 남성이 가장 많이 일하는 직종 상위 10개, 인구수. 시각화
job_male_top10 <- welfare %>% 
  filter(!is.na(job) & gender == 'Male') %>%  # 직업이 있는 남성 선택
  count(job) %>% 
  arrange(desc(n)) %>% 
  head(10)

job_male_top10

ggplot(data = job_male_top10) +
  geom_col(mapping = aes(x = n, y = reorder(job, n))) +
  ylab('job')

# 여성이 가장 많이 일하는 직종 상위 10개, 인구수. 시각화
job_female_top10 <- welfare %>% 
  filter(!is.na(job) & gender == 'Female') %>% 
  count(job) %>% 
  arrange(desc(n)) %>% 
  head(10)

job_female_top10

ggplot(data = job_female_top10) +
  geom_col(mapping = aes(x = n, y = reorder(job, n))) +
  ylab('job')

# 종사하는 인구수가 성별로 차이가 많은 직종
# 1) (여성 - 남성) 내림차순 정렬 상위 10개 - 남성에 비해 여성이 더 많이 근무하는 직종 
# 2) (여성 - 남성) 내림차순 정렬 하위 10개 - 여성에 비해 남성이 더 많이 근무하는 직종

job_gender <- welfare %>% 
  filter(!is.na(job)) %>%  # job이 있는 자료들만 선택
  count(job, gender) %>%  # job별 gender별 인구수
  pivot_wider(names_from = gender, values_from = n) %>%  # pivoting
  # mutate(diff = replace_na(Female, 0) - replace_na(Male, 0))
  replace(is.na(.), 0) %>%  # 데이터 프레임에서 모든 NA를 0으로 대체
  mutate(diff = Female - Male,
         female_ratio = Female / (Female + Male),
         male_ratio = Male / (Female + Male))  # 파생 변수 추가.

job_gender

# 여성이 남성보다 많이 일하는 직종
job_gender %>% 
  arrange(desc(diff)) %>% 
  head(n = 10)

# 남성이 여성보다 많이 일하는 직종
job_gender %>% 
  arrange(desc(diff)) %>% 
  tail(n = 10)

df <- data.frame(col1 = c(1, NA, 2),
                 col2 = c(1, 2, NA))
df
is.na(df)

# 여성 인구 비율이 높은 직종 상위 10개
job_gender %>% 
  arrange(desc(female_ratio), desc(diff)) %>% 
  head(n = 10)

# 남성 인구 비율이 높은 직종 상위 10개
job_gender %>% 
  arrange(desc(female_ratio), desc(diff)) %>% 
  tail(n = 10)


# 직종별 월 소득 평균 상위 10개 -> 시각화
income_by_job <- welfare %>% 
  filter(!is.na(income) & !is.na(job)) %>%  # income과 job이 있는 자료들을 선택
  group_by(job) %>%  # job별 그룹
  summarize(mean_income = mean(income), n = n()) %>%   # 그룹별 평균 속득, 인구수 요약
  arrange(desc(mean_income))  # 평균 월 소득 내림차순 정렬

income_by_job

top10 <- income_by_job %>% head(n = 10)
ggplot(data = top10) +
  geom_col(mapping = aes(x = mean_income, y = reorder(job, mean_income)))

# 직종별 월 소득 평균 하위 10개 -> 시각화
bottom10 <- tail(income_by_job, n = 10)
ggplot(data = bottom10) +
  geom_col(mapping = aes(x = mean_income, 
                         y = reorder(job, desc(mean_income))))

# 직종별 인구수 20명 이상인 직종에서 월 소득 평균 상/하위 10개
top10 <- income_by_job %>% filter(n >= 20) %>% head(n = 10)
ggplot(data = top10) +
  geom_col(mapping = aes(x = mean_income, y = reorder(job, mean_income)))

bottom10 <- income_by_job %>% filter(n >= 20) %>% tail(n = 10)
bottom10
ggplot(data = bottom10) +
  geom_col(mapping = aes(x = mean_income, 
                         y = reorder(job, desc(mean_income))))

# 남성 평균 월 소득 상위 10개 직종. 직종별 남성 인구가 10명 이상인 경우.
male_top10 <- welfare %>% 
  filter(!is.na(income) & !is.na(job) & gender == 'Male') %>% 
  group_by(job) %>% 
  summarize(mean_income = mean(income), n = n()) %>% 
  filter(n >= 10) %>% 
  arrange(desc(mean_income)) %>% 
  head(n = 10)

male_top10  

# 여성 평균 월 소득 상위 10개 직종. 직종별 여성 인구가 10명 이상인 경우.
female_top10 <- welfare %>% 
  filter(!is.na(income) & !is.na(job) & gender == 'Female') %>% 
  group_by(job) %>% 
  summarize(mean_income = mean(income), n = n()) %>% 
  filter(n >= 10) %>% 
  arrange(desc(mean_income)) %>% 
  head(n = 10)

female_top10

# 10대, 20대 여성의 평균 월 소득 상위 10개 직종
young_female_top10 <- welfare %>% 
  filter(!is.na(income) & !is.na(job) & gender == 'Female' &
           age_range %in% c('age10', 'age20')) %>% 
  group_by(job) %>% 
  summarize(mean_income = mean(income), n = n()) %>% 
  arrange(desc(mean_income)) %>% 
  head(n = 10)

young_female_top10

# 10대, 20대 남성의 평균 월 소득 상위 10개 직종
young_male_top10 <- welfare %>% 
  filter(!is.na(income) & !is.na(job) & gender == 'Male' &
           age_range %in% c('age10', 'age20')) %>% 
  group_by(job) %>% 
  summarize(mean_income = mean(income), n = n()) %>% 
  arrange(desc(mean_income)) %>% 
  head(n = 10)

young_male_top10

# 30대, 40대, 50대 여성의 평균 월 소득 상위 10개 직종
middle_female_top10 <- welfare %>% 
  filter(!is.na(income) & !is.na(job) & gender == 'Female' &
           age_range %in% c('age30', 'age40', 'age50')) %>% 
  group_by(job) %>% 
  summarize(mean_income = mean(income), n = n()) %>% 
  arrange(desc(mean_income)) %>% 
  head(n = 10)

middle_female_top10

# 30대, 40대, 50대 남성의 평균 월 소득 상위 10개 직종
middle_male_top10 <- welfare %>% 
  filter(!is.na(income) & !is.na(job) & gender == 'Male' &
           age_range %in% c('age30', 'age40', 'age50')) %>% 
  group_by(job) %>% 
  summarize(mean_income = mean(income), n = n()) %>% 
  arrange(desc(mean_income)) %>% 
  head(n = 10)

middle_male_top10

# Chapter 2(ggplot2), 3(dplyr), 5(탐색적 데이터 분석), 8(readr), 9(tidyr), 10(dplyr)

welfare %>% 
  filter(!is.na(income) & !is.na(job)) %>% 
  group_by(age_range, gender, job) %>% 
  summarise(n = n(), AVG = mean(income)) %>% 
  filter(gender == 'Male' & age_range %in% c('age30', 'age40', 'age50')) %>% 
  arrange(desc(AVG)) %>% 
  head(n = 10) %>% 
  mutate(age_job = paste(age_range, job)) %>%  
  ggplot() +
  geom_col(mapping = aes(x = AVG, y = reorder(age_job, AVG),
                         fill = age_range))

