# join: inner, left, right, full 

library(tidyverse)
search()

emp <- data.frame(empno = c(100, 101, 102),
                  ename = c('Scott', 'King', 'Allen'),
                  deptno = c(10, 20, 40))
emp

dept <- data.frame(deptno = c(10, 20, 30),
                   dname = c('IT', 'HR', 'Sales'))
dept

# inner_join(df_left, df_right, by)
inner_join(emp, dept, by = 'deptno')
emp %>% inner_join(dept, by = 'deptno')

# join의 조건으로 사용하는 컬럼(변수) 이름이 두 테이블에서 같은 경우에는 
# by를 생략해도 됨.
inner_join(emp, dept)
emp %>% inner_join(dept)

# left_join(df_left, df_right, by)
left_join(emp, dept)
#> NA(Not Available): 결측값, 누락값

emp %>% left_join(dept)

# right_join
right_join(emp, dept)
emp %>% right_join(dept)

# full_join
full_join(emp, dept)
emp %>% full_join(dept)

dept2 <- data.frame(dept_no = c(10, 20, 30),
                    dept_name = c('IT', 'HR', 'Sales'))

# 두 테이블에서 join 조건으로 사용할 컬럼 이름이 다른 경우:
# by를 생략할 수 없음!
# by = c('left_table_col_name' = 'right_table_col_name')
inner_join(emp, dept2, by = c('deptno' = 'dept_no'))

# join 연습
# ggplot2::mpg 데이터 셋과 join하기 위한 데이터 프레임
fuel <- data.frame(fl = c('c', 'd', 'e', 'p', 'r'),
                   price = c(2.35, 2.38, 2.11, 2.75, 2.22))
fuel  # 연료 종류/gallon당 연료 가격

# mpg와 fuel 데이터 프레임을 inner_join
# mpg 데이터 프레임에 fuel_price (= hwy * price) 파생 변수 추가.
# 결과 확인.
mpg %>% 
  inner_join(fuel) %>% 
  mutate(fuel_price = hwy * price) %>% 
  select(model, hwy, price, fuel_price)
