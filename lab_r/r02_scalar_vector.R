# scalar(스칼라): 한개의 값이 저장된 객체(object, 변수 variable).
# vector(벡터): 여러개의 값이 저장된 객체.

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

