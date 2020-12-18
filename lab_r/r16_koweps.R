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
