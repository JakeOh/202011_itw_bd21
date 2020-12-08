-- scott 계정
-- DDL(Data Definition Language): create, truncate, drop, alter

select * from ex01;

truncate table ex01;
-- 테이블의 모든 row(행)들을 잘라냄.
select * from ex01;

drop table ex01;  -- 테이블을 삭제

-- alter table 테이블이름 변경할 내용;
-- 이름 변경(rename): (1) 테이블 이름 변경, (2) 컬럼 이름 변경, (3) 제약조건 이름 변경
-- (1) alter table 원래 테이블 이름 rename to 새로운 테이블 이름;
alter table ex02 rename to ex_1208;

-- (2) alter table 테이블 이름 rename column 원래 컬럼 이름 to 바꿀 컬럼 이름;
describe ex_1208;
-- ex_1208 테이블에서 ex_text 컬럼 이름을 title로 변경
alter table ex_1208 rename column ex_text to title;
describe ex_1208;

-- (3) alter table 테이블 이름 rename constraint 원래 제약조건 이름 to 바꿀 제약조건 이름;
alter table ex03 rename constraint SYS_C0011365 to nn_ex03;

-- 추가(add): (1) 컬럼 추가, (2) 제약조건 추가
-- (1) alter table 테이블 이름 add 컬럼이름 데이터타입;
-- (2) alter table 테이블 이름 add constraint 제약조건이름 제약조건내용;

