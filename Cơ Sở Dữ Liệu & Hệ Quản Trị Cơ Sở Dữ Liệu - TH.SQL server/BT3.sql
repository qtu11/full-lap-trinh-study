create database DLVN1
on (name='DLVN_DATA',filename='D:\BTMONHOC\SQL server\DLVN1.MDF')
log on (name='DLVN_LOG',filename='D:\BTMONHOC\SQL server\DLVN1.LDF')
use DLVN1
create table TINH_TP
(
	MA_T_TP		varchar (3) primary key,
	TEN_T_TP	nvarchar(20),
	DT			float,
	DS			bigint,
	MIEN		nvarchar(10),
)
create table BIENGIOI
(
	NUOC	nvarchar(15),
	MA_T_TP	varchar (3),
	primary key (NUOC,MA_T_TP) ,
	foreign key (MA_T_TP) references TINH_TP(MA_T_TP) on update cascade 
)
create table LANGGIENG
(
	MA_T_TP varchar(3),
	LG		varchar(3),
	primary key(MA_T_TP,LG),
	foreign key (MA_T_TP) references TINH_TP(MA_T_TP) on update cascade ,
	foreign key (LG) references TINH_TP(MA_T_TP) on update no action
)
----- NHẬP DỮ LIỆU
insert TINH_TP values ('AG','An Giang','3406','2142709','Nam'),
insert TINH_TP values('BR',N'Bà Rịa Vũng Tàu','3442','2452709','Nam'),

insert LANGGIENG values('AG','DT')
insert LANGGIENG values('AG','CT')
insert LANGGIENG values('AG','KG')

insert BIENGIOI values ('CPC','AG')
insert BIENGIOI values ('CPC','DL')
insert BIENGIOI values ('CPC','DT')
insert BIENGIOI values ('CPC','GL')

select *
from BIENGIOI

--1.	Xuất ra tên tỉnh, TP cùng với dân số của tỉnh, TP:
--a) Có diện tích >= 5000 Km2
	select *
	from TINH_TP
	where DT >= 5000
--b) Có diện tích >= [input] (SV nhập một số bất kỳ từ bàn phím)
	select *
	from TINH_TP
	where DT >= 8000
--2.	Xuất ra tên tỉnh, TP cùng với diện tích của tỉnh, TP:
--a) Thuộc miền Bắc
	select *
	from TINH_TP
	where MIEN=N'BẮC'
--b) Thuộc miền [input] (SV nhập một miền bất kỳ từ bàn phím)
	select *
	from TINH_TP
	where MIEN=N'NAM'
--3.	Xuất ra các Tên tỉnh, TP biên giới thuộc miền [input] (SV cho một miền bất kỳ)
	select *
	from TINH_TP t, BIENGIOI b
	where t.MA_T_TP = b.MA_T_TP and MIEN=N'TRUNG'
--4.	Cho biết diện tích trung bình của các tỉnh, TP (Tổng DT/Tổng số tỉnh_TP).
	select AVG(DT) As DTTB
	from TINH_TP
--5.	Cho biết dân số cùng với tên tỉnh của các tỉnh, TP có diện tích > 7000 Km2.
	select TEN_T_TP,DS
	from TINH_TP
	where DT > 7000
--6.	Cho biết dân số cùng với tên tỉnh của các tỉnh miền ‘Bắc’.
	select TEN_T_TP,DS
	from TINH_TP
--7.	Cho biết mã các nước là biên giới của các tỉnh miền ‘Nam’.
	select distinct NUOC 
	from BIENGIOI b,TINH_TP t
	where b.MA_T_TP=t.MA_T_TP and MIEN=N'nam'
--8.	Cho biết diện tích trung bình của các tỉnh, TP. (Sử dụng hàm)
	select AVG(DT) as 'Diện tích trung bình'
	from TINH_TP
--9.	Cho biết mật độ dân số (DS/DT) cùng với tên tỉnh, TP của tất cả các tỉnh, TP.
	select DS/DT as 'Mật độ dân số'
	from TINH_TP
--10.	Cho biết tên các tỉnh, TP láng giềng của tỉnh ‘Long An’.
	select TEN_T_TP
	from LANGGIENG l,TINH_TP t
	where l.MA_T_TP = t.MA_T_TP and LG  = N'LA'
