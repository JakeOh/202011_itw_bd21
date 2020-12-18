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
