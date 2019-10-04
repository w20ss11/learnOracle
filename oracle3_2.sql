--c##dakang�û���
select * from system.myemp;

create table test1(
   name1 varchar2(10),
   name2 char(10),
   age   number(2,3)    
);

insert into test1(name1,name2) values('hello','hello');

select * from test1 where name1 like 'hello'; --���Բ�ѯ����
select * from test1 where name2 like 'hello'; --�鲻������

insert into test1(age) values(2);

select current_date from dual;
select current_timestamp from dual;

select * from test1;

--  create table ���� as ��ѯ���; ���Ʊ�     
select * from scott.emp;

create table emp as select * from system.myemp;

--�����ѯ�����û���κεĽ����
select * from scott.emp where 1=2;
create table emp1 as select * from scott.emp where 1=2;


select * from emp1;


/*
    �޸ı�:
       �����
       �޸��� vharchar2(10)
       ɾ����
       �޸�����
       
       ��������   
       
  SQL����:
       DDL : ���ݶ�������, �޸ĵĽṹ  alter create drop truncate
       DML :�����ݲ������� , ������������ insert update delete
       DCL : ���ݿ������� , grant     
       DQL : select
*/
create table stu(
    stuid number,
    sname varchar(10)   
);

--���һ��  
alter table stu add phone varchar2(11);

alter table stu add (
                          mobile varchar2(11),
                          sex    varchar2(2)
                     );

--�޸��е�����
alter table stu modify sex varchar2(4);

--�޸����� sex --- gender
alter table stu rename column sex to gender;

--ɾ����
alter table stu drop column gender;

--�޸ı���
rename stu to student;



--ɾ����
drop table student;


/*
   ������Լ��
   �е�Լ��: Լ����Ҫ������Լ���������ݵĹ���
     ����Լ��: primary key ����Ϊ��, ����Ψһ
     �ǿ�Լ��
     ΨһԼ��
     ���Լ�� check(����)  ��mysql���ǿ���д��,����mysqlֱ�Ӻ����˼��Լ��
     
     ���Լ��:
          ��Ҫ������Լ���ӱ�A�еļ�¼,�����Ǵ���������B��
*/
--��,Ů,����
create table student(
    stuid number primary key,
    sname varchar2(10) unique,
    age   varchar2(10) not null,
    gender varchar2(4) check( gender in ('��','Ů','����'))
);
--����Լ��Υ��
insert into student values(1,'����','31','��');
insert into student values(1,'����','31','��');
--ΨһԼ��Υ��
insert into student values(1,'����','31','��');
insert into student values(2,'����','31','��');
--�ǿ�Լ��
insert into student values(1,'����',null,'��');
--���Լ��
insert into student values(1,'����','31','��');

insert into student values(1,'����','31','��');

select * from student;

/*
     ��Ʒ����,��Ʒ��
     
*/
--��Ʒ�����
create table category(
       cid number primary key,
       cname varchar2(20)
);

--����һ����Ʒ��
create table product(
       pid number primary key,
       pname varchar2(20),
       cno number
);

insert into category values(1,'�ֻ�����');

insert into product values(10,'����',11);



--������Լ��
alter table product add foreign key(cno) references category(cid);
insert into product values(10,'����',11);--����ʧ��

--1.���������б������11��, ���������в�������,�����ӱ��в�������
insert into category values(2,'���԰칫');
insert into product values(11,'������',2);


--ɾ��Category
drop table category; --���м�¼����������޷�ɾ��

--ǿ��ɾ����(������ʹ��) : ��ɾ���������������Լ��,Ȼ����ɾ���Լ�, ��ɾ��product�����Լ��,��ɾ��category
drop table category cascade constraint;


--����ɾ��
----������Լ��,ʹ�ü���Լ��  ,��ɾ����ʱ��,ʹ�ü���ɾ��
alter table product add foreign key(cno) references category(cid) on delete cascade;


insert into category values(2,'���԰칫');
insert into product values(11,'������',2);

