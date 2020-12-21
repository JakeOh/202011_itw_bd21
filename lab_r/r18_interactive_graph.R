# interactive 그래프 그리기.

# interactive 그래프를 그리기 위한 패키지
# install.packages('plotly')

library(tidyverse)
library(plotly)
search()

# ggplot2::mpg 데이터 셋 시각화
# hwy ~ displ 산점도 그래프, drv에 따라서 점의 색깔을 다르게 설정.
# ggplot 객체(그래프 객체) 생성
g <- ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv))
# 그래프를 화면에 출력
g
# plotly::ggplotly(graph_obj): ggplot 객체(그래프 객체)를 interactive 그래프로 변환
ggplotly(g)

# RStudio 오른쪽 하단의 Plots 탭에서 Export -> Save as Web Page... -> 파일 이름 작성 저장.
# 저장된 html 파일은 웹 브라우저(크롬, 엣지 등)로 볼 수 있음.

# ggplot 객체없이 직접 interactive 그래프 그리기.
plot_ly(data = mpg, x = ~displ, y = ~hwy, color = ~drv, type = 'scatter')

# hwy ~ displ 산점도 그래프. 
# 점의 색깔은 drv에 따라서, 점의 모양은 class에 따라서 다르게 설정.
g <- ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv, shape = class))
g
ggplotly(g)

plot_ly(data = mpg, type = 'scatter',
        x = ~displ, y = ~hwy, color = ~drv, symbol = ~class)

# drv별 hwy의 boxplot
g <- ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = drv, y = hwy))
g
ggplotly(g)

plot_ly(data = mpg, type = 'box', x = ~drv, y = ~hwy)

# ggplot2::economics 데이터 셋
head(economics)
tail(economics)

# 시간(date)에 따른 개인 저축률(psavert)의 변화 시계열 그래프(선 그래프)
g <- ggplot(data = economics,
            mapping = aes(x = date, y = psavert)) +
  geom_line()
g
ggplotly(g)

plot_ly(data = economics, type = 'scatter', mode = 'lines',
        x = ~date, y = ~psavert)

# economics에 실업률(%) 파생 변수가 추가된 데이터 프레임 생성
# 시간에 따른 실업률 시계열 그래프
economics <- ggplot2::economics %>% 
  mutate(unemploy_pct = (unemploy / pop) * 100)
head(economics)
tail(economics)

g <- ggplot(data = economics,
            mapping = aes(x = date, y = unemploy_pct)) +
  geom_line()
g
ggplotly(g)

plot_ly(data = economics, type = 'scatter', mode = 'lines',
        x = ~date, y = ~unemploy_pct)
