# gapminder 패키지 설치
# install.packages('gapminder')

# 패키지를 메모리에 로딩.
library(tidyverse)
library(gapminder)
search()

# gapminder::gapminder 데이터 셋 확인
str(gapminder)
#> Factor w/ 142 levels: 142개의 범주를 갖는 Factor 타입(범주 타입) 변수

head(gapminder)
tail(gapminder)

# 국가(country)는 몇 개?
# select distinct country from gapminder;
gapminder %>% distinct(country)
# select count(distinct country) from gapminder;
gapminder %>% distinct(country) %>% summarize(n = n())
gapminder %>% distinct(country) %>% count()

# 대륙(continent)는 몇 개?
gapminder %>% distinct(continent)
gapminder %>% distinct(continent) %>% count()

# year의 최솟값, 최댓값
min(gapminder$year)
max(gapminder$year)
distinct(gapminder, year)
summarize(gapminder, min_year = min(year), min_max = max(year))
gapminder %>% summarize(min_year = min(year), min_max = max(year))

# lifeExp가 최댓값인 자료(observation)을 출력
max(gapminder$lifeExp)
filter(gapminder, lifeExp == max(lifeExp))
gapminder %>% filter(lifeExp == max(lifeExp))

# pop가 최댓값인 자료를 출력
max(gapminder$pop)
gapminder %>% filter(pop == max(pop))

# gdpPercap이 최댓값인 자료를 출력
gapminder %>% filter(gdpPercap == max(gdpPercap))

# 대한민국의 통계 자료를 gapminder_kr 데이터 프레임으로 생성.
names <- c('scott', 'smith', 'king', 'allens')
str_detect(names, 's')  # 문자열에 특정 문자열 패턴이 포함되어 있는지 검사.
# select * from emp where ename like '%s%';

str_to_upper(names)  # 문자열을 대문자로 변환.

gapminder %>% 
  filter(str_detect(str_to_lower(country), 'korea')) %>% 
  distinct(country)

gapminder_kr <- gapminder %>% filter(country == 'Korea, Rep.')
gapminder_kr

# 대한민국의 연도별 인구를 시각화
ggplot(data = gapminder_kr) +
  geom_line(mapping = aes(x = year, y = pop))

ggplot(data = gapminder_kr, mapping = aes(x = year, y = pop)) +
  geom_point() +
  geom_line()

# 대한민국의 연도별 1인당 GDP를 시각화
ggplot(data = gapminder_kr, mapping = aes(x = year, y = gdpPercap)) +
  geom_point() +
  geom_line()

# 2007년의 1인당 GDP 상위 5개 나라를 출력. 시각화.
df <- gapminder %>% 
  filter(year == 2007) %>%       # 2007년 선택
  arrange(desc(gdpPercap)) %>%   # gdpPercap 내림차순 정렬
  head(n = 5)                    # 상위 5개 선택
df
ggplot(data = df) +
  geom_col(mapping = aes(x = reorder(country, desc(gdpPercap)), 
                         y = gdpPercap)) +
  xlab('country') +
  coord_cartesian(ylim = c(35000, 50000))

# 2007년의 1인당 GDP 하위 5개 나라를 출력. 시각화.
df <- gapminder %>% 
  filter(year == 2007) %>% 
  arrange(gdpPercap) %>% 
  head(n = 5)
df
ggplot(data = df) +
  geom_col(mapping = aes(x = reorder(country, gdpPercap),
                         y = gdpPercap)) +
  coord_cartesian(ylim = c(200, 600)) +
  xlab('country')

# 2007년 lifeExp 상위 5개 국가 출력, 시각화.
df <- gapminder %>% 
  filter(year == 2007) %>% 
  arrange(desc(lifeExp)) %>% 
  head(n = 5)

df

ggplot(data = df) +
  geom_col(mapping = aes(x = country, y = lifeExp))

# 2007년 lifeExp 하위 5개 국가 출력, 시각화.
df <- gapminder %>% 
  filter(year == 2007) %>% 
  arrange(lifeExp) %>% 
  head(n = 5)

df

ggplot(data = df) +
  geom_col(mapping = aes(x = country, y = lifeExp))

# 연도별 1인당 GDP 최댓값인 레코드 출력
gapminder %>% 
  group_by(year) %>% 
  filter(gdpPercap == max(gdpPercap)) %>% 
  arrange(year)

# 대륙별 1인당 GDP 최댓값인 레코드 출력
gapminder %>% 
  group_by(continent) %>% 
  filter(gdpPercap == max(gdpPercap)) %>% 
  arrange(continent)

# 연도별, 대륙별 인구수
df <- gapminder %>% 
  group_by(year, continent) %>% 
  summarize(pop = sum(pop))
df
ggplot(data = df, mapping = aes(x = year, y = pop, color = continent)) +
  geom_line() + geom_point()

df <- gapminder %>% 
  group_by(year, continent) %>% 
  summarize(pop = sum(pop)) %>% 
  pivot_wider(names_from = continent, values_from = pop)
df
ggplot(data = df, mapping = aes(x = year)) +
  geom_line(mapping = aes(y = Africa, color = 'Africa')) +
  geom_line(mapping = aes(y = Americas, color = 'Americas')) +
  geom_line(mapping = aes(y = Asia, color = 'Asia')) +
  geom_line(mapping = aes(y = Europe, color = 'Europe')) +
  geom_line(mapping = aes(y = Oceania, color = 'Oceania')) +
  ylab('population')

# 연도별, 대륙별 lifeExp의 평균
df <- gapminder %>% 
  group_by(year, continent) %>% 
  summarize(life_exp = mean(lifeExp))
df
ggplot(data = df, mapping = aes(x = year, y = life_exp, color = continent)) +
  geom_line() +
  geom_point()

gapminder %>% 
  group_by(year, continent) %>% 
  summarize(life_exp = mean(lifeExp)) %>% 
  pivot_wider(names_from = continent, values_from = life_exp)

# 연도별, 대륙별 gdpPercap의 평균
df <- gapminder %>% 
  group_by(year, continent) %>% 
  summarize(gdp_per_cap = mean(gdpPercap))
df
ggplot(data = df, mapping = aes(x = year, y = gdp_per_cap, color = continent)) +
  geom_point() +
  geom_line()

gapminder %>% 
  group_by(year, continent) %>% 
  summarize(gdp_per_cap = mean(gdpPercap)) %>% 
  pivot_wider(names_from = continent, values_from = gdp_per_cap)

# Egypt, Gabon, South Africa, Zimbabwe의 기대 수명(lifeExp)의 시계열
gapminder %>% 
  filter(country %in% c('Egypt', 'Gabon', 'South Africa', 'Zimbabwe')) %>% 
  ggplot(mapping = aes(x = year, y = lifeExp, color = country)) +
  geom_point() + 
  geom_line()