--11.	Cho biết số lượng các tỉnh, TP giáp với ‘CPC’.
	select COUNT(MA_T_TP) as 'Tổng số tỉnh'
	from BIENGIOI
	where NUOC = 'CPC'
--12.	Cho biết tên những tỉnh, TP có diện tích lớn nhất.
	select top 1 with ties TEN_T_TP,DT
	from TINH_TP
	order by DT Desc 

--13.	Cho biết tỉnh, TP có mật độ DS đông nhất.
	select top 1 with ties TEN_T_TP
	from TINH_TP
	order by DS/DT desc
--14.	Cho biết tên những tỉnh, TP giáp với hai nước biên giới khác nhau.
	select t.TEN_T_TP, COUNT(NUOC) as SONUOCTIEPGIAP
	from TINH_TP t,BIENGIOI b
	where t.MA_T_TP = b.MA_T_TP
	group by t.TEN_T_TP
	having count(nuoc) = 2
--15.	Cho biết danh sách các miền cùng với các tỉnh, TP trong các miền đó.
	select MIEN, TEN_T_TP
	from TINH_TP
	order by Mien desc
--16.	Cho biết tên những tỉnh, TP có nhiều láng giềng nhất.
	select top 1 with ties t.TEN_T_TP, COUNT(l.MA_T_TP) as SOLANGGIENG
	from TINH_TP t,LANGGIENG l
	where t.MA_T_TP=l.MA_T_TP 
	group by t.TEN_T_TP,l.MA_T_TP
	order by SOLANGGIENG desc

--C2
	--select TEN_T_TP,count(l.lg) as TongLG
	--from TINH_TP t,LANGGIENG l
	--where t.MA_T_TP=l.MA_T_TP
	--group by t.TEN_T_TP
	--having count(l.lg) >= all
	--(
	--	select count(*) as tonglg
	--	from TINH_TP t,LANGGIENG l
	--	where t.MA_T_TP=l.MA_T_TP
	--	group by t.TEN_T_TP
	--)
--17.	Cho biết những tỉnh, TP có diện tích nhỏ hơn diện tích trung bình của tất cả tỉnh, TP.
	select TEN_T_TP,DT
	from TINH_TP
	where DT < (
		select AVG(DT) as 'Diện tích trung bình'
		from TINH_TP
	)
	order by dt asc 
--18.	Cho biết tên những tỉnh, TP giáp với các tỉnh, TP ở miền ‘Nam’ và không phải là miền ‘Nam’.
--C1	
	select t.TEN_T_TP
	from TINH_TP t, LANGGIENG l
	where t.MA_T_TP=l.MA_T_TP and t.MIEN <> N'nam' and l.LG in
	( select l.LG
	  from TINH_TP t,LANGGIENG l
	  where t.MA_T_TP=l.MA_T_TP and t.MIEN =N'nam' 
	)
--C2
--	SELECT T.TEN_T_TP,LG,MIEN
--FROM TINH_TP T,LANGGIENG G
--WHERE T.MA_T_TP=G.MA_T_TP AND MIEN <> 'NAM' AND G.LG IN
--(SELECT MA_T_TP FROM TINH_TP WHERE MIEN='NAM')
--19.	Cho biết tên những tỉnh, TP có diện tích lớn hơn tất cả các tỉnh, TP láng giềng của nó.
	select a.TEN_T_TP,a.DT
	from TINH_TP a
	where a.DT >=all
	( select b.DT
	from TINH_TP b,LANGGIENG l
	where b.MA_T_TP=l.LG and l.MA_T_TP=a.MA_T_TP )
	order by a.DT desc
	
	--select TEN_T_TP,DT
	--from TINH_TP
	--order by dt asc

--20.	Cho biết tên những tỉnh, TP mà ta có thể đến bằng cách đi từ
--‘TP.HCM’ xuyên qua ba tỉnh 
--khác nhau và cũng khác với điểm xuất phát, nhưng láng giềng với nhau.
select t.TEN_T_TP,l1.LG,l2.LG,l3.LG
from TINH_TP t,LANGGIENG l1, LANGGIENG l2,LANGGIENG l3
where  t.MA_T_TP = l1.MA_T_TP and l1.LG=l2.MA_T_TP and
	l2.LG=l3.MA_T_TP and t.MA_T_TP='HCM' and l2.LG <> 'HCM'
	and l3.LG <> 'HCM' and l1.LG <> l3.LG




