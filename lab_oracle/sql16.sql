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

describe ex03;

-- ex03 테이블에 content 컬럼(100 byte까지 저장가능한 문자열 타입) 추가.
alter table ex03 add content varchar2(100 byte);
describe ex03;

-- ex03 테이블의 content 컬럼에 unique 제약조건을 추가
alter table ex03 add constraint uq_ex03 unique (content);

-- 삭제(drop): (1) 컬럼 삭제, (2) 제약조건 삭제
-- (1) alter table 테이블 이름 drop column 컬럼 이름;
-- (2) alter table 테이블 이름 drop constraint 제약조건 이름;

-- ex03 테이블에서 제약조건 uq_ex03을 삭제
alter table ex03 drop constraint uq_ex03;

-- ex03 테이블에서 컬럼 content를 삭제
alter table ex03 drop column content;
describe ex03;

-- 수정(modify): 컬럼의 내용(데이터 타입, 제약 조건 not null)
-- alter table 테이블 이름 modify 컬럼이름 변경내용;
-- ex03 테이블에서 ex_text 컬럼의 데이터 타입을 200 byte까지 저장할 수 있는 문자열로 수정.
alter table ex03 modify ex_text varchar2(200 byte);
describe ex03;

describe ex04;
-- ex04 테이블에서 ex_name 컬럼에 not null 제약조건 추가 -> modify
alter table ex04 modify ex_name not null;
describe ex04;

-- 제약조건의 이름을 유지한채 내용만 변경(modify)하는 기능은 없음.
-- 제약조건 삭제(drop constraint) -> 제약조건 추가(add constraint)


-- 1. emp 테이블과 같은 구조(컬럼이름, 데이터 타입)를 갖는 테이블을 test_emp라는 이름으로 생성.
-- 2. test_emp 테이블에 etc 컬럼(20 byte 문자열)을 추가.
-- 3. test_emp 테이블의 ect 컬럼 이름을 remark로 변경.
-- 4. test_emp 테이블의 remark 컬럼의 데이터 타입을 100 byte 문자열로 변경.
-- 5. emp 테이블의 모든 행(row)들을 test_emp 테이블에 복사.
-- 6. test_emp 테이블의 empno 컬럼에 고유키(primary key) 제약조건을 추가.
-- 7. test_emp 테이블의 deptno 컬럼이 dept 테이블의 deptno를 참조하도록 외래키 제약조건을 추가.
-- 8. test_emp 테이블의 ename 컬럼에 not null 제약조건을 추가.
-- 9. 8번에서 만든 제약조건을 삭제.
-- 10. test_emp 테이블의 comm 컬럼을 삭제.
-- 11. test_emp 테이블 삭제.
