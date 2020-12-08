-- scott 계정

-- DML(Data Manipulation Language): insert, update, delete
-- insert: 레코드(행) 추가.
-- update: 레코드(행)의 컬럼 값을 수정.
-- delete: 레코드(행) 삭제.

-- TCL(Transaction Control Language): commit, rollback
-- commit: 테이블의 변경 내용(insert, update, delete)을 데이터베이스에 영구히 저장.
-- rollback: 최종 commit 단계로 되돌리기.

select * from emp;

update emp 
set sal = 100;
-- emp 테이블의 sal 컬럼의 모든 값들을 100으로 수정(업데이트).

select * from emp;

rollback;

select * from emp;

-- emp 테이블에서 SMITH의 급여를 900으로 업데이트.
update emp
set sal = 900
where ename = 'SMITH';

-- 사번이 7844인 직원의 급여를 2000, 수당을 500으로 업데이트.
update emp
set sal = 2000, comm = 500
where empno = 7844;

-- emp 테이블에서 평균 급여보다 적은 급여를 받는 직원들의 급여를 10% 인상.
update emp
set sal = sal * 1.1
where sal < (select avg(sal) from emp);

-- 매니저가 KING인 직원들의 수당을 100으로 업데이트.
update emp 
set comm = 100 
where mgr = (select empno from emp where ename = 'KING');

-- RESEARCH 부서에서 근무하는 직원들의 수당을 50으로 업데이트.
update emp
set comm = 50
where deptno = (select deptno from dept where dname = 'RESEARCH');

-- SCOTT의 급여를 KING의 급여와 동일하게 업데이트.
update emp
set sal = (select sal from emp where ename = 'KING')
where ename = 'SCOTT';

-- 직책이 SALESMAN인 직원들의 급여를 ALLEN의 급여와 동일하게 업데이트.
update emp
set sal = (select sal from emp where ename = 'ALLEN')
where job = 'SALESMAN';

-- MILLER의 급여와 수당을 SMITH의 급여와 수당과 동일하게 업데이트.
update emp
set sal = (select sal from emp where ename = 'SMITH'), 
    comm = (select comm from emp where ename = 'SMITH')
where ename = 'MILLER';

update emp
set (sal, comm) = (select sal, comm from emp where ename = 'SMITH')
where ename = 'MILLER';

-- comm이 null인 직원들의 comm을 -1로 업데이트.
update emp
set comm = -1
where comm is null;  -- 2개 행 업데이트

update emp set comm = null where comm = -1;
select * from emp;

update emp
set comm = nvl(comm, -1);  -- 14개 행 업데이트.

-- 10번 부서에서 입사일이 가장 늦은 사원보다 더 늦게 입사한 사원의 
-- 부서번호를 30번으로 업데이트.
update emp
set deptno = 30
where hiredate > (
    select max(hiredate) from emp where deptno = 10
);

-- 10번 부서의 가장 늦은 입사일보다 더 늦게 입사한 사원의 부서를 OPERATIONS 부서로 업데이트.
update emp
set deptno = (select deptno from dept where dname = 'OPERATIONS')
where hiredate > (
    select max(hiredate) from emp where deptno = 10
);

-- 현재까지 변경 내용을 데이터베이스에 저장.
commit;

-- delete from 테이블이름 where 조건문;
-- 조건을 만족하는 행(row)들을 삭제.
-- where 조건문이 없는 경우는 테이블의 모든 행이 삭제.
delete from emp;

rollback;

-- SCOTT의 레코드를 삭제
delete from emp where ename = 'SCOTT';

-- 급여등급 5인 사원들의 레코드를 emp 테이블에서 삭제
delete from emp
where empno in (
    select e.empno
    from emp e join salgrade s on (e.sal between s.losal and s.hisal)
    where s.grade = 5
    );

rollback;

delete from emp
where sal >= (select losal from salgrade where grade = 5)
  and sal <= (select hisal from salgrade where grade = 5);

select * from emp;

commit;
