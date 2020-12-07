-- scott 계정, create 연습

/*
테이블 이름: customers(고객)
컬럼:
  1) cust_id: 고객 아이디. 8 ~ 20 byte의 문자열. primary key.
  2) cust_pw: 고객 비밀번호. 8 ~ 20 byte의 문자열. not null.
  3) cust_email: 고객 이메일. 100 byte 문자열.
  4) cust_gender: 고객 성별. 1자리 정수. 기본값 0. (0, 1, 2) 중 1개 값만 가능.
  5) cust_age: 고객 나이. 3자리 정수. 기본값 0. 0 이상 200 이하의 정수만 가능.
*/
create table customers (
    cust_id     varchar2(20)
                constraint pk_customers primary key
                constraint ck_cust_id check (lengthb(cust_id) >= 8),
    cust_pw     varchar2(20) not null
                constraint ck_cust_pw check (lengthb(cust_pw) >= 8),
    cust_email  varchar2(100),
    cust_gender number(1) default 0
                constraint ck_cust_gender check (cust_gender in (0, 1, 2)),
    cust_age    number(3) default 0
                constraint ck_cust_age check (cust_age between 0 and 200)
);

create table customers2 (
    cust_id     varchar2(20),
    cust_pw     varchar2(20) not null,
    cust_email  varchar2(100),
    cust_gender number(1) default 0,
    cust_age    number(3) default 0,
    
    constraint pk_customers2 primary key (cust_id),
    constraint ck_cust_id2 check (lengthb(cust_id) >= 8),
    constraint ck_cust_pw2 check (lengthb(cust_pw) >= 8),
    constraint ck_cust_gender2 check (cust_gender in (0, 1, 2)),
    constraint ck_cust_age2 check (cust_age between 0 and 200)
);

/*
테이블 이름: orders(주문)
  1) order_id: 주문번호. 4자리 정수. primary key.
  2) order_date: 주문 날짜. 기본값은 현재 시간.
  3) order_method: 주문 방법. 8 byte 문자열. ('online', 'offline') 중 1개 값만 가능.
  4) cust_id: 주문 고객 아이디. 20 byte 문자열. not null. customers(cust_id)를 참조.
*/
create table orders (
    order_id     number(4)
                 constraint pk_order_id primary key,
    order_date   date default sysdate,
    order_method varchar2(8)
                 constraint ck_order_method check (order_method in ('online', 'offline')),
    cust_id      varchar2(20) not null
                 constraint fk_cust_id references customers(cust_id)
);

create table orders2 (
    order_id     number(4),
    order_date   date default sysdate,
    order_method varchar2(8),
    cust_id      varchar2(20) not null,
                 
    constraint pk_order_id2 primary key (order_id),
    constraint ck_order_method2 check (order_method in ('online', 'offline')),
    constraint fk_cust_id2 foreign key (cust_id) references customers(cust_id)
);

create table ex08 (
    col_a number(2)
          constraint ck_1 check (col_a >= 0)
          constraint ck_2 check (col_a < 50),
    col_b varchar2(10)
);

create table ex09 (
    col_a number(2)
          constraint ck_ex09_1 check (col_a >= 0 and col_a < 50),
    col_b varchar2(10)
);


-- insert ~ select 구문
-- emp 테이블에서 이름, 직책, 급여, 수당을 검색해서 bonus 테이블에 삽입.
insert into bonus
select ename, job, sal, comm from emp;

select * from bonus;

-- 사번, 이름, 부서이름, 직책, 급여를 저장할 수 있는 테이블 생성.
create table emp_dept (
    empno number(4, 0),  -- 4자리 정수(소수점 허용 안함)
    ename varchar2(10 byte),
    dname varchar2(14 byte),
    job   varchar2(9 byte),
    sal   number(7, 2)  -- 7자리 숫자(소수점 이하 2자리까지)
);
-- emp와 dept 테이블을 사용해서 테이블의 값들을 insert. 
insert into emp_dept 
select e.empno, e.ename, d.dname, e.job, e.sal
from emp e join dept d on e.deptno = d.deptno;

select * from emp_dept;

-- create table ~ as select 구문
-- 사번, 이름, 급여를 저장하는 테이블 생성, emp 테이블의 레코드들을 복사
create table ex_emp3 as
select empno, ename, sal from emp;

describe ex_emp3;

select * from ex_emp3;

commit;
