# data.frame() 함수를 사용해서 데이터 프레임 생성.
# 데이터 프레임에 파생 변수를 추가.
fruit_df <- data.frame(fruit = c('귤', '딸기', '바나나'),
                       price = c(1000, 2000, 500),
                       quantity = c(5, 3, 10))
fruit_df

# fruit_df 데이터 프레임에 total_price 컬럼(파생 변수)를 추가.
fruit_df$total_price <- fruit_df$price * fruit_df$quantity
fruit_df

# C:\lab\lab_r\data\csv_exam.csv 파일을 읽어서 데이터 프레임을 생성.
exam_df <- read.csv(file = 'data/csv_exam.csv')
exam_df

# total(세 과목 점수의 합계), average(세 과목 점수의 평균) 파생변수 생성.
exam_df$total <- exam_df$math + exam_df$english + exam_df$science
exam_df$average <- exam_df$total / 3
exam_df

# 데이터 프레임을 CSV 파일에 쓰기.
fruit_df
write.csv(x = fruit_df,            # x = 저장할 데이터 프레임
          file = 'fruit.csv',      # file = 저장할 경로 및 파일 이름
          fileEncoding = 'UTF-8',  # fileEncoding = 인코딩 타입
          row.names = FALSE)       # row.names = 행 이름을 파일에 write할 지, 말 지.

# 파일에 저장된 내용이 제대로 읽히는지 확인.
fruit2 <- read.csv(file = 'fruit.csv', fileEncoding = 'UTF-8')
fruit2
