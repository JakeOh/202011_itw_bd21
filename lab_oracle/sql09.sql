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
