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
library(xts)
library(dygraphs)
search()

# us-state.csv 파일을 다운로드 받을 수 있는 URL 주소
us_state_url <- 'https://github.com/nytimes/covid-19-data/raw/master/us-states.csv'

# utils::read.csv() 함수: data.frame 객체 생성
# readr::read_csv() 함수: tibble 객체 생성
# tibble: data.frame에 추가적인 속성들을 가지고 있는 클래스 객체

# 미국 코로나 바이러스 확진자/사망자 수 데이터
# 웹 상에 있는 CSV 파일을 다운로드해서 데이터 프레임을 생성.
us_covid <- read_csv(file = us_state_url)
head(us_covid)
tail(us_covid)
str(us_covid)

# 미국 지도 데이터
us_map <- map_data(map = 'state')
head(us_map)
tail(us_map)

# 코로나 데이터에서 주(state) 이름들을 모두 소문자로 변환
us_covid$state <- str_to_lower(us_covid$state)
head(us_covid)
tail(us_covid)

# 코로나 데이터에서 가장 최근 날짜만 선택
us_covid_recent <- filter(us_covid, date == as.Date('2020-12-26'))
head(us_covid_recent)
tail(us_covid_recent)

# 지도 데이터와 코로타 데이터를 join
us_map_covid <- left_join(us_map, us_covid_recent, by = c('region' = 'state'))
head(us_map_covid)

# 지도 데이터에 코로나 데이터를 시각화
g <- ggplot(data = us_map_covid,
       mapping = aes(x = long, y = lat, group = group, fill = cases)) +
  geom_polygon(color = 'darkgray') +
  coord_quickmap() +
  scale_fill_continuous(low = 'lightyellow', high = 'red')
g
ggplotly(g)

# choropleth plot
ggChoropleth(data = us_covid_recent,
             map = us_map,
             mapping = aes(map_id=state, fill=cases),
             interactive = TRUE)

# 날짜별 확진자 수의 변화
head(us_covid, n = 10)

us_covid_ts <- us_covid %>% 
  group_by(date) %>% 
  summarize(cases = sum(cases), deaths = sum(deaths))
head(us_covid_ts)
tail(us_covid_ts)

g <- ggplot(data = us_covid_ts,
            mapping = aes(x = date, y = cases)) +
  geom_line()
g
ggplotly(g)

covid_xts <- xts(x = us_covid_ts$cases, order.by = us_covid_ts$date)
str(covid_xts)
dygraph(covid_xts) %>% dyRangeSelector()


region <- c('충북', '충북', '충남', '충남')
region <- str_replace(region, '충북', '충청북도')
region

# -----
# http://www.gisdeveloper.co.kr/?p=2332 사이트에서 
# 2020년 5월 시도 지도 데이터 다운로드 (CTPRVN_202005.zip)
# 다운로드한 파일을 압축 해제(CTPRVN.shp 파일)
# 압축 해제한 폴더를 C:/lab/lab_r 폴더로 이동.

# install.packages('ggmap')
# install.packages('raster')
# install.packages('rgeos')
# install.packages('maptools')
# install.packages('rgdal')

library(ggmap)
library(raster)
library(rgeos)
library(maptools)
search()

korea_sido <- shapefile('CTPRVN_202005/CTPRVN.shp')  # shp 파일 불러오기.
str(korea_sido)

korea_sido <- spTransform(korea_sido, CRS('+proj=longlat'))  # 위도/경도 좌표계 설정.

korea_sido_map <- fortify(korea_sido)  # shp 내용을 데이터 프레임으로 변환
str(korea_sido_map)

ggplot(data = korea_sido_map,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(color = 'darkgray', fill = 'white') +
  coord_map('polyconic')

distinct(korea_sido_map, id)
