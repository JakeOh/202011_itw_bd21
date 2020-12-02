-- scott 계정 사용
-- sub query 연습

-- emp 테이블에서 급여의 최댓값을 출력
select max(sal) from emp;

-- 급여 최댓값을 받는 사원의 이름과 급여를 출력
select ename, sal from emp
where sal = (select max(sal) from emp);

-- 'JONES'의 급여보다 더 많은 급여를 받는 사원들의 이름과 급여를 출력
select ename, sal from emp
where sal > (
    select sal from emp where ename = 'JONES'
);

-- 'SCOTT'과 같은 급여를 받는 사원들의 이름과 급여를 출력
select ename, sal from emp
where sal = (
    select sal from emp where ename = 'SCOTT'
);

-- 위의 결과에서 'SCOTT'은 제외하고 출력
select ename, sal from emp
where sal = (select sal from emp where ename = 'SCOTT')
  and ename != 'SCOTT';

-- SALESMAN 직책에서의 최대 급여보다 더 많은 급여를 받는
-- 사원들의 이름, 직책, 급여를 출력
select ename, job, sal
from emp
where sal > (
    select max(sal) from emp where job = 'SALESMAN'
);

-- 'DALLAS'에서 근무하는 사원들의 이름과 급여를 출력
select ename, sal
from emp
where deptno = (
    select deptno from dept where loc = 'DALLAS'
);

-- 'ALLEN'보다 늦게 입사한 사원들의 이름과 입사날짜를 
-- 최근에 입사한 사원부터 출력.
select hiredate from emp where ename = 'ALLEN';
select ename, hiredate
from emp
where hiredate > (
    select hiredate from emp where ename = 'ALLEN'
    )
order by hiredate desc;

-- 매니저가 KING인 사원들의 이름을 출력
select ename from emp 
where mgr = (
    select empno from emp where ename = 'KING'
);

-- 관리자인 사원들의 이름을 출력
select distinct mgr from emp;  -- 관리자의 사번
select empno, ename from emp
where empno in (
    select distinct mgr from emp
);

-- 관리자가 아닌 사원들의 이름 출력
-- col in (a, b): col = a or col = b
-- col not in (a, b): col != a and col != b
-- col in (a, null): col = a or col = null
-- col not in (a, null): col != a and col != null
select empno, ename from emp
where empno not in (
    select distinct mgr from emp
    where mgr is not null
);

select empno, ename from emp
where empno not in (
    select distinct nvl(mgr, -1) from emp
);

-- 직책이 SALESMAN인 사원들과 같은 월급을 받는 사원들의 이름, 직책, 급여를 출력.
select distinct sal from emp where job = 'SALESMAN';
select ename, job, sal
from emp
where sal in (
    select distinct sal from emp where job = 'SALESMAN'
);