--����ɾ�� : ����ȥ�ӱ�������û�� ��������, ����ڴӱ����ҵ���������,��ɾ���ӱ��й�������,Ȼ����ɾ�����е�����
delete from category where cid = 2;


select * from category;
select * from product;

drop table product;
truncate table product;
truncate table category;

/*
     ��������:
         insert into ���� values(�����е�ֵ��Ҫ��Ӧд��)
         insert into ����(��1,��2) values(ֵ1,ֵ2);
         
     ʹ���Ӳ�ѯ��������
         insert into ���� ��ѯ���
*/
select * from emp1;

select * from emp;
--��emp��10�Ų��ŵ�Ա����Ϣ,���뵽emp1��
insert into emp1 select * from emp where deptno = 10;


/*
     ��������
       update ���� set ���� = �е�ֵ  [where ����]
*/
update emp1 set ename='HUAAN' where ename = 'KING';
select * from emp1;

/*
     ɾ������:
       delete from ����  [where ����]
       
       delete��truncate ����
        
       delete:                 truncate:
        DML                    DDL
        ����ɾ��               ��ɾ�����ٴ�����
        ֧���������           ��֧���������,
                               ִ��Ч��Ҫ��  
       
       
*/
delete from emp1 where empno=7839;

/*
   ����: ����һϵ�еĲ���,Ҫô���ɹ�,Ҫô��ʧ��
       �Ĵ�����: ԭ����,������,�־���,һ����
          
       ��������Ǹ��뼶��: ���,���,�����ظ���
            MYSQL���뼶��: READ UNCOMMITTED , READ COMMITTED, REPEATABLE READ, SERIALIAZABLE
            ORACLE���뼶��: READ COMMITTED SERIALIZABLE READ ONLY 
                        Ĭ�ϸ��뼶��: READ COMMITTED
                        
      �ύ : commit
      ����ı����/�ع���: savepoint ����������
      �ع�: rollback
*/
create table louti(
   lou number primary key    
);

insert into louti values(1);
insert into louti values(2);
insert into louti values(3);
insert into louti values(4);
insert into louti values(5);
savepoint dangban;
insert into louti values(5); --����Լ���ᷢ���쳣
insert into louti values(6);
rollback to dangban
commit;


declare

begin
  insert into louti values(1);
  insert into louti values(2);
  insert into louti values(3);
  insert into louti values(4);
  insert into louti values(5);
  savepoint dangban;
  insert into louti values(5);  --���д���ᷢ���쳣
  insert into louti values(6);
  commit;
exception  --�����쳣
  when others then
     rollback to dangban;
     commit;
end;

select * from louti;

/*
      ��ͼ: �ǶԲ�ѯ�����һ����װ
              ��ͼ�������е�����,��������������ѯ�����ű�,��ͼ�����洢�κ�����
          1.�ܹ���װ���ӵĲ�ѯ���
          2.���α��е�ϸ��
       �﷨: 
          create [or replace] view ��ͼ������ as ��ѯ��� [ with read only]
          
       ע��: ͨ����Ҫͨ����ͼȥ�޸�,��ͼ������ʱ��,ͨ��Ҫ����with read only
*/
select * from emp;

--����һ����ͼ
create or replace view view_test1 as select ename,job,mgr from emp;

--ͨ����ͼ�޸�����
update view_test1 set ename='SMITH2' where ename = 'SMITH';

--����һ��ֻ����ͼ
create or replace view view_test2 as select ename,job,mgr from emp with read only;

update view_test2 set ename='SMITH3' where ename = 'SMITH2';

--��ͼ��װ���ӵĲ�ѯ���
create view view_test3 as select
      sum(cc) "TOTAL",
      sum(case yy when '1980' then cc end) "1980",
      sum(case yy when '1981' then cc end) "1981",
      sum(case yy when '1982' then cc end) "1982",
      sum(case yy when '1987' then cc end) "1987"
