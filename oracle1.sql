/*虚表伪表的概念*/
select * from help;
--select 1+1; 该语句在mysql不会报错，oracle会报错
select 1+1 from dual; --dual 是oracle中的虚表/伪表，主要是用来补齐语法结构的
select * from dual;

/*别名查询： 使用as关键字 可以省略 
别名查询不能有特殊字符或者关键字，如有需要加双引号*/
--drop table MYBONUS;
--drop table MYDEPT;
--drop table MYEMP;
--drop table MYSALGRADE;
--select * from MYEMP;
select ename 姓名, sal 工资 from MYEMP;
select ename "姓    名", sal 工资 from MYEMP;

/*去除重复数据 distinct*/
--单列去除重复
select distinct job from myemp;
--多列去除重复 每一列都是重复的才能去除
select distinct job,deptno from myemp;

--查询中的四则运算
select 1+1 from dual;
--查询员工年薪 员工表emp sal为月薪
select sal*12 from myemp;
--查询员工年薪+奖金 comm为奖金
select sal*12 + comm from myemp;
select sal*12 + nvl(comm,0) from myemp;--注意：null值，代表不确定的值，不可以做四则运算
--nvl函数：如果参数1位null 就返回参数2

/*字符串拼接
java：+号拼接 oracle：||拼接*/
--查询员工姓名 :  姓名:SCOTT
select '姓名：' || ename from myemp;
--使用函数拼接
select concat('姓  名：',ename) from myemp;

/*
    条件查询 : [where后面的写法]   
        关系运算符: > >= = < <= != <>
        逻辑运算符: and or not
        其它运算符:
               like 模糊查询
               in(set) 在某个集合内
               between..and.. 在某个区间内
               is null  判断为空
               is not null 判断不为空
*/
--查询每月能得到奖金的员工信息
select * from myemp where comm is not null;
--查询工资在1500--3000之间的员工信息
select * from myemp where sal between 1500 and 3000;
select * from myemp where sal >= 1500 and sal <= 3000;

--查询名字在某个范围的员工信息 ('JONES','SCOTT','FORD') in
select * from myemp where ename in ('JONES','SCOTT','FORD');

/*
    模糊查询: like
        %   匹配多个字符
        _   匹配单个字符
        
        如果有特殊字符, 需要使用escape转义
*/
--查询员工姓名第三个字符是O的员工信息
select * from myemp where ename like '__O%';

--查询员工姓名中,包含%的员工信息
select * from myemp where ename like '%\%%' escape '\';

/*
       排序 : order by 
          升序: asc    ascend
          降序: desc   descend
          
          排序注意null问题 : nulls first | last
          
          同时排列多列, 用逗号隔开
*/
--查询员工信息,按照奖金由高到低排序
select * from myemp order by comm asc;
select * from myemp order by comm desc nulls last ;

--查询部门编号和按照工资  按照部门升序排序, 工资降序排序
select * from myemp order by deptno asc, sal desc;

/*
     函数: 必须要有返回值
     
     单行函数: 对某一行中的某个值进行处理
         数值函数
         字符函数
         日期函数
         转换函数
         通用函数
     
     多行函数: 对某一列的所有行进行处理
           max()  min count sum avg
           
           1.直接忽略空值 
*/
--统计员工工资总和
select sum(sal) from myemp;