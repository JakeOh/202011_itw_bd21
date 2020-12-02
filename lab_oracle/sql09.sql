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
select emp.empno, emp.ename, emp.deptno, dept.dname
from emp, dept
where emp.deptno = dept.deptno;