from
      (select  to_char(hiredate,'yyyy') yy,count(1) cc from emp group by  to_char(hiredate,'yyyy')) tt;



--ͬ��ʵĸ���
create synonym dept for view_test3;


create synonym yuangong for view_test2;

select * from yuangong;

select * from dept;

select * from view_test3;

select * from view_test2;

/*
    ����: ���������� auto_increment ����ID�Զ����� 1,2,3,4,5....
       auto_increment �����mysql  
       
       �﷨:
           create sequence ���е�����
           start with �Ӽ���ʼ
           increment by ÿ����������
           maxvalue ���ֵ | nomaxvalue
           minvalue ��Сֵ | nominvalue
           cycle | nocycle  �Ƿ�ѭ��    1,2,3,1,2,3
           cache ���������3 | nocache  1,2,3,4,5,6 
           
      ��δ����л�ȡֵ
          currval : ��ǰֵ
          nextval : ��һ��ֵ
          
               ע��: currval ��Ҫ�ڵ���nextval֮�����ʹ��      
               
               ������ͷ,����ȡ����, ���۷����쳣, �ع�   
*/
--����һ�� 1,3,5,7,9......30 
create sequence seq_test1
start with 1
increment by 2
maxvalue 30
cycle
cache 10;

select seq_test1.nextval from dual;
select seq_test1.currval from dual;

--�����õ�����һ��д��
create sequence seq_test2;
select seq_test2.nextval from dual;


create sequence seq_test3
start with 1
increment by 2
maxvalue 30
minvalue 0
cycle
cache 10;

select seq_test3.nextval from dual;

/*
    ����:�൱����һ�����Ŀ¼,�ܹ�������ǵĲ�ѯЧ��
       ���ĳһ��,�㾭��������Ϊ��ѯ����,��ô���б�Ҫ��������,�������Ƚϵ����
       
       �﷨: 
             create index ���������� on ����(��)   
        
       ע��:����Լ���Դ���������, ΨһԼ���Դ�Ψһ����
       
       ����ԭ��: btree   balance Tree ƽ�������
       
             ���ĳ����Ϊ��ѯ������ʱ��,������߲�ѯЧ��,�����޸ĵ�ʱ��,�����
             
             ����������֮��,����һ��,DBA����ȥ���ع�����
             
       SQL����:
             1.�鿴ִ�мƻ�F5
             2. ���������cost �� Ӱ������, ��취����            
*/
--��������ݲ���
create table wubaiwan(
      name varchar2(30),
      address varchar2(20) 
);

insert into wubaiwan values('')

--����500000��������
declare

begin
     for i in 1..5000000 loop
       insert into wubaiwan values('����'||i,'��ַ'||i);
     end loop;
     commit;  
end;

--��û����������������,ȥ��ѯ  name='����3000000'  --2.985
select * from wubaiwan where name='����3000000';

--�������� name ��ȥ��ѯ name='����3000000'
create index ind_wubaiwan on wubaiwan(name);
select * from wubaiwan where name='����3000000';  --0.016

--��û����Ӹ��������������,��ȥ��ѯ name='����3000000' and '��ַ3000000'
select * from wubaiwan where name='����3000000' and address='��ַ3000000'; --0.032

--�������������������, ��ȥ��ѯ
create index ind_wubaiwan2 on wubaiwan(name,address);
select * from wubaiwan where name='����3000000' and address='��ַ3000000'; --0.015



