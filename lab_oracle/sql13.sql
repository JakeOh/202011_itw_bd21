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

-- 테이블을 생성할 때 제약조건의 이름과 종류를 설정하는 방법:
create table ex02 (
    ex_id number(2) constraint pk_ex02 primary key,
    ex_text varchar2(100 byte) constraint nn_ex02 not null
);
