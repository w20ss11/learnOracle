--system�û���
/*
     Oracle��ϵ�ṹ:
      ���ݿ� ---> ���ݿ�ʵ��ORCL ---> ��ռ� (�û�����Ĵ�����) ---> �����ļ� 
      ����   ---> �й�           ---> ʡ��  (����)              ---> ����ɽ������
     
     �۰����� ---> ��(�����ĵ�,�ֵ�)
                
     
     ������ռ�: �߼���λ, ͨ�������½�һ����Ŀ,�ͻ�ȥ�½���ռ�,�ڱ�ռ��д����û���������
           �﷨:
               create tablespace ��ռ������
               datafile '�ļ���·��(��������)'
               size ��С
               autoextend on  �Զ���չ
               next ÿ����չ�Ĵ�С
*/
--�л���system�ʺ��´���
--����һ����ռ� --- ����
create tablespace handong
datafile 'D:\mysql_workspace\handong.dbf'
size 100m
autoextend on
next 10m;

/*
   �����û� 
     create user �û���
     identified by ����
     default tablespace ��ռ������
*/
create user c##dakang
identified by c##dakang
default tablespace HANDONG;



--���� dba�Ľ�ɫ
grant dba to c##dakang;