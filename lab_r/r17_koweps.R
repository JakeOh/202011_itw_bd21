library(tidyverse)
search()

load(file = 'data/koweps.RData')
head(welfare)

# 지역별 인구 분석
# 지역코드(region_code), 지역이름(region)을 가지고 있는 데이터 프레임
region_list <- data.frame(region_code =1:7,
                          region =c('서울',
                                    '수도권(인천/경기)',
                                    '부산/경남/울산',
                                    '대구/경북',
                                    '대전/충남',
                                    '강원/충북',
                                    '광주/전남/전북/제주도'))
region_list

# welfare 데이터 프레임과 region_list 데이터 프레임을 join

