# 한국 복지 패널 데이터 분석(Koweps_hpc10_2015_beta1.sav)
# 확장자 sav 파일: 통계 프로그램 SPSS에서 사용하는 파일.
# Koweps_Codebook.xlsx: sav 파일의 변수들에 대한 설명 파일.

# install.packages('haven')
# haven 패키지: SPSS, Stata, SAS 통계 프로그램에서 사용하는 파일을 사용할 때. 

# install.packages('foreign')
# foreign 패키지: SPSS 통계 프로그램에서 사용하는 파일을 사용할 때. 

# 필요한 패키지를 메모리에 로딩.
library(haven)
library(tidyverse)
search()

# haven::read_sav() 함수
# sav 파일을 읽어서 데이터 프레임을 생성
koweps <- read_sav(file = 'data/Koweps_hpc10_2015_beta1.sav')
str(koweps)

# 변수(컬럼) 이름 변경 -> 관심있는 변수만 선택
# dplyr::rename(data_frame, new_var_name = old_var_name, ...)

# h10_g3    ==> gender(성별)
# h10_g4    ==> birth(태어난 연도)
# h10_g10   ==> marriage(혼인상태)
# h10_g11   ==> religion(종교)
# h10_eco9  ==> job_code(직종 코드)
# p1002_8aq1 ==> income(월 소득)
# h10_reg7  ==> region_code(전국을 7개 권역으로 나눈 지역 코드)

welfare <- koweps %>% 
  rename(gender = h10_g3,
         birth = h10_g4,
         marriage = h10_g10,
         religion = h10_g11,
         job_code = h10_eco9,
         income = p1002_8aq1,
         region_code = h10_reg7) %>% 
  select(gender, birth, marriage, religion, job_code, income, region_code)

# 데이터 프레임 일부 확인
head(welfare)

# 성별(gender) 변수 확인
table(welfare$gender)
# 7578 + 9086 
# gender 변수는 1, 2 두 값만 갖는 카테고리 타입 변수. NA 없음.
# gender 변수를 factor 타입으로 변환
welfare$gender <- factor(welfare$gender,                # factor 타입으로 변환할 변수.
                         levels = c(1, 2),              # 변수가 가지고 있는 값들.
                         labels = c('Male', 'Female'))  # 각각의 값들에 붙여줄 별명.
str(welfare)
table(welfare$gender)

# 묵시적 타입 변환(implicit type conversion)
# as.xxx(arg): arg를 명시적 타입 변환(explicit type conversion) 
# as.factor(), as.integr(), as.double(), as.numeric(), as.logical(), 
# as.character() as.data.frame(), as.Date()
int_vector <- c(1, 1, 2, 2, 3, 3)
class(int_vector)
fac_1 <- as.factor(int_vector)  # levels, labels을 지정할 수 없음.
class(fac_1)
fac_1

logi_vector <- c(TRUE, TRUE, FALSE, TRUE, FALSE)
class(logi_vector)
fac_2 <- as.factor(logi_vector)
class(fac_2)
fac_2

char_vector <- c('male', 'male', 'female', 'female')
class(char_vector)
fac_3 <- as.factor(char_vector)
class(fac_3)
fac_3

# 성별 시각화 -> 막대 그래프
ggplot(data = welfare) +
  geom_bar(mapping = aes(x = gender, fill = gender))

# 성별 월 수입 차이?
# income(월 수입) 변수 확인
class(welfare$income)  #> numeric(숫자 타입)
# 기술 통계량(descriptive statistics): 최솟값, 최댓값, 평균, 중앙값, ...
summary(welfare$income)

# 코드북: 소득의 정상 범위 1 ~ 9998
welfare %>% filter(income < 1 | income > 9998)

# income의 범위가 1 ~ 9998인 것만 정상 데이터로 생각하고, 
# 그 이외의 값들은 NA로 처리.
welfare$income <- ifelse(welfare$income >= 1 & welfare$income <= 9998, 
                         welfare$income, NA)
summary(welfare$income)

# 월 소득 분포 시각화 - box plot, histogram
ggplot(data = welfare) +
  geom_boxplot(mapping = aes(y = income))

ggplot(data = welfare) +
  geom_histogram(mapping = aes(x = income))
#> right-skewed distribution: 오른쪽으로 꼬리가 긴 분포

# 성별 월 소득 평균: group_by() %>% summarize()
mean(welfare$income)
mean(welfare$income, na.rm = TRUE)
# 숫자형 데이터들을 집계(sum, mean, median, sd, ...)할 때 NA가 있으면 결과도 NA
# 집계 함수들은 na.rm 파라미터를 가지고 있음. na.rm의 기본값은 FALSE.
# NA들을 제외하고 집계할 때는 na.rm = TRUE로 설정.

welfare %>% 
  group_by(gender) %>% 
  summarize(mean_income = mean(income, na.rm = TRUE))

