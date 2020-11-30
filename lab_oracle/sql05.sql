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

