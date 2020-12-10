# scalar(스칼라): 한개의 값이 저장된 객체(object, 변수 variable).
# vector(벡터): 한가지 타입(유형)의 여러개의 값이 1차원으로 저장된 객체.

# scalar의 예
x <- 100  # x: 숫자 한개를 저장하고 있는 scalar
name <- '오쌤'  # name: 문자열 한개를 저장하고 있는 scalar
name
# R에서는 문자열을 작은따옴표('') 또는 큰따옴표("")로 묶을 수 있음.
# (비교) SQL에서는 문자열을 사용할 때 작은따옴표만 사용해야 함.

is_big <- TRUE  # 논릿값(logical: TRUE, FALSE) 한개를 저장하는 scalar.
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

# R에서 변수에 값을 저장(할당)할 때: 변수 <- 값
# 변수는 Global Environment에 생기게 됨.
# 함수를 호출할 때 함수에게 argument를 전달할 때: arg = 값

# 함수(function): 기능. 연산.
# argument: 함수를 호출할 때 함수에게 전달하는 값.
# 필수(mandatory) argument: 함수를 호출할 때 반드시 전달해야 하는 값.
# 선택(optional) argument: 기본값(default)이 설정되어 있어서, 
# 함수를 호출할 때 생략해도 되는 값.
# parameter: argument를 저장하기 위한 함수 내부의 변수.
# return value(반환 값): 함수가 기능을 수행한 후 반환하는 값. 함수 수행 결과.

# seq(): Sequence.
# 함수를 호출할 때, 파라미터 이름을 생략하고 argument를 전달함.
evens <- seq(2, 10, 2)  # 2부터 10까지 2씩 증가하는 숫자들로 이루어진 vector.

# 함수를 호출할 때, 어떤 파라미터에 무슨 값을 전달할 지를 지정함.
odds <- seq(from = 1, to = 10, by = 2) # 1부터 10까지 2씩 증가하는 숫자들로 이루어진 vector.

# optional argument들을 전달하지 않으면(생략하면), 기본값이 사용됨.
numbers <- seq(from = 1, to = 10)  # by의 기본값 1이 사용됨.
numbers

numbers <- seq(to = 5)  # from=1, by=1 기본값이 사용됨.
numbers

countdown <- seq(from = 10, to = 1, by = -1)  # 10부터 1까지 1씩 감소하는 수열 생성.
countdown

# vector와 scalar 연산
numbers <- c(1, 10, 100)
numbers
numbers + 1

# vector와 vector의 연산
numbers1 <- c(1, 10, 100)
numbers2 <- c(2, 4, 6)
numbers1 + numbers2
