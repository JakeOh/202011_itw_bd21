# Data Frame(데이터 프레임): 표 형태(행/열)로 데이터를 저장하는 타입.
# 데이터 프레임의 컬럼은 한가지 타입(유형)의 데이터들을 저장.
# observation(관찰값, 관측치): 데이터 프레임의 row(행).
# variable(변수): 데이터 프레임의 column(열).

stu_no <- 1:4  # 1부터 4까지 연속된 정수.
stu_name <- c('aaa', 'bbb', 'ccc', 'ddd')
score <- c(100, 50, 90, 80)

# 번호, 이름, 점수를 컬럼으로 갖는 데이터 프레임.
students <- data.frame(stu_no, stu_name, score)
students

# students 데이터 프레임에서 번호(stu_no) 컬럼 내용 출력.
# select stu_no from students;
# Ctrl+Space: 코드 힌트
students$stu_no  # data_frame$col_name

# students 데이터 프레임에서 학생들의 점수를 출력.
students$score

# 수학, 과학, 영어 점수를 저장하는 데이터 프레임.
scores <- data.frame(math = c(10, 20, 15, 30),
                     science = c(90, 70, 80, 50),
                     english = c(55, 60, 70, 87))
scores

# 권장하지 않는 방법
df <- data.frame(A <- 1:3, B <- c('a', 'b', 'c'))
df

# 함수를 이용해서 패키지를 설치:
install.packages('tidyverse')

# 설치된 패키지 확인
installed.packages()

# RStudio -> Tools 메뉴 -> Install Packages...

library(tidyverse)
