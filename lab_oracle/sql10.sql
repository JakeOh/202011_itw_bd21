-- scott 계정
-- join 연습(모든 문장은 Oracle 문법, ANSI 표준 문법 두가지로 작성)

-- 부서번호, 부서이름, 부서별 사원수, 부서별 급여 최솟값, 최댓값, 평균을 출력.
-- 소수점이 있는 경우에는 소수점 한자리까지만 출력.
-- 부서번호 오름차순으로 정렬 출력.
select d.deptno, d.dname, count(e.empno) as 사원수,
       min(e.sal) as 급여최솟값, max(e.sal) as 급여최댓값,
       round(avg(e.sal), 1) as 급여평균
from emp e, dept d
where e.deptno = d.deptno
group by d.deptno, d.dname
order by d.deptno;

select d.deptno, d.dname, count(e.empno) as 사원수,
       min(e.sal) as 급여최솟값, max(e.sal) as 급여최댓값,
       round(avg(e.sal), 1) as 급여평균
from emp e join dept d on e.deptno = d.deptno
group by d.deptno, d.dname
order by d.deptno;

-- 부서번호, 부서이름, 사번, 이름, 직책, 급여를 출력.
-- 부서 테이블의 있는 모든 부서 번호/이름은 출력되어야 함.
-- 부서번호 오름차순으로 정렬 출력.
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from dept d, emp e
where d.deptno = e.deptno(+)  -- left (outer) join
order by d.deptno;

select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from emp e, dept d
where e.deptno(+) = d.deptno  -- right (outer) join
order by d.deptno;

select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from dept d left join emp e on d.deptno = e.deptno
order by d.deptno;
