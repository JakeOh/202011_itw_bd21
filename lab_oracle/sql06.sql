-- scott 계정 사용

-- 서브 쿼리(Sub Query)

-- emp 테이블에서, 전체 사원의 급여 평균보다 더 많은 급여를 받는 직원들의 레코드를 검색
-- 1) 급여 평균 찾음
select avg(sal) from emp;
-- 2) 급여 평균보다 더 많은 급여의 직원을 찾음
select * from emp where sal > 2073;

select * from emp
where sal > (select avg(sal) from emp);

-- ALLEN보다 적은 급여를 받는 사원의 사번, 이름, 급여를 출력.
select sal from emp where ename = 'ALLEN';

select empno, ename, sal
from emp
where sal < (
    select sal from emp where ename = 'ALLEN'
);

-- ALLEN과 같은 직책의 사원들의 사번, 이름, 부서번호, 직책을 출력
select job from emp where ename = 'ALLEN';

select empno, ename, deptno, job
from emp
where job = (
    select job from emp where ename = 'ALLEN'
);

-- 직책이 'SALESMAN'인 사원들의 급여의 최댓값보다 더 많은 급여를 받는
-- 사원들의 사번, 이름, 급여, 직책을 출력
select empno, ename, sal, job
from emp
where sal > (
    select max(sal) from emp where job = 'SALESMAN'
);

-- 연봉 =  sal * 12 + comm으로 계산. comm이 null이면 0으로 계산.
-- WARD의 연봉보다 더 많은 연봉을 받는 사원들의 
-- 사번, 이름, 급여, 수당, 연봉을 출력.
-- 연봉의 오름차순으로 정렬.
select empno, ename, sal, comm,
       sal * 12 + nvl(comm, 0) as ANNUAL_SAL
from emp
where sal * 12 + nvl(comm, 0) > (
    select sal * 12 + nvl(comm, 0) from emp
    where ename = 'WARD'
)
order by ANNUAL_SAL;

-- 각 부서에서 급여가 가장 적은 직원들의 레코드을 검색.
-- 1) 각 부서의 급여 최솟값
select min(sal) from emp group by deptno;
-- 2) 급여가 950, 800, 1300인 직원들의 레코드
select * from emp where sal in (950, 800, 1300);
-- 1), 2)를 sub query를 사용해서 합침.
select * from emp
where sal in (
    select min(sal) from emp group by deptno
);

-- 3) 10번 부서에서 급여가 1300인 직원,
-- 20번 부서에서 급여가 800인 직원,
-- 30번 부서에서 급여가 950인 직원의 정보
select * from emp
where (deptno = 10 and sal = 1300)
   or (deptno = 20 and sal = 800)
   or (deptno = 30 and sal = 950);
   
select deptno, min(sal) from emp group by deptno;

select * from emp
where (deptno, sal) in (
    select deptno, min(sal) from emp group by deptno
);

-- 각 부서에서 급여가 가장 많은 직원들의 레코드를 검색.
select * from emp
where (deptno, sal) in (
    select deptno, max(sal) from emp group by deptno
);

-- 20번 부서에서 근무하는 사원들 중에서
-- 30번 부서에 없는 직책을 가진 사원들의 레코드를 출력.
-- 1) 30번 부서의 직책들
select job from emp where deptno = 30;
select distinct job from emp where deptno = 30;
-- 2) 20번 부서에서 SALESMAN, CLERK, MANAGER이 아닌 사원들
select * from emp
where deptno = 20
  and job not in ('SALESMAN', 'CLERK', 'MANAGER');
-- 1), 2)를 sub query로 합침
select * from emp
where deptno = 20
  and job not in (
    select distinct job from emp where deptno = 30
  );