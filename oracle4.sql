select * from emp;
-- 序列: ORACLE使用来模拟ID自动增长的
create sequence seq_test2;
drop table test2;
create table test2(
       tid number primary key,
       tname varchar2(10)
)
insert into test2 values(seq_test2.nextval,'张三');
select * from test2;
/*
       PLSQL编程: 过程语言,编写一些复杂业务逻辑  
       
       输出星号:
                abs(y) + abs(x) <= m   
                
       vsal  emp.sal%type --引用型变量
       row  emp%rowtype  --记录型变量
       
       select sal into vsal from emp where empno=7788;
*/

declare
m number :=5;
begin
  for y in -m..m loop
    for x in -m..m loop
      if abs(x)+abs(y)<=m then
        dbms_output.put('*');
        else
          dbms_output.put(' ');
        end if;
      end loop;
      dbms_output.new_line();
    end loop;
end;

------------------------------游标:用来操作查询的结果集.相当于JDBC中的ResultSet-------------
declare
    cursor vrows is select * from emp;--创建游标/储存结果集
    --声明变量,操作结果集
    vrow emp%rowtype;
begin
  open vrows;--打开游标
  loop
    fetch vrows into vrow;
    exit when vrows%notfound;
    dbms_output.put_line('姓名:'||vrow.ename||'工资'||vrow.sal);
  end loop;
  close vrows;--关闭游标
end;

--使用游标查询指定10号部门
set serveroutput on;
declare
  cursor vrow(dno number) is select * from emp where deptno = dno;
  vrows emp%rowtype;
begin
        open vrow(10);
        loop
          fetch vrow into vrows;
          exit when vrow%notfound;
          dbms_output.put_line('姓名'||vrows.ename||'工资'||vrows.sal);
        end loop;
        close vrow;
end;

--使用for遍历游标
declare
       cursor vrows is select * from emp;
begin
       for vrow in vrows loop
         dbms_output.put_line('姓名'||vrow.ename||'工资'||vrow.sal);
       end loop;

end;

