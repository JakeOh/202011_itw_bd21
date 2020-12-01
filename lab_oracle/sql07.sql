-- hr 계정 사용
-- group by, subquery 연습

-- 1) 부서별 사원수, 급여 최댓값, 최솟값, 합계, 평균, 중앙값, 분산, 표준편차 검색
-- 소수점이 출력되는 경우는 소수점 1자리까지만 표현.
-- 부서번호의 오름차순을 정렬해서 출력
select department_id, 
       count(*) as counts,
       max(salary) as max_sal,
       min(salary) as min_sal,
       sum(salary) as sum_sal,
       round(avg(salary), 1) as avg_sal,
       median(salary) as median_sal,
       round(variance(salary), 1) as var_sal,
       round(stddev(salary), 1) as std_sal
from employees
group by department_id
order by department_id;


-- 2) 직책별 사원수, 급여 최댓값, 최솟값, 합계, 평균, 중앙값, 분산, 표준편차 검색
-- 소수점이 출력되는 경우는 소수점 1자리까지만 표현.
-- 직책의 오름차순을 정렬해서 출력
select job_id, 
       count(*) as counts,
       max(salary) as max_sal,
       min(salary) as min_sal,
       sum(salary) as sum_sal,
       round(avg(salary), 1) as avg_sal,
       median(salary) as median_sal,
       round(variance(salary), 1) as var_sal,
       round(stddev(salary), 1) as std_sal
from employees
group by job_id
order by job_id;

-- 3) 부서별 직책별 사원수, 급여의 평균 검색
-- 부서번호, 직책 순으로 정렬.
select department_id, job_id, count(*), round(avg(salary), 1)
from employees
group by department_id, job_id
order by department_id, job_id;

-- 4) 사번, 이름(first/last name), 입사일, 급여를 입사일 오름차순으로 출력
select employee_id, 
       concat(concat(first_name, ' '), last_name) as name,
       hire_date,
       salary
from employees
order by hire_date;

-- 5) 입사연도별 사원수, 급여의 최댓값, 최솟값, 평균을 입사연도 오름차순으로 출력
select to_char(hire_date, 'YYYY') as year,
       count(*) as counts,
       max(salary) as max_sal,
       min(salary) as min_sal,
       round(avg(salary), 1) as avg_sal
from employees
group by to_char(hire_date, 'YYYY')
order by year;

-- 6) 수당을 받는 직원들의 직책별 사원수, 연봉의 평균을 직책의 오름차순으로 출력
-- 연봉 = salary * 12 * (1 + commission_pct)

-- 7) 부서번호가 90번이 아니고, null이 아닌 사원들 중에서
-- 부서별 인원수가 10명 이상인 부서의
-- 부서별 인원수, 급여의 최솟값, 최댓값, 중앙값을 부서번호 오름차순으로 출력

-- 8) 각 부서에서 급여가 가장 작은 사원의 부서번호, 사번, 이름, 급여를
-- 부서번호의 오름차순으로 출력

-- 9) 각 부서에서 급여가 가장 많은 사원의 부서번호, 사번, 이름, 급여를
-- 부서번호의 오름차순으로 출력

-- 10) 10번 부서 매니저의 사번, 이름, 입사일을 출력

-- 11) 10번 부서가 위치한 도시(city), 주(state_province), 국가코드(country_id)를 출력
