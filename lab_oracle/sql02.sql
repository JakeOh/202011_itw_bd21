-- 워크시트: 코드를 작성하는 편집기
-- Alt+F10: 새 워크시트 만들기

-- 조건을 만족하는 레코드를 검색하는 방법:

-- 사원 테이블에서 10번 부서에 근무하는 직원들의 레코드를 검색
select * 
from emp
where deptno = 10;

-- 사원 테이블에서 20번 부서에서 근무하는 직원들의
-- 사번, 이름, 직책, 급여를 검색
select empno, ename, job, sal, deptno
from emp
where deptno = 20;

-- 사원 테이블에서 부서번호가 20번이 아닌 직원들의 모든 컬럼을 검색
select * from emp
where deptno != 20;

-- 사원 테이블에서 급여가 3000 이상인 직원들의 모든 컬럼을 검색
select * from emp where sal >= 3000;

-- 사원 테이블에서 급여가 2000 이하인 직원들의 이름, 직책, 급여를 검색
select ename, job, sal
from emp
where sal <= 2000;

-- 사원 테이블에서 급여가 1500 이상 3000 이하인 직원들의 사번, 이름, 급여를 검색
select empno, ename, sal
from emp
where sal >= 1500 and sal <= 3000;

select empno, ename, sal
from emp
where sal between 1500 and 3000;

-- 비교
select empno, ename, sal
from emp
where sal > 1500 and sal < 3000;

-- 정렬(order by)
-- 오름차순(ascending) 정렬 - 기본값
-- 내림차순(descending) 정렬

-- 사번, 이름 검색. 사번 오름차순 정렬.
select empno, ename
from emp
order by empno;

-- 사번, 이름 검색. 사번 내림차순 정렬.
select empno, ename
from emp
order by empno desc;

-- SQL 문장에서 order by는 항상 문장의 마지막에서 사용.

-- 사원 테이블에서 사번, 이름, 급여를 검색. 사번의 내림차순으로 정렬.
select empno, ename, sal
from emp 
order by empno desc;

-- 사원 테이블에서 사번, 이름, 급여를 검색. 급여의 내림차순으로 정렬.
select empno, ename, sal
from emp 
order by sal desc;

-- 사원 테이블에서 부서번호가 10번 또는 20번인 사원들의 부서번호와 이름을 검색.
-- 부서번호의 오름차순으로 정렬.
select deptno, ename
from emp
where deptno = 10 or deptno = 20
order by deptno;

-- 사원 테이블에서 부서번호가 10번 또는 20번인 사원들의 부서번호와 이름을 검색.
-- 1) 부서번호의 오름차순으로 정렬, 2) 이름의 오름차순으로 정렬.
select deptno, ename
from emp
where deptno = 10 or deptno = 20
order by deptno, ename;