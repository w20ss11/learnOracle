select * from emp;
-- ����: ORACLEʹ����ģ��ID�Զ�������
create sequence seq_test2;
drop table test2;
create table test2(
       tid number primary key,
       tname varchar2(10)
)
insert into test2 values(seq_test2.nextval,'����');
select * from test2;
/*
       PLSQL���: ��������,��дһЩ����ҵ���߼�  
       
       ����Ǻ�:
                abs(y) + abs(x) <= m   
                
       vsal  emp.sal%type --�����ͱ���
       row  emp%rowtype  --��¼�ͱ���
       
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

------------------------------�α�:����������ѯ�Ľ����.�൱��JDBC�е�ResultSet-------------
declare
    cursor vrows is select * from emp;--�����α�/��������
    --��������,���������
    vrow emp%rowtype;
begin
  open vrows;--���α�
  loop
    fetch vrows into vrow;
    exit when vrows%notfound;
    dbms_output.put_line('����:'||vrow.ename||'����'||vrow.sal);
  end loop;
  close vrows;--�ر��α�
end;

--ʹ���α��ѯָ��10�Ų���
set serveroutput on;
declare
  cursor vrow(dno number) is select * from emp where deptno = dno;
  vrows emp%rowtype;
begin
        open vrow(10);
        loop
          fetch vrow into vrows;
          exit when vrow%notfound;
          dbms_output.put_line('����'||vrows.ename||'����'||vrows.sal);
        end loop;
        close vrow;
end;

--ʹ��for�����α�
declare
       cursor vrows is select * from emp;
begin
       for vrow in vrows loop
         dbms_output.put_line('����'||vrow.ename||'����'||vrow.sal);
       end loop;

end;

