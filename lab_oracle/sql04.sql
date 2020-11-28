/*
Oracle 연습계정 hr 활성화
1. 명령 프롬프트를 실행
2. sqlplus를 사용해서 SYSTEM/oracle(계정/비밀번호) sysdba 권한으로 접속
3. SQL 명령 프롬프트 상태에서 hr계정의 비밀번호를 hr로 설정하면서 unlock
4. hr/hr(계정/비밀번호) 접속 테스트
5. 명령 프롬프트 종료
6. SQL Developer에서 hr 계정으로 접속할 수 있도록 설정.
*/

-- hr 계정을 접속

-- hr 계정의 테이블들 중에서 employees 테이블의 구조를 확인
desc employees;

-- employees 테이블에서 first_name이 'J'로 시작하는 사원들의
-- 사번(employee_id), 이름(first_name), 성(last_name), 부서번호(department_id)를 검색
-- 사번 오름차순으로 정렬
select employee_id, first_name, last_name, department_id
from employees
where first_name like 'J%'
order by employee_id;

-- first_name이 'J'로 시작하는 사원들의 이름과 성을 하나의 컬럼으로 출력
-- concat() 함수 사용. alias를 사용.
select concat(concat(first_name, ' '), last_name) as 사원이름
from employees
where first_name like 'J%';

-- 전화번호가 '011'로 시작하는 사원들의
-- 사번, 성(last_name), 전화번호를 검색
-- 성의 오름차순으로 정렬
select employee_id, last_name, phone_number
from employees
where phone_number like '011%'
order by last_name;

-- 매니저 사번이 120인 사원들의
-- 사번, 성, 급여(salary), 입사일(hire_date)을 검색
-- 입사일의 내림차순으로 정렬.
select employee_id, last_name, salary, hire_date
from employees
where manager_id = 120
order by hire_date desc;

-- 급여가 3000 이상 5000 이하인 사원들의
-- 사번, 성, 급여, 부서번호를 검색
-- 급여의 내림차순으로 정렬.
select employee_id, last_name, salary, department_id
from employees
-- where salary between 3000 and 5000
where salary >= 3000 and salary <= 5000
order by salary desc;

-- 수당을 받는 직원들의 사번, 성, 급여, 수당 비율, 1년 연봉을 검색
-- 1년 연봉 = (salary * 12) * (1 + commission_pct)
-- 1년 연봉의 내림차순 정렬.
select employee_id, last_name, salary, commission_pct,
       (salary * 12) * (1 + commission_pct) as 연봉
from employees
where commission_pct is not null
order by 연봉 desc;

-- 수당을 받는 직원들의 사번, 성, 급여, 수당 비율, 1년 연봉을 검색
-- 연봉이 100000 이상인 직원들만 연봉의 내림차순으로 정렬
select employee_id, last_name, salary, commission_pct,
       (salary * 12) * (1 + commission_pct) as annual_sal
from employees
where commission_pct is not null
      and (salary * 12) * (1 + commission_pct) >= 100000
order by annual_sal desc;

-- 1) employees 테이블에서 사번이 179인 사원의 레코드를 출력하세요.
-- 2) 1)에서 찾은 정보를 사용해서, 179번 사원의 직책 이름(job_title)을 찾으세요.
-- 3) 1)에서 찾은 정보를 사용해서, 179번 사원의 일하는 부서 레코드를 찾으세요.
-- 4) 1)에서 찾은 정보를 사용해서, 179번 사원의 매니저의 first & last_name을 찾으세요.
-- 5) 3)에서 찾은 정보를 사용해서, 179번 사원이 일하는 부서의 위치 레코드를 찾으세요.
-- 6) departments 테이블에서 manager_id가 있는 부서의 레코드를 출력하세요.
-- 7) departments 테이블에서 부서번호가 20인 부서의 레코드를 출력하세요.
-- 8) 7)에서 찾은 정보를 사용해서, 20번 부서의 관리자(manager)의 레코드를 찾으세요.
-- 9) 7)에서 찾은 정보를 사용해서, 20번 부서의 위치 레코드를 찾으세요.
-- 10) 9)에서 찾은 정보를 사용해서, 20번 부서가 있는 나라의 이름을 찾으세요.

