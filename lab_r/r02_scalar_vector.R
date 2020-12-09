# scalar(스칼라): 한개의 값이 저장된 객체(object, 변수 variable).
# vector(벡터): 한가지 타입(유형)의 여러개의 값이 1차원으로 저장된 객체.

# scalar의 예
x <- 100  # x: 숫자 한개를 저장하고 있는 scalar
name <- '오쌤'  # name: 문자열 한개를 저장하고 있는 scalar
name
# R에서는 문자열을 작은따옴표('') 또는 큰따옴표("")로 묶을 수 있음.
# (비교) SQL에서는 문자열을 사용할 때 작은따옴표만 사용해야 함.

is_big <- TRUE  # 논릿값(boolean: TRUE, FALSE) 한개를 저장하는 scalar.
is_big <- (5 > 3)
is_big <- (3 > 5)
# 비교 연산(>, >=, <, <=, ==, !=)
is_same <- (3 == 5)

# vector의 예
# c(): combine
numbers <- c(1, 2, 10, 20, 50, 100)  
# 숫자(numeric) 6개를 저장하는 vector
numbers

stu_names <- c('Abc', '홍길동')
# 문자열(characters) 2개를 저장하는 vector
stu_names

bools <- c(TRUE, TRUE, FALSE, TRUE, FALSE)
# 논리(logical) 타입 값 5개를 저장하는 vector

# vector의 원소(element)를 선택하는 방법 - 인덱스 사용.
# 1) 특정 위치(인덱스)에 있는 원소 1개를 선택:
numbers[1]
numbers[2]
# 2) 특정 (인덱스) 범위(range)에 있는 원소 여러개를 선택:
numbers[2:4]  # 2 <= index <= 4 범위의 원소 선택
# 3) 특정 위치(인덱스) 여러곳의 원소들을 선택:
numbers[c(1, 4, 6)]

