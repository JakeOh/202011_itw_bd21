-- scott 계정
-- 테이블 생성과 제약 조건(constraints)

select * from students;
-- students 테이블에서는 sid가 중복된 값이 저장될 수 있음.

describe dept;

insert into dept (deptno, dname) 
values (10, '인사');  -- 중복된 값을 insert할 수 없음.

insert into dept (dname)
values ('총무');  -- NULL이 부서번호가 될 수 없음.

-- 제약 조건 종류(type)
-- PRIMARY KEY(고유키): 테이블에서 고유하게 부여되는 값. 중복되지 않고, NULL 아님.
-- NOT NULL: 값이 비어있으면 안됨.
-- UNIQUE: 중복될 수 없음.
-- FOREIGN KEY(외래키): 다른 테이블의 고유키(PK)를 참조.
-- CHECK: 조건을 검사

-- 테이블을 생성할 때 제약조건의 유형(type)를 설정하는 방법:
create table ex01 (
    ex_id number(2) primary key,
    ex_text varchar2(100 byte) not null
);

insert into ex01 values (1, '가나다라');  -- insert 성공

insert into ex01 values (1, 'abcde');  -- PK 제약조건 위배

insert into ex01 (ex_text) values ('ABC123');  -- PK 제약조건 위배

insert into ex01 (ex_id) values (2);  -- not null 제약조건 위배

-- 테이블을 생성할 때 
-- 인라인 제약조건의 이름과 종류를 설정하는 방법:
create table ex02 (
    ex_id number(2) constraint pk_ex02 primary key,
    ex_text varchar2(100 byte) constraint nn_ex02 not null
);

-- 테이블 레벨 제약조건
create table ex03 (
    ex_id number(2),
    ex_text varchar2(100 byte) not null,
    constraint pk_ex03 primary key (ex_id)
);

-- 컬럼의 기본값(default): insert할 때 값이 없는 경우 기본으로 저장되는 값.
create table ex04 (
    ex_id number(2),
    ex_name varchar2(100),
    ex_age number(3) default 0
);

insert into ex04 (ex_id, ex_name) values (1, 'abc');

insert into ex04 (ex_name) values ('Aaa');

select * from ex04;

-- 테이블 이름: ex05
-- 컬럼:
--   (1) col_1: 숫자 2자리, 고유키 제약 조건.
--   (2) col_2: 문자열 10 byte, 중복 불가 제약 조건.
--   (3) col_3: 날짜, 현재시간을 기본값.
create table ex05 (
    col_1 number(2),
    col_2 varchar2(10),
    col_3 date default sysdate,
    constraint pk_ex05 primary key (col_1),
    constraint unq_ex05 unique (col_2)
);

insert into ex05 (col_1, col_2) values (10, 'abc');

insert into ex05 (col_1, col_2) values (10, 'ABC');  -- PK 위배

insert into ex05 (col_2) values ('ABC');  -- PK 위배

insert into ex05 (col_1, col_2) values (20, 'abc');  -- UNIQUE 위배

select * from ex05;

-- 테이블 이름: ex06
-- 컬럼:
--   (1) age: 숫자 3자리, age >= 0 제약 조건.
--   (2) gender: 문자열 1 byte, 'M' 또는 'F'만 가능.
create table ex06 (
    age number(3) constraint ck_age check (age >= 0),
    gender varchar2(1) constraint ck_gender check (gender in ('M', 'F'))
);

insert into ex06 values (10, 'M');
insert into ex06 values (16, 'F');
insert into ex06 values (-1, 'M');  -- CHECK 위배
insert into ex06 values (10, 'f');

-- Primary key 와 Foreign key
create table ex_dept (
    deptno number(2) constraint pk_ex_dept primary key,
    dname varchar2(10)
);

create table ex_emp (
    empno number(3) constraint pk_ex_emp primary key,
    ename varchar2(10),
    deptno number(2) constraint fk_ex_emp references ex_dept(deptno)
);

select * from ex_dept;
select * from ex_emp;

insert into ex_emp values (100, '오쌤', 10);
-- ex_dept 테이블에 10 deptno가 존재하지 않기 때문에
-- ex_emp 테이블에 deptno 값으로 10을 insert할 수 없음!