/*
1) https://github.com/JakeOh/202011_itw_bd21/blob/main/datasets/gapminder.tsv 파일 다운로드
2) 파일의 내용을 저장할 수 있는 테이블을 생성.
   테이블 이름: GAPMINDER
   컬럼: COUNTRY, CONTINENT, YEAR, LIFE_EXP, POP, GDP_PERCAP
3) SQLDeveloper의 데이터 임포트 기능을 사용해서 파일의 내용을 테이블에 임포트
4) 테이블에는 모두 몇 개의 나라가 있을까요?
5) 테이블에는 모두 몇 개의 대륙이 있을까요?
6) 테이블에는 저장된 데이터는 몇년도부터 몇년도까지 조사한 내용일까요?
7) 평균 수명이 최댓값인 레코드(row)를 찾으세요.
8) 인구가 최댓값인 레코드(row)를 찾으세요.
9) 1인당 GDP가 최댓값인 레코드(row)를 찾으세요.
10) 우리나라의 통계 자료만 출력하세요.
11) 연도별 1인당 GDP의 최댓값인 레코드를 찾으세요.
12) 대륙별 1인당 GDP의 최댓값인 레코드를 찾으세요.
13) 연도별, 대륙별 인구수를 출력하세요.
    인구수가 가장 많은 연도와 대륙은 어디인가요?
14) 연도별, 대륙별 평균 수명의 평균을 출력하세요.
    평균 수명이 가장 긴 연도와 대륙은 어디인가요?
15) 연도별, 대륙별 1인당 GDP의 평균을 출력하세요.
    1인당 GDP의 평균이 가장 큰 연도와 대륙은 어디인가요?
*** 수업 외 내용 ***
16) 13번 문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
17) 14번 문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
18) 15번 문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
*/

-- 2)
create table gapminder (
    country     varchar2(100),
    continent   varchar2(100),
    year        number(4),
    life_exp    number,
    pop         number,
    gdp_percap  number
);

desc gapminder;

-- 3)
select * from gapminder;

-- 4)
select count(distinct country) from gapminder;

-- 5)
select count(distinct continent) from gapminder;

-- 6)
select min(year), max(year) from gapminder;
select distinct year from gapminder order by year;

-- 7)
select * from gapminder
where life_exp = (
    select max(life_exp) from gapminder
    );
    
-- 8)
select * from gapminder
where pop = (
    select max(pop) from gapminder
    );
    
-- 9)
select * from gapminder
where gdp_percap = (
    select max(gdp_percap) from gapminder
    );
    
-- 10)
select distinct country from gapminder 
where lower(country) like '%korea%';

select * from gapminder
where lower(country) = 'korea, rep.';

-- 11)
select * from gapminder
where (year, gdp_percap) in (
    select year, max(gdp_percap) from gapminder
    group by year
    )
order by year;

-- 12)
select * from gapminder
where (continent, gdp_percap) in (
    select continent, max(gdp_percap) from gapminder
    group by continent
    )
order by continent;

-- 13)
select year, continent, sum(pop) as population 
from gapminder
group by year, continent
order by year, continent;

select year, continent, sum(pop) as population
from gapminder
group by year, continent
order by population desc;

with a as (
    select year, continent, sum(pop) as population
    from gapminder
    group by year, continent
)
select year, continent from a
where population = (
    select max(population) from a
);


-- 14)
select year, continent, round(avg(life_exp), 1) as avg_life_exp
from gapminder
group by year, continent
order by year, continent;

select year, continent, round(avg(life_exp), 1) as avg_life_exp
from gapminder
group by year, continent
order by avg_life_exp desc;

with a as (
    select year, continent, round(avg(life_exp), 1) as avg_life_exp
    from gapminder
    group by year, continent
)
select year, continent from a
where avg_life_exp = (
    select max(avg_life_exp) from a
);

-- 15)
select year, continent, round(avg(gdp_percap), 1) as avg_gdp_percap
from gapminder
group by year, continent
order by year, continent;

select year, continent, round(avg(gdp_percap), 1) as avg_gdp_percap
from gapminder
group by year, continent
order by avg_gdp_percap desc;

with a as (
    select year, continent, round(avg(gdp_percap), 1) as avg_gdp_percap
    from gapminder
    group by year, continent
)
select year, continent from a
where avg_gdp_percap = (
    select max(avg_gdp_percap) from a
);

-- 16)
with subqr as (
    select year, continent, pop from gapminder
)
select * from subqr
pivot (
    sum(pop) for continent in ('Africa' as africa,
        'Americas' as america,
        'Asia' as asia,
        'Europe' as europe,
        'Oceania' as oceania
    )
)
order by year;

-- 17)
with subqr as (
    select year, continent, life_exp from gapminder
)
select * from subqr
pivot (
    avg(life_exp) for continent in ('Africa' as africa,
        'Americas' as america,
        'Asia' as asia,
        'Europe' as europe,
        'Oceania' as oceania
    )
)
order by year;

with subqr as (
    select year, continent, round(avg(life_exp), 1) as avg_life_exp
    from gapminder
    group by year, continent
)
select * from subqr
pivot (
    max(avg_life_exp) for continent in ('Africa' as africa,
        'Americas' as america,
        'Asia' as asia,
        'Europe' as europe,
        'Oceania' as oceania
    )
)
order by year;

-- 18)
with subqr as (
    select year, continent, gdp_percap from gapminder
)
select * from subqr
pivot (
    avg(gdp_percap) for continent in ('Africa' as africa,
        'Americas' as america,
        'Asia' as asia,
        'Europe' as europe,
        'Oceania' as oceania
    )
)
order by year;

with subqr as (
    select year, continent, round(avg(gdp_percap), 1) as avg_gdp_percap
    from gapminder
    group by year, continent
)
select * from subqr
pivot (
    max(avg_gdp_percap) for continent in ('Africa' as Africa,
        'Americas' as America,
        'Asia' as Asia,
        'Europe' as Europe,
        'Oceania' as Oceania
    )
)
order by year;
