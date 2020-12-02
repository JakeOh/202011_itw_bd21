-- scott 계정

/* join: 두개 이상의 테이블에서 정보들을 검색하는 방법.
1) Oracle 문법
select 컬럼, ...
from 테이블1, 테이블2, ...
where join조건;

2) ANSI 표준 문법
select 컬럼, ...
from 테이블1 join종류 테이블2 on join조건
*/

-- emp, dept 테이블에서 사번, 이름, 부서번호, 부서이름을 검색
-- 1) Oracle 문법
select e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno;

-- 2) ANSI 표준 문법
select e.empno, e.ename, e.deptno, d.dname
from emp e inner join dept d
    on e.deptno = d.deptno;
-- inner join에서 inner는 생략 가능.

-- left (outer) join
-- emp, dept 테이블에서 사번, 이름, 부서번호, 부서이름 검색
-- emp 테이블에 있는 모든 부서 번호가 검색 결과로 나오도록 검색
-- 1) Oracle 방식
select e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno(+);

-- 2) ANIS 표준 문법
select e.empno, e.ename, e.deptno, d.dname
from emp e left outer join dept d
    on e.deptno = d.deptno;
-- left outer join에서 outer는 생략 가능.

-- right (outer) join
-- emp, dept 테이블에서 사번, 이름, 부서번호, 부서이름을 검색
-- deptno 테이블의 부서번호와 부서이름은 모두 출력
-- 1) Oracle 문법
select e.empno, e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno;

-- 2) ANSI 표준 문법
select e.empno, e.ename, d.deptno, d.dname
from emp e right outer join dept d
    on e.deptno = d.deptno;

-- right (outer) join은 테이블의 순서를 바꿔서 left (outer) join으로 할 수 있음.
select e.empno, e.ename, d.deptno, d.dname
from dept d, emp e
where d.deptno = e.deptno(+);

select e.empno, e.ename, d.deptno, d.dname
from dept d left join emp e
    on d.deptno = e.deptno;

-- full (outer) join
-- Oracle 문법은 제공되지 않고, ANSI 표준 문법만 제공됨.
select e.empno, e.ename, d.deptno, d.dname
from emp e full outer join dept d
    on e.deptno = d.deptno;
    
-- emp, salgrade 테이블에서 사번, 이름, 급여, 급여등급을 검색
-- 사번 순으로 출력
-- 1) Oracle 문법
select e.empno, e.ename, e.sal, s.grade 
from emp e, salgrade s
-- where e.sal >= s.losal and e.sal <= s.hisal
where e.sal between s.losal and s.hisal
order by e.empno;
-- 2) ANSI 표준 문법
select e.empno, e.ename, e.sal, s.grade
from emp e join salgrade s
    on e.sal between s.losal and s.hisal
order by e.empno;

-- emp, dept 테이블에서 사번, 이름, 부서이름, 급여를 출력
-- 급여가 2000 이상인 사원들만 선택
-- 사번 오름차순으로 정렬
-- 1) Oracle
select e.empno, e.ename, d.dname, e.sal
from emp e, dept d
where e.deptno = d.deptno
  and e.sal >= 2000
order by e.empno;
-- 2) ANSI
select e.empno, e.ename, d.dname, e.sal
from emp e inner join dept d
    on e.deptno = d.deptno
where e.sal >= 2000
order by e.empno;

-- 사번, 이름, 매니저사번, 매니저이름 검색
-- inner join
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno
order by e1.empno;

-- left join
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno(+)
order by e1.empno;

-- right join
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr(+) = e2.empno
order by e1.empno;

-- full join
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1 full join emp e2
    on e1.mgr = e2.empno
order by e1.empno;

-- self join: 한개의 테이블에서 join문을 사용하는 것.

-- 사번, 이름, 부서이름, 급여, 급여등급을 검색
-- 사번의 오름차순으로 정렬해서 출력.
-- 1) Oracle
-- 2) ANSI

