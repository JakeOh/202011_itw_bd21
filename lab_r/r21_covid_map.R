# https://github.com/nytimes/covid-19-data
#   미국의 Covid-19(코로나 바이러스) 데이터가 업데이트되는 github
# https://www.nytimes.com/interactive/2020/us/coronavirus-us-cases.html
#   위의 github의 데이터로 시각화한 그래프들이 있는 NY Times 사이트.
# github의 설명을 잘 읽어보고, 
# 미국의 주별 코로나 확진자 수를 지도 위에 시각화하기 위해 필요한 데이터를 찾아서
# 미국 지도 위에 현재 확진자 수를 시각화해보세요.

# NY Times의 여러 시각화 그래프들을 보시고,
# 같은 그래프들을 만들어 보세요.

# 대한민국의 시도별 코로나 바이러스 확진자수 데이터를 찾을 수 있으면,
# 대한민국의 지도 위에 확진자수를 시각화해보세요.

library(tidyverse)
library(plotly)
library(ggiraphExtra)
search()

# us-state.csv 파일을 다운로드 받을 수 있는 URL 주소
us_state_url <- 'https://github.com/nytimes/covid-19-data/raw/master/us-states.csv'

# utils::read.csv() 함수: data.frame 객체 생성
# readr::read_csv() 함수: tibble 객체 생성
# tibble: data.frame에 추가적인 속성들을 가지고 있는 클래스 객체

# 웹 상에 있는 CSV 파일을 다운로드해서 데이터 프레임을 생성.
us_covid <- read_csv(file = us_state_url)
head(us_covid)
tail(us_covid)
str(us_covid)