/*
     DDL��ռ����
         ������ռ�
         �����û�
         ��Ȩ
         
         ������
              �Ӳ�ѯ������
         �޸ı� : �����,ɾ����,�޸���,�޸�����, �޸ı���
         
         Լ��:
             ����Լ��,ΨһԼ��,�ǿ�Լ��,���Լ��,���Լ��
             
             ���Լ��:
               ǿ��ɾ��
               ����ɾ��
             
     DML��������:
         ��������
             �Ӳ�ѯ��������
         ��������
         ɾ������: delete �� truncate
         
         �������:
               savepoint �����
               rollback to �����
          ORACLE������뼶��  : READ COMMITTED 
          
     ��ͼ: ���񴰻�һ��, ��װ��ѯ��� , ͨ����ͼ����ֻ����ͼ
     ����: ��Ҫ������ʵ��ID������ 
     ����: �൱�������Ŀ¼,�ܹ���߲�ѯЧ��, ԭ�� ƽ�������, ÿ��һ��ʱ��DBA����Ҫȥ�ؽ�����
     ͬ���: create synonym ���� for ���������          

*/
/*
     PLSQL��� : procedure Language �������� Oracle��SQL��һ����չ
             �������ܹ�����java��һ��д if else else if ����, �����Ա�дѭ���߼� for while
             
             declare
                --��������
                ������ ��������;
                ������ �������� := ��ʼֵ;
                  vsal emp.sal%type;  --�����͵ı���  
                  vrow emp%rowtype;   --������¼�ͱ���          
             begin
                --ҵ���߼�
             end;
             
             dbms_output.put_line()�൱��java�� syso 
*/
declare
   i varchar2(10) := '����';          
begin
  dbms_output.put_line(i);
end;

--��ѯ7369�Ĺ���,���Ҵ�ӡ����
declare
  vsal emp.sal%type;
begin
  --����ѯ���Ľ����ֵ��vsal
  select sal into vsal from emp where empno = 7369;
  
  dbms_output.put_line(vsal);
end;

--��ѯ7369��Ա����Ϣ,���Ҵ�ӡ����
 select * from emp where empno = 7369;

declare
  vrow emp%rowtype;      
begin
  select * into vrow from emp where empno = 7369;
  
  dbms_output.put_line('����:'||vrow.ename || '����'|| vrow.sal);
end;

/*
  PL�����ж�
     
     if then
     
     elsif then
       
     else 
     
     end if;
*/
--���ݲ�ͬ���,����������
declare
   age number := &aaa;
begin
  if age < 18 then
     dbms_output.put_line('Сƨ��');
  elsif age>=18 and age <=24 then
     dbms_output.put_line('������');
  elsif age>24 and age < 40 then
    dbms_output.put_line('��˾��');
  else 
      dbms_output.put_line('������');    
  end if;
end;

/*
  ѭ������
  while ѭ��
      while ���� loop
        
      end loop;
    
  forѭ��
      for ����  in [reverse] ��ʼֵ..����ֵ loop
        
      end loop;
  
  loopѭ��  
      loop
        exit when ����
      end loop;
      
*/
--���1~10
declare
  i number :=1;
begin
  while i<=10 loop
    dbms_output.put_line(i);
    i := i+1;    
  end loop;
end;

--���1~10
declare

begin
  for i in reverse 1..10 loop
    dbms_output.put_line(i);
  end loop;
end;

--���1~10
declare
   i number :=1;
begin
   loop
     exit when i>10;
      dbms_output.put_line(i);  
     i := i+1;
   end loop;
end;

/*

   *
  ***
 *****
  ***
   *   
��� m  
   x : [-m,m]
   y : [-m,m]
   
   ����������������� : abs(y)+abs(x) <=m
   
   mȡֵ
*/
--ʹ��PLSQL�������
declare
   m number := 10;
begin
   for x in -m..m loop
     for y in -m..m loop
       if abs(y) + abs(x) <= m then
         dbms_output.put('*');
       else
         dbms_output.put(' ');
       end if;      
     end loop;
     dbms_output.new_line();
   end loop;  
end;

--ʹ��PLSQL���������,ֻҪ��������
declare
   m number := 10;
begin
   for x in reverse -m..m loop
     for y in -m..m loop
       if abs(y) + abs(x) <= m and x>=0 then
         dbms_output.put('*');
       else
         dbms_output.put(' ');
       end if;      
     end loop;
     dbms_output.new_line();
   end loop;  
end;