select * from myemp;

select e1.empno,e1.ename,d1.dname,e1.mgr,m1.ename,d2.dname
from myemp e1, myemp m1,mydept d1,mydept d2 
where 
     e1.mgr= m1.empno 
 and e1.deptno = d1.deptno
 and m1.deptno = d2.deptno;
 
 --��ѯԱ�����,Ա������,Ա���Ĳ�������,Ա���Ĺ��ʵȼ�,����ı��,���������,����Ĳ�������
select e1.empno,e1.ename,d1.dname,s1.grade,e1.mgr,m1.ename,d2.dname
from myemp e1, myemp m1,mydept d1,mydept d2,mysalgrade s1 
where 
     e1.mgr= m1.empno 
 and e1.deptno = d1.deptno
 and m1.deptno = d2.deptno
 and e1.sal between s1.losal and s1.hisal;
 
select * from myemp where sal > (select sal from myemp where empno = 7654) and job = (select job from myemp where empno = 7788);
