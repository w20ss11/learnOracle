/*���α��ĸ���*/
select * from help;
--select 1+1; �������mysql���ᱨ��oracle�ᱨ��
select 1+1 from dual; --dual ��oracle�е����/α����Ҫ�����������﷨�ṹ��
select * from dual;

/*������ѯ�� ʹ��as�ؼ��� ����ʡ�� 
������ѯ�����������ַ����߹ؼ��֣�������Ҫ��˫����*/
--drop table MYBONUS;
--drop table MYDEPT;
--drop table MYEMP;
--drop table MYSALGRADE;
--select * from MYEMP;
select ename ����, sal ���� from MYEMP;
select ename "��    ��", sal ���� from MYEMP;

/*ȥ���ظ����� distinct*/
--����ȥ���ظ�
select distinct job from myemp;
--����ȥ���ظ� ÿһ�ж����ظ��Ĳ���ȥ��
select distinct job,deptno from myemp;

--��ѯ�е���������
select 1+1 from dual;
--��ѯԱ����н Ա����emp salΪ��н
select sal*12 from myemp;
--��ѯԱ����н+���� commΪ����
select sal*12 + comm from myemp;
select sal*12 + nvl(comm,0) from myemp;--ע�⣺nullֵ������ȷ����ֵ������������������
--nvl�������������1λnull �ͷ��ز���2

/*�ַ���ƴ��
java��+��ƴ�� oracle��||ƴ��*/
--��ѯԱ������ :  ����:SCOTT
select '������' || ename from myemp;
--ʹ�ú���ƴ��
select concat('��  ����',ename) from myemp;

/*
    ������ѯ : [where�����д��]   
        ��ϵ�����: > >= = < <= != <>
        �߼������: and or not
        ���������:
               like ģ����ѯ
               in(set) ��ĳ��������
               between..and.. ��ĳ��������
               is null  �ж�Ϊ��
               is not null �жϲ�Ϊ��
*/
--��ѯÿ���ܵõ������Ա����Ϣ
select * from myemp where comm is not null;
--��ѯ������1500--3000֮���Ա����Ϣ
select * from myemp where sal between 1500 and 3000;
select * from myemp where sal >= 1500 and sal <= 3000;

--��ѯ������ĳ����Χ��Ա����Ϣ ('JONES','SCOTT','FORD') in
select * from myemp where ename in ('JONES','SCOTT','FORD');

/*
    ģ����ѯ: like
        %   ƥ�����ַ�
        _   ƥ�䵥���ַ�
        
        ����������ַ�, ��Ҫʹ��escapeת��
*/
--��ѯԱ�������������ַ���O��Ա����Ϣ
select * from myemp where ename like '__O%';

--��ѯԱ��������,����%��Ա����Ϣ
select * from myemp where ename like '%\%%' escape '\';

/*
       ���� : order by 
          ����: asc    ascend
          ����: desc   descend
          
          ����ע��null���� : nulls first | last
          
          ͬʱ���ж���, �ö��Ÿ���
*/
--��ѯԱ����Ϣ,���ս����ɸߵ�������
select * from myemp order by comm asc;
select * from myemp order by comm desc nulls last ;

--��ѯ���ű�źͰ��չ���  ���ղ�����������, ���ʽ�������
select * from myemp order by deptno asc, sal desc;

/*
     ����: ����Ҫ�з���ֵ
     
     ���к���: ��ĳһ���е�ĳ��ֵ���д���
         ��ֵ����
         �ַ�����
         ���ں���
         ת������
         ͨ�ú���
     
     ���к���: ��ĳһ�е������н��д���
           max()  min count sum avg
           
           1.ֱ�Ӻ��Կ�ֵ 
*/
--ͳ��Ա�������ܺ�
select sum(sal) from myemp;