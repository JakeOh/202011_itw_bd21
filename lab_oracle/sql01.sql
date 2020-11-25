select * from dept;
-- Ctrl+Enter: 현재 커서가 있는 위치의 SQL 문장 한개를 실행.
-- 주석(comment): 소스 코드에 대한 설명. 실행되지 않는 문장.

-- SQL 키워드(select, insert, form, desc, ...) 대/소문자를 구별하지 않음.
-- 테이블 이름, 컬럼 이름들도 대/소문자를 구별하지 않음.
-- 테이블에 저장된 값들은 대/소문자를 구별함!

-- DQL(Data Query Language): 데이터 질의 언어. select
-- 테이블에서 데이터를 검색

-- 1) 테이블에서 특정 컬럼을 검색
-- select 컬럼이름1, 컬럼이름2, ... from 테이블이름;
-- 부서 테이블(dept)에서 부서 이름(dname)을 검색
select dname from dept;

-- 부서 테이블(dept)에서 부서 번호(deptno)와 부서 이름(dname)을 검색
select deptno, dname from dept;
select dname, deptno from dept;

-- 2) 부서 테이블(dept)의 모든 컬럼의 내용을 검색
select * from dept;

-- 테이블의 구조 확인(describe)
desc dept;

-- alias(별명): 검색 결과에서 컬럼 이름의 별명을 설정해서 출력.
select dname as 부서이름 from dept;
select deptno as 부서번호, dname as 부서이름
from dept;

-- 사원 테이블(emp)의 구조 확인
desc emp;

-- 사원 테이블에서 사번(empno), 이름(ename)을 검색. alias 사용.
select empno as 사번, ename as 이름
from emp;

-- 사원 테이블에서 이름(ename), 급여(sal), 특별수당(comm)을 검색. alias 사용.
select ename as 이름, sal as 급여, comm as 수당
from emp;

-- 사원 테이블에서 이름, 특별수당, 부서번호를 검색.
select ename, comm, deptno
from emp;

-- 사원 테이블에서 이름, 특별수당, 직책(job)을 검색.
select ename, comm, job
from emp;

-- 사원 테이블에서 부서번호를 검색
select deptno from emp;
-- 중복되지 않는(distinct) 데이터만 출력
select distinct deptno from emp;

-- 사원 테이블에서 직책(job)을 검색
select job from emp;
select distinct job from emp;

-- 사원 테이블에서 중복되지 않는 부서번호, 직책을 검색
select distinct deptno, job
from emp;
