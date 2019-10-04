/*
  ����: ORACLEʹ����ģ��ID�Զ�������
  
*/
create sequence seq_test4;

create table test2(
   tid number primary key,
   tname varchar2(10)    
);

insert into test2 values(seq_test4.nextval,'����');
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
   m number := 3;             
begin
   for y in -m..m loop
     for x in -m..m loop
         if abs(y) + abs(x) <= m then
            dbms_output.put('*');
         else  
            dbms_output.put(' ');  
         end if;
     end loop;
     dbms_output.new_line();
   end loop;  
end;


/*
   �α�(���): ������������ѯ�����,�൱����JDBC��ResultSet
       
       �﷨: cursor �α���[(������ ��������)] is ��ѯ�����
       
       ��������:
           1. �����α�
           2. ���α�       open �α���
           3. ���α���ȡ����  fetch �α��� into ����
                         �α���%found :�ҵ�����
                         �α���%notfound : û���ҵ����� 
           4. �ر��α�       close �α���
           
      ϵͳ�����α�
           1. �����α� : �α��� sys_refcursor
           2. ���α�: open �α��� for �����
           3. ���α���ȡ����
           4. �ر��α�
                
     forѭ�������α�:
           ����Ҫ�����������
           ����Ҫ���α�
           ����Ҫ�ر��α�      
*/
--���Ա���������е�Ա�������͹���(���������α�)
/*
   �α�:����Ա��
   ����һ������,������¼һ������  %rowtype
*/
declare
   --�α�
   cursor vrows is select * from emp;
   --s��������,��¼һ������
   vrow emp%rowtype;
begin
   --1.���α�  
   open vrows;
   --2.���α���ȡ����
   --ѭ��ȡ����
   loop
       fetch vrows into vrow; 
       exit when vrows%notfound;  
       dbms_output.put_line('����:'||vrow.ename ||' ����: ' || vrow.sal);
   end loop;
   --3.�ر��α�
   close vrows;
end;

--���ָ�������µ�Ա�������͹���
/*
   �α�: ָ�����ŵ�����Ա��
   ����һ��������¼һ������
*/
declare
   --�����α�
   cursor vrows(dno number) is select * from emp where deptno = dno;
   --��������
   vrow emp%rowtype;
begin
  --1.���α� , ָ��10�Ų���
  open vrows(10);
  --2. ѭ������,ȡ����
  loop
     fetch vrows into vrow;
     exit when vrows%notfound;    
      dbms_output.put_line('����:'||vrow.ename ||' ����: ' || vrow.sal);
  end loop;
  close vrows;
end;

--ϵͳ�����α�
--���Ա���������е�Ա�������͹���
declare
  --����ϵͳ�����α�
  vrows sys_refcursor;
  --����һ������
  vrow emp%rowtype;
begin
  --1.���α�
  open vrows for select * from emp;
  --2.ȡ����
  loop
    fetch vrows into vrow;
    exit when vrows%notfound;
     dbms_output.put_line('����:'||vrow.ename ||' ����: ' || vrow.sal);
  end loop;
  close vrows;
end;

--��չ����----ʹ��forѭ�������α�
declare
  --����һ���α�
  cursor vrows is select * from emp;
begin
  for vrow in vrows loop
     dbms_output.put_line('����:'||vrow.ename ||' ����: ' || vrow.sal || '����:'|| vrow.job);
  end loop;
end;

select * from emp;



--����Ա������������Ա���ǹ���,�ܲ���1000,������800,��������400
/*
    �α� : ����Ա��
    ����һ����¼һ������   
*/
declare
   --�����α�
   cursor vrows is select * from emp;
   --����һ������
   vrow emp%rowtype; 
begin
  --1.���α�
  open vrows;
  --2.ѭ��ȡ����
  loop
       --ȡ����
       fetch vrows into vrow;
       --�˳�����
       exit when vrows%notfound;  
       --���ݲ�ͬ��ְλ,�ǹ��� �ܲ���1000,������800,��������400
       if vrow.job = 'PRESIDENT' then
          update emp set sal = sal + 1000 where empno = vrow.empno;
       elsif vrow.job = 'MANAGER' then
          update emp set sal = sal + 800 where empno = vrow.empno;
       else
          update emp set sal = sal + 400 where empno = vrow.empno; 
       end if;       
  end loop;
  --3.�ر��α�
  close vrows;
  --4.�ύ����
  commit;
end;


select * from emp;


/*
   ����:(����)�������еĹ��̷����쳣,�൱����JAVA�е��쳣
   
   declare
       --��������
   begin
       --ҵ���߼�
   exception
       --�����쳣
       when �쳣1 then
         ...
       when �쳣2 then
         ...
       when others then
         ...���������쳣
   end;
   
   zero_divide : �����쳣
   value_error : ����ת���쳣
   too_many_rows : ��ѯ�����м�¼,���Ǹ�ֵ����rowtype��¼һ�����ݱ���
   no_data_found : û���ҵ�����
       
   
   �Զ����쳣:
       �쳣��  exception;
       raise �쳣��          
*/
declare
   vi number;
   vrow emp%rowtype;
