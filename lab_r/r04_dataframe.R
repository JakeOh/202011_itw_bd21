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

# 파일 경로 표기 방법:
# 절대 경로(absolute path):
#   root('C:\', 'D:\', '/')부터 파일이 있는 위치까지 순서대로 모두 표기하는 방법.
#   'C:\lab\lab_r\data\csv_exam.csv'
#   '/user/document/data/abc.csv'
# 상대 경로(relative path):
#   현재 작업 폴더(current working directory)를 기준으로 파일이 있는 위치까지 
# 찾아가는 방법.
#   'data\csv_exam.csv'
#   'data/abc.csv'
# 폴더(디렉토리) 구분자: 윈도우즈에서 '\'를 사용, 그 이외의 OS에서는 '/'를 사용함!
# 따옴표('', "") 안에서 '\'는 특별한 의미를 갖기 때문에, 
# 폴더 구분자로 '\'로 사용하는 것은 권장하지 않음.
# 폴더 구분자는 '/'를 사용하는 것을 권장.

# MS 엑셀 파일(xls, xlsx)을 읽고 데이터 프레임 생성.
# tidyverse 패키지를 설치하면 readxl 패키지가 함께 설치됨.
# readxl 패키지의 read_excel(), read_xls(), read_xlsx() 함수를 사용.
# 패키지이름::함수이름(argument, ...)
excel_exam <- readxl::read_xlsx(path = 'data/excel_exam.xlsx')
excel_exam

search()  # 메모리에 로딩된 패키지 이름들(검색 경로, search path)
# 메모리에 로딩된 패키지에 포함된 함수들은 패키지 이름을 생략하고
# 함수를 호출할 수 있음.
# utils::read.csv() 호출하는 대신에, read.csv() 호출할 수 있음.
# 자주 사용하는 패키지를 검색 경로에 등록(메모리에 로딩)하면,
# 패키지 이름을 생략하고 간단히 호출할 수 있게 됨.
library(readxl)
search()

# 엑셀 파일에서 첫번째 행이 컬럼 이름이 아니라 데이터인 경우:
exam_novar <- read_xlsx(path = 'data/excel_exam_novar.xlsx',
                        col_names = FALSE)
exam_novar

exam_novar <- read_xlsx(path = 'data/excel_exam_novar.xlsx',
                        col_names = c('id', 'cls', 'm', 'e', 's'))
exam_novar

# 엑셀 파일의 특정 sheet에 데이터가 있는 경우:
exam_sheet <- read_xlsx(path = 'data/excel_exam_sheet.xlsx',
                        sheet = 'Sheet3')
exam_sheet

# 함수를 호출할 때, 파라미터의 이름을 명시하는 경우(param = value)에는
# 파라미터의 순서가 중요하지 않음.
seq(from = 1, to = 10, by = 2)
seq(by = 2, from = 1, to = 10)
# 파라미터의 이름을 명시하지 않는 경우에는 순서를 지켜야 함.
