-- 11/25 과제

-- 1) 사원 테이블(emp)에서 직책(job)이 'SALESMAN'인 사원들의
-- 사번(empno), 이름(ename), 급여(sal), 수당(comm), 직책(job)을 검색
select empno, ename, sal, comm, job
from emp
where job = 'SALESMAN';
-- where 컬럼이름 = 값
-- SQL에서는 문자열은 작은따옴표('')로 묶어야 함.
-- 테이블에 저장된 문자열 값은 대/소문자를 구분함!

-- 2) 사원 테이블에서 부서번호가 10번 또는 20번인 사원들의
-- 부서번호, 이름, 급여를 검색.
-- 정렬기준: (1) 부서번호, (2) 이름
-- or 사용:
select deptno, ename, sal
from emp
where deptno = 10 or deptno = 20
order by deptno, ename;

-- in 사용:
select deptno, ename, sal
from emp
where deptno in (10, 20)
order by deptno, ename;

-- 3) 사원 테이블에서 직책이 'ANALYST'이거나 또는 'MANAGER'인 사원들의
-- 사번, 이름, 급여, 직책을 검색
-- or 사용:
select empno, ename, sal, job
from emp
where job = 'ANALYST' or job = 'MANAGER';

-- in 사용:
select empno, ename, sal, job
from emp
where job in ('ANALYST', 'MANAGER');