begin
   --vi := 8/0;  
   --vi := 'aaa';
   --select * into vrow from emp;
   select * into vrow from emp where empno=1234567;
exception
  when zero_divide then
    dbms_output.put_line('�����˳����쳣');
  when value_error then
     dbms_output.put_line('����������ת���쳣');
  when too_many_rows then
    dbms_output.put_line(' ��ѯ�����м�¼,���Ǹ�ֵ����rowtype��¼һ�����ݱ���');
  when no_data_found then
    dbms_output.put_line('û���ҵ������쳣');
  when others then
     dbms_output.put_line('�����������쳣' || sqlerrm);     
end;

--��ѯָ����ŵ�Ա��,���û���ҵ�,���׳��Զ�����쳣
/*
     --�������ʾ
     
     1.����һ������ %rowtype
     2.��ѯԱ����Ϣ,��������
     3.�ж�Ա����Ϣ�Ƿ�Ϊ��
     4. ����� ���׳��쳣
*/
declare
  --   1.����һ������ %rowtype
  vrow emp%rowtype;
  --2 .����һ���Զ�����쳣
  no_emp exception;  
begin
  --��ѯԱ����Ϣ,��������
  select * into vrow from emp where empno = 8888;   --�׳��쳣
  
  if vrow.sal is null then
    raise no_emp; --�׳��Զ�����쳣
  end if;
exception
  when no_emp then
     dbms_output.put_line('������Զ�����쳣');  
  when others then
     dbms_output.put_line('����������쳣'||sqlerrm);  
end;

--��ѯָ����ŵ�Ա��,���û���ҵ�,���׳��Զ�����쳣
/*
     �α����ж�
       %found %notfound
    ����һ���α�
    ����һ������,��¼����
    ���α���ȡ��¼
       �����,�򲻹���
       ���û�о��׳��Զ�����쳣
*/
declare
  --�����α�
  cursor vrows is select * from emp where empno=8888;   
  --����һ����¼�ͱ���
  vrow emp%rowtype;
  --����һ���Զ����쳣
  no_emp exception;  
begin
  --1.���α�
  open vrows;
  --2.ȡ����
  fetch vrows into vrow;
  --3.�ж��α��Ƿ�������
  if vrows%notfound then
    raise no_emp;
  end if;
  close vrows;
exception
  when no_emp then
    dbms_output.put_line('�������Զ�����쳣');
end;



/*
    �洢����: ʵ�����Ƿ�װ�ڷ�������һ��PLSQL����Ƭ��,�Ѿ�������˵Ĵ���
              1.�ͻ���ȡ���ô洢����,ִ��Ч�ʾͻ�ǳ���Ч
         �﷨:
              create [or replace] procedure �洢���̵�����(������ in|out ��������,������ in|out ��������)
              is | as
               --��������
              begin
               --ҵ���߼� 
              end; 
             
              
*/
--��ָ��Ա����н,����ӡ��нǰ����н��Ĺ���
/*
    ���� : in Ա�����
    ���� : in �Ƕ���
    
    ����һ������ : �洢�ǹ���ǰ�Ĺ���
    
    ��ѯ����ǰ�Ƕ���
    ��ӡ��нǰ�Ĺ���
    ���¹���
    ��ӡ��н��Ĺ���          
*/
create or replace procedure proc_updatesal(vempno in number,vnum in number)
is
   --��������.��¼��ǰ����
   vsal number;    
begin
  --��ѯ��ǰ�Ĺ���
  select sal into vsal from emp where empno = vempno;
  --�����нǰ�Ĺ���
  dbms_output.put_line('��нǰ:'||vsal);
  --���¹���
  update emp set sal = vsal + vnum where empno = vempno;
  --�����н��Ĺ���
  dbms_output.put_line('��н��:'||(vsal+vnum));
  --�ύ
  commit;
end;

--��ʽ1
call proc_updatesal(7788,10);

--��ʽ2 �õ����ķ�ʽ
declare

begin
  proc_updatesal(7788,-100);
end;


/*
  �洢����: ʵ������һ�η�װ��Oracle�������е�һ��PLSQL����Ƭ��,�����Ѿ�������˵Ĵ���Ƭ��
        
        �﷨: 
             create [or replace] function �洢����������(������ in|out ��������,������ in|out ��������) return ��������
             is | as
             
             begin
               
             end;
        �洢���̺ͺ���������:
             1.���Ǳ�����û������
             2.�������ڵ������Ǹ����̵���   �洢����������ô洢����
             3.����������sql�������ֱ�ӵ���
             4.�洢������ʵ�ֵ�,�洢����Ҳ��ʵ��,�洢������ʵ�ֵ�,����Ҳ��ʵ��
             
        Ĭ���� in       
*/
--��ѯָ��Ա������н
/*
    ���� : Ա���ı��
    ���� : ��н          
*/
create or replace function func_getsal(vempno number) return number
is
  --��������.������н8i
  vtotalsal number;     
