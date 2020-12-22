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

