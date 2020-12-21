library(tidyverse)
search()

load(file = 'data/koweps.RData')
head(welfare)

# 지역별 인구 분석
# 지역코드(region_code), 지역이름(region)을 가지고 있는 데이터 프레임
region_list <- data.frame(region_code = 1:7,
                          region = c('서울',
                                     '수도권(인천/경기)',
                                     '부산/경남/울산',
                                     '대구/경북',
                                     '대전/충남',
                                     '강원/충북',
                                     '광주/전남/전북/제주도'))
region_list

# welfare 데이터 프레임과 region_list 데이터 프레임을 join
welfare <- left_join(welfare, region_list)
head(welfare)

# 지역별 인구수 - 테이블, 그래프
table(welfare$region)
sum(table(welfare$region))

ggplot(data = welfare) +
  geom_bar(mapping = aes(y = region))

# 지역별 성별 인구수 - 테이블, 그래프.
welfare %>% count(region, gender)
welfare %>% group_by(region, gender) %>% summarise(n = n())

ggplot(data = welfare) +
  geom_bar(mapping = aes(x = region, fill = gender))  # position = 'stack'

ggplot(data = welfare) +
  geom_bar(mapping = aes(x = region, fill =  gender),
           position = 'dodge')

# 지역별 성비(gender ratio)
ggplot(data = welfare) +
  geom_bar(mapping = aes(y = region, fill =  gender),
           position = 'fill')

# welfare 데이터 프레임에 ages 변수를 추가
#   age < 30이면 'young', age < 60이면 'middle', age >= 60이면, 'old'
# welfare$new_var <- ...
welfare <- welfare %>% 
  mutate(ages = ifelse(age < 30, 'young',
                       ifelse(age < 60, 'middle', 'old')))
table(welfare$ages)

# ages 변수를 factor로 변환(카테고리 타입 변수로 변환) - as.factor(), factor()
welfare$ages <- factor(welfare$ages,
                       levels = c('young', 'middle', 'old'))
table(welfare$ages)

# region별, ages별 인구수 - 테이블, 그래프
df <- welfare %>% count(region, ages)
df

ggplot(data = welfare) +
  geom_bar(mapping = aes(x = region, fill = ages))

ggplot(data = welfare) +
  geom_bar(mapping = aes(x = region, fill = ages),
           position = 'dodge')

ggplot(data = welfare) +
  geom_bar(mapping = aes(x = region, fill = ages),
           position = 'fill')

ggplot(data = welfare) +
  geom_bar(mapping = aes(y = region, fill = ages),
           position = 'fill')

# region별 income의 평균을 찾고, 시각화.
income_by_region <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(region) %>% 
  summarize(mean_income = mean(income))

income_by_region

ggplot(data = income_by_region) +
  geom_col(mapping = aes(x = mean_income, y = reorder(region, mean_income)))

# region별 gender별 income의 평균을 찾고, 시각화.
income_by_region_gender <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(region, gender) %>% 
  summarize(mean_income = mean(income))

income_by_region_gender

ggplot(data = income_by_region_gender) +
  geom_col(mapping = aes(x = region, y = mean_income, fill = gender),
           position = 'dodge')

# region별 ages별 income의 평균을 찾고, 시각화.
income_by_region_ages <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(region, ages) %>% 
  summarize(mean_income = mean(income))

income_by_region_ages

ggplot(data = income_by_region_ages) +
  geom_col(mapping = aes(x = region, y = mean_income, fill = ages),
           position = 'dodge')