begin
  select sal*12 + nvl(comm,0) into vtotalsal from emp where empno = vempno;
  return vtotalsal;
end;

--���ô洢����
declare
  vsal number;
begin
  vsal := func_getsal(7788);
  dbms_output.put_line(vsal);
end;


--��ѯԱ��������,��������н
select ename,func_getsal(empno) from emp;
--��ѯԱ���������Ͳ��ŵ�����


--��ѯָ��Ա������н--�洢������ʵ��
--����: Ա�����
--���: ��н
create or replace procedure proc_gettotalsal(vempno in number,vtotalsal out number)
is
       
begin
  select sal*12 + nvl(comm,0) into vtotalsal from emp where empno = vempno;
end;


declare
  vtotal number;
begin
  proc_gettotalsal(7788,vtotal);
  dbms_output.put_line('��н:'||vtotal);
end;

select *  from emp where empno = 8888; 

/*
    JAVA���ô洢����
       JDBC�Ŀ�������:
          1.����������
          2.ע������
          3.��ȡ����
          4.��ȡִ��SQL��statement
          5.��װ����
          6.ִ��SQL
          7.��ȡ���
          8.�ͷ���Դ   
*/

/*
   ��װһ���洢���� : ������б��еļ�¼
   
   ������� : �α�  
*/
create or replace procedure proc_getemps(vrows out sys_refcursor)
is

begin
  --1.���α�, ���α긳ֵ
  open vrows for select * from emp;
end;



/*
   ������: ���û�ִ���� insert | update | delete ��Щ����֮��, ���Դ���һϵ�������Ķ���/ҵ���߼�
       ���� : 
            �ڶ���ִ��֮ǰ����֮��,����ҵ�����߼�
            ��������,��һЩУ��
            
       �﷨:
           create [or replace] trigger ������������
           before | after
           insert | update | delete 
           on ����
           [for each row]
           declare
           
           begin
             
           end;
           
       �������ķ���:
           ��伶������:   ����Ӱ�������, ��ֻ��ִ��һ��
           
           �м�������:     Ӱ�������,�ʹ������ٴ�
                  :old  ����ɵļ�¼, ����ǰ�ļ�¼
                  :new  ��������µļ�¼
       
*/
--��Ա����ְ֮��,���һ�仰: ��ӭ����������Ա
create or replace trigger tri_test1
after
insert
on emp
declare

begin
  dbms_output.put_line('��ӭ����������Ա');
end;

insert into emp(empno,ename) values(9527,'HUAAN');

--����У��, �������ϰ岻��, ���ܰ�����Ա����ְ
--�ڲ�������֮ǰ
--�жϵ�ǰ�����Ƿ�������
--���������,�Ͳ��ܲ���
create or replace trigger tri_test2
before
insert 
on emp
declare
 --��������
 vday varchar2(10);
begin
  --��ѯ��ǰ
  select trim(to_char(sysdate,'day')) into vday from dual;
  --�жϵ�ǰ����:
  if vday = 'saturday' then
     dbms_output.put_line('�ϰ岻��,���ܰ�����ְ');
     --�׳�ϵͳ�쳣
     raise_application_error(-20001,'�ϰ岻��,���ܰ�����ְ');
  end if;
end;

insert into emp(empno,ename) values(9528,'HUAAN2');

--�������еĹ��� ���һ�仰
create or replace trigger tri_test3
after
update
on emp 
for each row
declare

begin
  dbms_output.put_line('����������');
end;

update emp set sal = sal+10;



--�ж�Ա���ǹ��ʺ�Ĺ���һ��Ҫ�����ǹ���ǰ�Ĺ���
/*
   200 --> 100
   ������ : before
      �ɵĹ��� 
      �µĹ���
      ����ɵĹ��ʴ����µĹ��� , �׳��쳣,������ִ�гɹ�   
      
      
   �������в����ύ����,Ҳ���ܻع����� 
*/
create or replace trigger tri_updatesal
before
update
on emp
for each row
declare

begin
  if :old.sal > :new.sal then
    raise_application_error(-20002,'�ɵĹ��ʲ��ܴ����µĹ���');
  end if;
end;

update emp set sal = sal + 10;
select * from emp;

update emp set sal = sal - 100;


/*
   ģ��mysql��ID���������� auto_increment 
   insert into person(null,'����');  
   
   ������:
   
   pid=1  insert  pid=1
   
   ���� : create sequence seq_person_pid;       
*/
create table person(
    pid number primary key,
    pname varchar2(20)   
);

insert into person values(null,'����'); 

create sequence seq_person_pid;

--������
create or replace trigger tri_add_person_pid
before
insert
on person
for each row
declare

begin
  dbms_output.put_line(:new.pname);
  --���¼�¼ pid ��ֵ
  select seq_person_pid.nextval into :new.pid from dual;
end;

insert into person values(null,'����'); 


select * from person;
