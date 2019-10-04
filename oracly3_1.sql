--system用户下
/*
     Oracle体系结构:
      数据库 ---> 数据库实例ORCL ---> 表空间 (用户里面的创建表) ---> 数据文件 
      地球   ---> 中国           ---> 省份  (人民)              ---> 土地山川河流
     
     雄安新区 ---> 人(开发荒地,种地)
                
     
     创建表空间: 逻辑单位, 通常我们新建一个项目,就会去新建表空间,在表空间中创建用户来创建表
           语法:
               create tablespace 表空间的名称
               datafile '文件的路径(服务器上)'
               size 大小
               autoextend on  自动扩展
               next 每次扩展的大小
*/
--切换到system帐号下创建
--创建一个表空间 --- 汉东
create tablespace handong
datafile 'D:\mysql_workspace\handong.dbf'
size 100m
autoextend on
next 10m;

/*
   创建用户 
     create user 用户名
     identified by 密码
     default tablespace 表空间的名称
*/
create user c##dakang
identified by c##dakang
default tablespace HANDONG;



--授予 dba的角色
grant dba to c##dakang;