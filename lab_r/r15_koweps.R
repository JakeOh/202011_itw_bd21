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
