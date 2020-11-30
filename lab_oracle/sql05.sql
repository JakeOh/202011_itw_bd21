--  숫자 관련 함수

-- round(): 반올림
select 1234.5678, round(1234.5678),
       round(1234.5678, 1), round(1234.5678, 2),
       round(1234.5678, -1), round(1234.5678, -2)
from dual;

-- trunc(): 버림. 자름(truncate)
select 1234.5678, trunc(1234.5678),
       trunc(1234.5678, 1), trunc(1234.5678, 2),
       trunc(1234.5678, -1), trunc(1234.5678, -2)
from dual;

-- floor(), ceil()
select floor(3.14), ceil(3.14),
       floor(-3.14), ceil(-3.14),
       trunc(-3.14)
from dual;

-- null 처리 함수: 
-- nvl(컬럼, null을 대체할 값)
-- nvl2(컬럼, null이 아닐 때 대체할 값, null일 때 대체할 값)
select comm, nvl(comm, -1), nvl2(comm, 'YES', 'NO')
from emp;

select comm, nvl2(comm, comm, -1) from emp;

-- emp 테이블에서 모든 사원들의 1년 연봉을 검색
-- 연봉 = sal * 12 + comm
select sal, comm, sal * 12 + nvl(comm, 0) as annual_sal
from emp;

-- 집계 함수, 다중행 함수(multi-row function):
-- 여러개의 행(row)을 집계해서 하나의 결과값을 리턴하는 함수.
-- 예: 합계(sum), 평균(avg), 최댓값(max), 최솟값(min), 
-- 분산(variance), 표준편차(stddev), 중앙값(median)
select sum(sal), round(avg(sal), 1), max(sal), min(sal),
       round(variance(sal), 1), round(stddev(sal), 1), median(sal)
from emp;

select sal from emp order by sal;

-- count(): 레코드(행, row)의 개수
select count(*) from emp;  -- 테이블의 row 개수
select count(sal), count(comm), count(mgr) from emp;  
-- 각 컬럼의 NULL이 아닌 row의 개수

-- 다중행 함수는 여러개의 행이 결과로 출력되는 변수(또는 함수)와는 함께 
-- select할 수 없음!
select empno from emp;  -- 결과: 14개 rows
select count(empno) from emp;  -- 결과: 1개 row
-- select empno, count(empno) from emp;  -- 오류(error) 발생

-- 10번 부서 사원들의 급여 평균, 최댓값, 최솟값, 표준편차를 출력
-- 소수점은 1자리까지만 출력.
select sal from emp where deptno = 10;

select round(avg(sal), 1), max(sal), min(sal), round(stddev(sal), 1)
from emp
where deptno = 10;

-- 20번 부서 사원들의 급여의 평균, 최댓값, 최솟값, 표준편차
select sal from emp where deptno = 20;
select round(avg(sal), 1), max(sal), min(sal), round(stddev(sal), 1)
from emp
where deptno = 20;

-- group by
-- 각 부서별 급여의 평균, 최댓값, 최솟값을 검색
select deptno, avg(sal), max(sal), min(sal)
from emp
group by deptno;

-- 부서별 부서번호, 급여의 평균과 표준편차를 검색.
-- 소수점 이하 한자리까지 반올림으로 표현.
-- 부서번호의 오름차순으로 정렬해서 출력.
select deptno, round(avg(sal), 1), round(stddev(sal), 1)
from emp
group by deptno 
order by deptno;

-- 직책(job)별 직책, 급여의 평균, 최댓값, 최솟값, 사원수를 검색.
-- 소수점 이하 한자리까지 반올림으로 표현.
-- 직책의 오름차순으로 정렬해서 출력.
select job, round(avg(sal), 1), max(sal), min(sal), count(*)
from emp
group by job
order by job;

-- 입사 연도별 사원수, 급여 평균을 검색. 연도의 오름차순 정렬.
select hiredate, to_char(hiredate, 'YYYY') from emp;
select to_char(hiredate, 'YYYY') as HIRE_DATE,
       count(*) as COUNTS,
       to_char(avg(sal), '9,999.0') as AVG_SAL
from emp
group by to_char(hiredate, 'YYYY')
order by HIRE_DATE;

select to_char(1234, '9,999.0') from dual;

-- 부서별, 직책별 부서번호, 직책, 사원수, 급여 평균을 검색
-- 정렬 기준: 1) 부서번호, 2) 직책
select deptno, job, count(*), avg(sal)
from emp
group by deptno, job 
order by deptno, job;

select job, deptno, count(*), avg(sal)
from emp
group by job, deptno
order by job, deptno;

-- 매니저별 사원 수 검색. 매니저 사번의 오름차순 정렬.
select mgr, count(*)
from emp
group by mgr
order by mgr;

-- 매니저별 사원 수 검색. 단, 매니저 사번이 null 아닌 경우만.
-- 매니저 사번의 오름차순 정렬.
select mgr, count(*)
from emp
where mgr is not null
group by mgr
order by mgr;
-- where 조건절은 그룹별로 묶기 전에 필터링하기 위해서 사용!

-- 부서별 부서번호, 급여 평균 검색.
-- 부서별 급여 평균이 2000 이상인 경우만 검색.
select deptno, avg(sal)
from emp
where avg(sal) >= 2000
group by deptno;
-- 오류(error) 발생: 
-- 그룹별로 묶기 전에 그룹함수 avg()를 where에서 사용할 수 없음!

-- having: 그룹으로 묶은 다음 조건 검사가 필요한 경우에 사용.
select deptno, avg(sal)
from emp
group by deptno
having avg(sal) >= 2000
order by deptno;

/* SELECT 구문의 순서
select 컬럼이름, ...
from 테이블이름
where 조건 검사
group by 컬럼이름, ...
having 그룹별 조건 검사
order by 컬럼이름, ...;
*/
-- 직책별 직책, 사원수 검색. PRESIDENT는 제외.
-- 직책별 사원수가 3명 이상인 직책만 선택.
-- 직책 오름차순 정렬
select job, count(*)
from emp
where job != 'PRESIDENT'
group by job
having count(*) >= 3
order by job;

