# 지도 위에 데이터 표현하기

# 지도 데이터를 가지고 있는 패키지 설치
# install.packages('maps')

# ggplot2::coord_map() 함수를 사용할 때 필요한 패키지
# install.packages('mapproj')

# 필요한 패키지를 메모리 로딩
library(tidyverse)
search()

# 지도 데이터 불러오기:
# ggplot2::map_data(map = '지도이름')
#   지도 데이터를 읽어서 데이터 프레임으로 변환해 주는 함수.
usa <- map_data(map = 'usa')
head(usa)
str(usa)
# usa 데이터 프레임의 변수들:
# long: longitude(경도).
#   영국 그리니치 천문대를 기준으로 동/서 방향의 좌표.
#   동쪽으로 변할 때는 +, 서쪽으로 변할 때는 -.
# lat: latitude(위도).
#   적도를 기준으로 남(-)/북(+) 방향의 좌표.
# group: 함께 연결할 위도/경도 점들의 그룹(나라, 주, 도시)
# order: 위도/경도 점들을 연결하는 순서.
# region, subregion: 지역 이름

# usa(미국 지도 데이터) 데이터 프레임 시각화
ggplot(data = usa,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(color = 'black', fill = 'white') +
  coord_quickmap()

ggplot(data = usa,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(color = 'black', fill = 'white') +
  coord_map(projection = 'polyconic')

# maps 패키지의 state: 미국 주(state) 위치(위도/경도) 정보가 포함된 지도 데이터.
usa_state <- map_data(map = 'state')
head(usa_state)
str(usa_state)
distinct(usa_state, region)
distinct(usa_state, subregion)

ggplot(data = usa_state,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(color = 'black', fill = 'white') +
  coord_map(projection = 'polyconic')  # coord_quickmap()

# maps 패키지의 world 맵: 세계 지도 데이터
# 세계 지도 데이터 에서 관심있는 몇 개 지역만 선택 지도 그리기
asia_map <- map_data(map = 'world',
                     region = c('South Korea', 'North Korea',
                                'China', 'Japan', 'India'))
head(asia_map)
distinct(asia_map, region)

ggplot(data = asia_map,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(mapping = aes(fill = region), color = 'black') +
  coord_map(projection = 'polyconic')


# datasets::USArrests 데이터 셋 - 미국 범죄 통계 데이터
# 미국 주(state) 지도 위에 범죄 통계 데이터를 시각화
head(usa_state)  # 미국 주(state) 지도 데이터
head(USArrests)  # 미국 주(state) 범죄 데이터
str(USArrests)
#> state 이름들이 컬럼에 있지 않고, row label(name)으로만 존재.
#> 지도 데이터와 join하기 위해서는 
# state 이름들을 컬럼(변수)로 변환할 필요가 있음.
us_arrests <- rownames_to_column(USArrests, var = 'state')
head(us_arrests)
str(us_arrests)

distinct(us_arrests, state)
#> 50개 주 이름들(state 변수)의 첫글자가 대문자!

distinct(usa_state, region)
#> 하와이 제외한 49개 주 이름들은 모두 소문자!

# us_arrests 데이터 프레임의 state 변수의 모든 값들을 소문자로 변환 후,
# usa_state 지도 데이터 프레임과 join
us_arrests$state <- tolower(us_arrests$state)
head(us_arrests)

# usa_state <== left_join == us_arrests
state_arrests <- left_join(usa_state, us_arrests, 
                           by = c('region' = 'state'))
head(state_arrests)
tail(state_arrests)

# 미국 지도 위에 Murder 발생 건수를 색깔로 표현
ggplot(data = state_arrests,
       mapping = aes(x = long, y = lat, group = group, fill = Murder)) +
  geom_polygon(color = 'black') +
  coord_quickmap() +
  scale_fill_continuous(low = 'white', high = 'red')

