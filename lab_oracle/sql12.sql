-- scott 계정
-- DDL(Data Definition Language): CREATE

drop table students;

/*
테이블 이름: students
컬럼 이름:
    1) 학생 아이디: sid / 숫자 2자리
    2) 학생 이름: sname / 문자열 10 bytes
    3) 학생 생일: birthday / 날짜
*/
create table students (
    sid number(2),
    sname varchar2(10 byte),
    birthday date
);

-- 테이블의 구조 확인
describe students;

-- DML(Data Manipulation Language): INSERT
insert into students (sid, sname, birthday)
values (1, '홍길동', sysdate);

select * from students;

-- insert into table (col, ...) 문장에서 지정한 컬럼 순서대로
-- values(값, ...) 의 값들을 설정해야 함.
insert into students (sname, birthday, sid)
values ('오쌤', to_date('2000/01/01', 'YYYY/MM/DD'), 2);

select * from students;

-- students 테이블에 sid와 sname만 저장
insert into students (sid, sname)
values (3, '권용호');

-- students 테이블의 모든 컬럼에 값을 저장
-- 테이블 이름 다음에 컬럼 이름들은 생략할 수 있고,
-- values ()에서 값들은 누락없이 테이블의 순서대로 설정하면 됨.
insert into students 
values (4, '허균', sysdate);

-- insert 구문에서 발생할 수 있는 오류들
insert into students values (5, '오쌤');

insert into students (sname, sid) values (5, '오쌤');

insert into students values ('오쌤', 1, '2002-01-01');

insert into students (sid) values (1004);

insert into students (sname) values ('아이티윌교육센터');

-- insert into ~ values ... 구문은 1개 행(row)만 저장 가능.
-- insert 구문에서 여러개의 행(row)를 저장: insert ~ select ... 구문
create table students2 (
    sid number(2),
    sname varchar2(10 byte),
    birthday date
);

select * from students2;

insert into students
select * from students;

