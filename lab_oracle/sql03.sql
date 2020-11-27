-- 이름이 'S'로 시작하는 사원들의 모든 정보 검색
select * from emp
where ename like 'S%';

-- like 연산자를 사용할 때
-- %: 몇 글자이든 상관없이 아무 문자로 대체
-- _: 한글자만 아무 문자로 대체

select * from emp where ename = 'KING';
select * from emp where ename like '_ING';
select * from emp where ename like '%ING';
select * from emp where ename like '_NG';
select * from emp where ename like '%NG';

-- 이름 중에 'E'가 포함된 사원들의 모든 컬럼을 검색
select * from emp where ename like '%E%';

-- 이름 중에 'LL'이 포함된 사원들의 모든 컬럼을 검색
select * from emp where ename like '%LL%';

-- 수당(comm)이 0인 사원의 정보를 검색
select * from emp where comm = 0;

-- 0은 비교 연산(=, !=, >, >=, <, <=, ...)이 가능
-- null은 비교 연산이 불가능!
-- null인지 아닌지 비교할 때는 is 연산자를 사용함 - is null, is not null

-- 수당(comm)이 없는(null인) 사원의 정보를 검색
select * from emp where comm = null;
select * from emp where comm is null;

-- 수당이 있는(null이 아닌) 사원들의 정보를 검색
select * from emp where comm != null;
select * from emp where comm is not null;

-- 수당(comm)은 없고, 매니저(mgr)는 있고, 직책(job)은 'MANAGER' 또는 'CLERK'인
-- 사원들의 모든 컬럼을 검색
select * from emp
where comm is null                    -- 수당이 없는
    and mgr is not null               -- 매니저가 있는  
    and job in ('MANAGER', 'CLERK');  -- 직책은 매니저 또는 경리


-- SQL을 활용한 산술 연산(+, -, *, /)
-- dual: select ~ from ... 문법을 맞추기 위한 가상의 테이블 이름.
select 1 + 1 from dual;  -- dual은 가상 테이블
select 3 * 2 from dual;
select 3 * 2 from dual;
select 100 * 12 + 500 from dual;
select sal, comm, sal * 12 + comm from emp;

/*
이것도 역시 주석(comment)입니다. 
Block 주석
*/

-- 함수(function): 동일한 기능을 반복할 수 있는 코드
-- 인수(argument): 함수가 기능을 수행할 때 필요해서 입력으로 전달하는 값.
-- 반환 값(return value): 함수가 기능을 수행한 후 출력으로 반환하는 값.

-- 문자열 관련 함수
select upper('Hello, world!') from dual;
-- upper: 함수
-- 'Hello, world!': argument
-- 'HELLO, WORLD!': return value

select lower('Hello, world!') from dual;
select initcap('Hello, world!') from dual;

select ename, lower(ename), initcap(ename) from emp;

select * from emp where lower(ename) = 'smith';
select * from emp where upper(ename) = 'SMITH';

-- length(string): string의 글자 수를 반환(return).
-- lengthb(string): stirng을 저장하기 위해 필요한 바이트 수를 반환(return).
select length('hello') from dual;
select lengthb('hello') from dual;

select length('안녕'), lengthb('안녕') from dual;

select dname, length(dname) from dept;

-- substr(문자열, 인덱스, 잘라낼 문자 개수): 문자열 잘라내기
select substr('hello', 1, 2) from dual;
select substr('hello', 1, 3) from dual;
select substr('hello', 2, 2) from dual;
select substr('hello', 2, 3) from dual;

-- substr(문자열, 인덱스): 인덱스부터 문자열 끝까지 잘라내기
select substr('hello', 2) from dual;
select substr('hello', -2) from dual;  -- 음수 인덱스: 끝에서부터 세는 인덱스

-- concat(문자열1, 문자열2): 문자열 합치기
select concat('hello', 'world') from dual;
select concat(concat('hello', ' '), 'world') from dual;

-- trim(문자열): 문자열의 시작과 끝에 있는 공백들을 제거.
select trim('    hello    world    olleh    ') from dual;

-- lpad(문자열, 자릿수 바이트, padding문자)
-- rpad(문자열, 자릿수 바이트, padding문자)
select lpad('hello', 7, '*'), rpad('hello', 7, '*') from dual;

-- 'hello'에서 첫 두글자는 그대로 출력, 나머지는 '*'로 출력
select rpad(substr('hello', 1, 2), length('hello'), '*') from dual;
select rpad(substr('abcd', 1, 2), length('abcd'), '*') from dual;
select rpad(substr('안녕하세요', 1, 2), length('안녕하세요'), '*') from dual;
select rpad(substr('안녕하세요', 1, 2), lengthb('안녕하세요'), '*') from dual;
select rpad(substr('안녕하세요', 1, 2), 7, '*') from dual;

-- emp 테이블에서 사원의 이름을 다섯자리만 출력.
-- 이름에서 첫 두글자는 그대로 출력, 나머지 세글자는 '*'로 출력.
select rpad(substr(ename, 1, 2), 5, '*')
from emp;