# is.na(x): x가 NA이면 TRUE, NA가 아니면 FALSE 리턴하는 함수.
# x = NA와 같이 비교하면 안됨!
income_by_gender <- welfare %>% 
  filter(!is.na(income)) %>%             # income이 NA가 아닌 자료들을 선택
  group_by(gender) %>%                   # gender별로 그룹
  summarize(mean_income = mean(income))  # 그룹별 평균

income_by_gender

# 성별 월 소득 시각화 - 막대 그래프
ggplot(data = income_by_gender) +
  geom_col(mapping = aes(x = gender, y = mean_income, fill = gender))


# 나이에 따라서 월 소득 차이?
# birth(출생 연도) 변수 확인
class(welfare$birth)
summary(welfare$birth)  #> 이상치가 없음. NA 없음.

# age(나이) 파생 변수 생성 - mutate
welfare <- welfare %>% mutate(age = 2015 - birth)
head(welfare)

# 나이별 인구수
table(welfare$age)

ggplot(data = welfare) +
  geom_bar(mapping = aes(x = age))

# 각 나이별 평균 월 수입
income_by_age <- welfare %>% 
  group_by(age) %>% 
  summarize(mean_income = mean(income, na.rm = TRUE))

income_by_age
income_by_age[20:25, ]
summary(income_by_age$mean_income)  #> 평균이 NaN인 자료가 33개

ggplot(data = income_by_age) +
  geom_col(mapping = aes(x = age, y = mean_income))

# 위의 결과와 비교
income_by_age2 <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarize(mean_income = mean(income))

income_by_age2

ggplot(data = income_by_age2) +
  geom_col(mapping = aes(x = age, y = mean_income))

ggplot(data = income_by_age2) +
  geom_line(mapping = aes(x = age, y = mean_income))

# 평균 월 소득이 가장 많은 나이?
income_by_age2 %>% filter(mean_income == max(mean_income))  #> 52

ggplot(data = income_by_age2) +
  geom_line(mapping = aes(x = age, y = mean_income)) +
  geom_vline(xintercept = 52, color = 'red')
  # vline: vertical line(수직선), xintercept: x절편(x축과 만나는 점)

# age별, gender별 평균 월 소득
income_by_age_gender <- welfare %>% 
  group_by(age, gender) %>% 
  summarize(mean_income = mean(income, na.rm = TRUE))

income_by_age_gender
summary(income_by_age_gender$mean_income)

ggplot(data = income_by_age_gender) +
  geom_col(mapping = aes(x = age, y = mean_income, fill = gender))

income_by_age_gender <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, gender) %>% 
  summarize(mean_income = mean(income))

income_by_age_gender

ggplot(income_by_age_gender) +
  geom_col(mapping = aes(x = age, y = mean_income, fill = gender))

ggplot(income_by_age_gender) +
  geom_col(mapping = aes(x = age, y = mean_income, fill = gender),
           position = 'dodge')

ggplot(income_by_age_gender) +
  geom_line(mapping = aes(x = age, y = mean_income, color = gender))


# 연령대별 인구 수 -> 연령대별 월 소득 파악
# 파생 변수: age_range 
# 20-(age10), 20-29(age20), 30-39(age30), 40-49(age40), 
# 50-59(age50), 60-69(age60), 70-79(age70), 80+(age80)

welfare <- welfare %>% 
  mutate(age_range = ifelse(age < 20, 'age10', 
                            ifelse(age < 30, 'age20',
                                   ifelse(age < 40, 'age30',
                                          ifelse(age < 50, 'age40', 
                                                 ifelse(age < 60, 'age50',
                                                        ifelse(age < 70, 'age60',
                                                               ifelse(age < 80, 'age70', 'age80'))))))))

head(welfare)

# 연령대별 인구수
table(welfare$age_range)
ggplot(data = welfare) +
  geom_bar(mapping = aes(x = age_range))

# 연령대별 월 소득 평균
income_by_agerange <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age_range) %>% 
  summarize(mean_income = mean(income))

income_by_agerange

ggplot(data = income_by_agerange) +
  geom_col(mapping = aes(x = age_range, y = mean_income))

# 연령대(age_range)별 성(gender)별 월 소득(income) 평균
income_by_agerange_gender <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age_range, gender) %>% 
  summarize(mean_income = mean(income))

income_by_agerange_gender

ggplot(data = income_by_agerange_gender) +
  geom_col(mapping = aes(x = age_range, y = mean_income, fill = gender))

ggplot(data = income_by_agerange_gender) +
  geom_col(mapping = aes(x = age_range, y = mean_income, fill = gender),
           position = 'dodge')

ggplot(data = income_by_agerange_gender, 
       mapping = aes(x = age_range, y = mean_income,
                     group = gender, color = gender)) +
  geom_line() +
  geom_point()


# Global Environment에 있는 객체(object)를 파일 저장.
# base::save(obj1, obj2, ..., file = 'file_name.rdata')
save(koweps, welfare, file = 'data/koweps.RData')
