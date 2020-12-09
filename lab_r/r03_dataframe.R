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



