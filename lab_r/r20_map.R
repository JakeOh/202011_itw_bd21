# install.packages('devtools')
# devtools::install_github('cardiomoon/kormaps2014')

# install.packages('패키지이름'):
#   R 패키지 중앙 저장소(CRAN: Comprehensive R Archive Network)에 등록된 패키지를 다운받고 설치.
#   https://cran.r-project.org/
# CRAN에 등록되어 있지 않고, 개인/단체 저장소(github)에 저장된 패키지를 설치할 필요가 있을 수 있음.
# devtools::install_github() 함수를 사용해서 github의 패키지를 설치할 수 있음.

# 필요한 패키지 메모리 로드
library(tidyverse)
library(ggiraphExtra)
library(kormaps2014)
library(gdtools)
search()

# maps 패키지의 world 지도에서 한국만 선택 지도 시각화
korea_map <- map_data(map = 'world',
                      region = c('South Korea'))
head(korea_map)
distinct(korea_map, region)
distinct(korea_map, subregion)

ggplot(data = korea_map,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(color = 'black', fill = 'white') +
  coord_quickmap()

# kormaps2014 패키지에 포함된 한국 지도 데이터 시각화
head(kormap1)
str(kormap1)
ggplot(data = kormap1,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = 'white', color = 'darkgray') +
  coord_quickmap()

# kormaps2014 패키지의 지도 데이터 프레임: kormap1, kormap2, kormap3
str(kormap2)
ggplot(data = kormap2,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = 'white', color = 'darkgray') +
  coord_quickmap()

str(kormap3)

# kormap2 지도 데이터 프레임을 사용. 서울 지도를 시각화.
# sigungu_cd 변수(컬럼)의 값이 '11'로 시작하면 서울시의 구.
# str_starts() 함수 사용.

