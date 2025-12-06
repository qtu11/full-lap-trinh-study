-- Bài 5
create database QLDA 
 on ( name='QLDA_DATA',filename='D:\BTMONHOC\SQL server\QLDA.MDF' )
log on ( name='QLDA_LOG',filename='D:\BTMONHOC\SQL server\QLDA.LDF')

use QLDA

create table NCC
(	
	MANCC	char(5) primary key,
	TEN		nvarchar(40),
	HESO	int,
	THPHO	nvarchar(20)
)
create table VATTU
(
	MAVT	char(5) primary key,
	TEN		nvarchar(40),
	MAU		nvarchar(15),
	TRLUONG float,
	THPHO	nvarchar(20)
)
create table DUAN
(
	MADA	char(5) primary key,
	TEN 	nvarchar(40),
	THPHO	nvarchar(20)
)
create table CC
(
	MANCC	char(5) FOREIGN KEY REFERENCES NCC(MANCC) ON UPDATE CASCADE,
	MAVT	char(5) FOREIGN KEY REFERENCES VATTU(MAVT) ON UPDATE CASCADE,
	MADA	char(5) FOREIGN KEY REFERENCES DUAN(MADA) ON UPDATE CASCADE,
	SLUONG	int,
	PRIMARY KEY(MANCC,MAVT,MADA)
)

-- NHẬP DỮ LIỆU VÀO 4 BẢNG
-- ....
-- ....
-- KIỂM TRA
	select *
	from NCC
	select *
	from DUAN
	select *
	from VATTU
	select *
	from CC
-- BÀI TẬP
--1)	Cho biết quy cách màu và thành phố của các vật tư không
--được trữ tại Hà Nội có trọng lượng lớn hơn 10.
	select MAU,THPHO
	from VATTU 
	where THPHO not like N'Hà Nội' and TRLUONG > 10
	group by MAU,THPHO
--2)	Cho biết thông tin chi tiết của tất cả các dự án.
	select d.MADA,d.TEN as [Tên dự án],d.THPHO,v.TEN as [Tên vật tư],c.SLUONG,n.TEN as [Nhà cung cấp]
	from DUAN d inner join CC c 
	on d.MADA=c.MADA inner join VATTU v
					 on c.MAVT=v.MAVT inner join NCC n
									  on c.MANCC=n.MANCC
	group by d.MADA,d.TEN,d.THPHO,v.TEN,c.SLUONG,n.TEN
--3)	Cho biết thông tin chi tiết của tất cả các dự án ở 
--TP.HCM.
	select d.MADA,d.TEN as [Tên dự án],d.THPHO,v.TEN as [Tên vật tư],c.SLUONG,n.TEN as [Nhà cung cấp]
	from DUAN d inner join CC c 
	on d.MADA=c.MADA and d.THPHO like N'TP.HCM' inner join VATTU v
												on c.MAVT=v.MAVT inner join NCC n
																 on c.MANCC=n.MANCC
	group by d.MADA,d.TEN,d.THPHO,v.TEN,c.SLUONG,n.TEN
--4)	Cho biết tên nhà cung cấp cung cấp vật tư cho dự án J1.
	select n.TEN as [Nhà cung cấp]
	from CC c inner join NCC n on c.MANCC=n.MANCC and c.MADA like 'J1'
--5)	Cho biết tên nhà cung cấp, tên vật tư và tên dự án
--mà số lượng vật tư được cung cấp cho dự án bởi nhà cung cấp 
--lớn hơn 300 và nhỏ hơn 750.
	select n.TEN as [Nhà cung cấp],v.TEN as [Tên vật tư],d.TEN as [Tên dự án]
	from DUAN d inner join CC c on c.MADA=d.MADA 
			    inner join NCC n on n.MANCC=c.MANCC 
				inner join VATTU v on v.MAVT=c.MAVT and c.SLUONG between 300 and 750
--6)	Cho biết thông tin chi tiết của các vật tư được 
--cung cấp bởi các nhà cung cấp ở TP.HCM.
	select v.MAVT,v.TEN as [Tên vật tư],n.TEN as [Nhà cung cấp],v.MAU,v.TRLUONG,v.THPHO
	from CC c inner join NCC n on c.MANCC=n.MANCC and n.THPHO like N'TP.HCM'
			  inner join VATTU v on c.MAVT=v.MAVT
	group by v.MAVT,v.TEN,n.TEN,v.MAU,v.TRLUONG,v.THPHO
--7)	Cho biết mã số các vật tư được cung cấp cho các dự án
--tại TP.HCM bởi các nhà cung cấp ở TP.HCM.
	--DUAN	J5,J7
	--NCC	S1,S4

	select v.MAVT
	from CC c inner join DUAN d on c.MADA=d.MADA and d.THPHO like N'TP.HCM'
			  inner join NCC n on c.MANCC=n.MANCC and n.THPHO like N'TP.HCM'
			  inner join VATTU v on c.MAVT=v.MAVT
	group by v.MAVT
--8)	Liệt kê các cặp tên thành phố mà nhà cung cấp ở thành phố thứ 
--nhất cung cấp vật tư được trữ tại thành phố thứ hai.

	select n.THPHO+'-'+v.THPHO as [Cặp thành phố]
	from CC c inner join NCC n on c.MANCC=n.MANCC 
			  inner join VATTU v on c.MAVT=v.MAVT and n.THPHO <> v.THPHO
	group by n.THPHO+'-'+v.THPHO
--9)	Liệt kê các cặp tên thành phố mà nhà cung cấp
--ở thành phố thứ nhất cung cấp vật tư cho dự án 
--tại thành phố thứ hai.
	select N.THPHO+'-'+d.THPHO as [Cặp thành phố]
	from CC c inner join NCC n on c.MANCC=n.MANCC 
			  inner join DUAN d on c.MADA=d.MADA and n.THPHO <> d.THPHO
	group by N.THPHO+'-'+d.THPHO
--10)	Liệt kê các cặp mã số nhà cung cấp ở cùng một thành phố.
	select n1.MANCC+'-   '+n2.MANCC as [NCC cùng thành phố]
	from NCC n1 inner join NCC n2 on n1.MANCC<n2.MANCC and n1.THPHO=n2.THPHO 
	group by n1.MANCC+'-   '+n2.MANCC
--11)	Cho biết mã số và tên các vật tư được cung cấp cho dự án cùng thành phố 
--với nhà cung cấp.
	select v.MAVT,v.TEN as [Tên vật tư],d.THPHO as [Thành phố]
	from CC c inner join DUAN d on c.MADA=d.MADA 
			  inner join NCC n on c.MANCC=n.MANCC and d.THPHO=n.THPHO
			  inner join VATTU v on c.MAVT=v.MAVT
	group by v.MAVT,v.TEN,d.THPHO
--12)	Cho biết mã số và tên các dự án được cung cấp vật tư bởi ít nhất
--một nhà cung cấp không cùng thành phố.

	select d.MADA,d.TEN as [Tên dự án]
	from CC c inner join DUAN d on c.MADA=d.MADA 
			  inner join NCC n on c.MANCC=n.MANCC and d.THPHO not like n.THPHO
			  inner join VATTU v on c.MAVT=v.MAVT
	group by d.MADA,d.TEN
	having count(*)>=1
--13)	Cho biết mã số nhà cung cấp và cặp mã số vật tư được cung cấp bởi nhà cung cấp này.
	select v.MANCC,v.MAVT+'-'+v1.MAVT
	from (select n.MANCC,v.MAVT
		  from CC c inner join DUAN d on c.MADA=d.MADA 
					inner join NCC n on c.MANCC=n.MANCC 
					inner join VATTU v on c.MAVT=v.MAVT
		  group by n.MANCC,v.MAVT) as v,
		 (select n.MANCC,v.MAVT
		  from CC c inner join DUAN d on c.MADA=d.MADA 
					inner join NCC n on c.MANCC=n.MANCC 
					inner join VATTU v on c.MAVT=v.MAVT
		  group by n.MANCC,v.MAVT) as v1
	where v.MANCC=v1.MANCC and v.MAVT<v1.MAVT
	group by v.MANCC,v.MAVT+'-'+v1.MAVT
--14)	Cho biết mã số các vật tư được cung cấp bởi nhiều hơn một nhà cung cấp.
	select v.MAVT,count(n.MANCC) as SNCC
	from (select MANCC,MAVT
		  from CC 
		  group by MANCC,MAVT) as c 
		  inner join NCC n on c.MANCC=n.MANCC 
		  inner join VATTU v on c.MAVT=v.MAVT
	group by v.MAVT
	having count(n.MANCC)>1
--15)	Với mỗi vật tư cho biết mã số và tổng số lượng được cung cấp cho các dự án.
	select v.MAVT,sum(c.SLUONG) as [Tổng số lượng]
	from CC c inner join VATTU v on c.MAVT=v.MAVT
	group by v.MAVT
--16)	Cho biết tổng số các dự án được cung cấp vật tư bởi nhà cung cấp S1.
	select count(c.MADA) as [Số các dự án được cung cấp vật tư bởi nhà cung cấp S1]
	from (select MANCC,MADA
		  from CC 
		  group by MANCC,MADA) as c
	where c.MANCC='S1' 
--17)	Cho biết tổng số lượng vật tư P1 được cung bởi nhà cung cấp S1.
	select sum(SLUONG) as [Tổng số lượng vật tư P1->S1]
	from CC 
	where MAVT='P1' and MANCC='S1'
--18)	Với mỗi vật tư được cung cấp cho một dự án, cho biết mã số, tên vật tư, tên dự án và tổng số lượng vật tư tương ứng.
	select v.MAVT,v.TEN as [Tên vật tư],d.TEN as [Tên dự án],sum(c.SLUONG) as [Tổng số lượng]
	from CC c inner join DUAN d on c.MADA=d.MADA
			  inner join VATTU v on c.MAVT=v.MAVT
	group by v.MAVT,v.TEN,d.TEN
--19)	Cho biết mã số, tên các vật tư và tên dự án có số lượng vật tư trung bình cung cấp cho dự án lớn hơn 350.
	select v.MAVT,v.TEN as [Tên vật tư],d.TEN as [Tên dự án]
	from CC c inner join DUAN d on c.MADA=d.MADA
			  inner join VATTU v on c.MAVT=v.MAVT
	group by v.MAVT,v.TEN,d.TEN
	having avg(c.SLUONG)>350
--20)	Cho biết tên các dự án được cung cấp vật tư bởi nhà cung cấp S1.
	select d.TEN as [Tên dự án]
	from CC c inner join DUAN d on c.MADA=d.MADA and c.MANCC='S1'
--21)	Cho biết quy cách màu của các vật tư được cung cấp bởi nhà cung cấp S1.
	select v.MAU 
	from CC c inner join VATTU v on c.MAVT=v.MAVT and c.MANCC='S1'
	group by v.MAU
--22)	Cho biết mã số và tên các vật tư được cung cấp cho một dự án bất kỳ ở TP.HCM.
	select v.MAVT,v.TEN as [Tên vật tư]
	from CC c inner join VATTU v on c.MAVT=v.MAVT
			  inner join DUAN d on c.MADA=d.MADA and d.THPHO=N'TP.HCM'
	group by v.MAVT,v.TEN 
--23)	Cho biết mã số và tên các dự án sử dụng vật tư có thể được cung cấp bởi nhà cung cấp S1.
	select d.MADA,d.TEN as [Tên dự án]
	from DUAN d,CC c
	where  c.MADA=d.MADA and c.MAVT in (
		select c1.MAVT
		from CC c1
		where c1.MANCC='S4')
	group by d.MADA,d.TEN
--24)	Cho biết mã số và tên nhà cung cấp có cung cấp vật tư có quy cách màu đỏ.
	select n.MANCC,n.TEN as [Nhà cung cấp]
	from CC c inner join NCC n on c.MANCC=n.MANCC
			  inner join VATTU v on c.MAVT=v.MAVT and v.MAU=N'Đỏ'
	group by n.MANCC,n.TEN
--25)	Cho biết tên các nhà cung cấp có chỉ số xếp hạng nhỏ hơn chỉ số lớn nhất.
	select TEN as [Nhà cung cấp]
	from NCC 
	where HESO < (select max(HESO)
				  from NCC)
	group by TEN
--26)	Cho biết tên các nhà cung cấp không cung cấp vật tư P2.
	select TEN as [Nhà cung cấp]
	from NCC n  
	where MANCC not in (select MANCC
						from CC 
						where MAVT='P2')
	group by TEN
--27)	Cho biết mã số và tên các nhà cung cấp đang cung cấp vật tư được 
--cung cấp bởi nhà cung cấp có cung cấp vật tư với quy cách màu đỏ.
	EM KHÔNG THỂ HIỂU CÂU HỎI NÊN EM XIN BỎ QUA 
--28)	Cho biết mã số và tên các nhà cung cấp có chỉ số xếp hạng cao hơn nhà cung cấp S1.
	select MANCC,TEN as [Nhà cung cấp]
	from NCC 
	where HESO > (select HESO 
				  from NCC 
				  where MANCC='S1')
	group by MANCC,TEN
--29)	Cho biết mã số và tên các dự án được cung cấp vật tư P1 với số lượng 
--vật tư trung bình lớn hơn tất cả các số lượng vật tư được cung cấp cho dự án J1.
	select d.MADA,d.TEN as [Tên dự án] 
	from CC c inner join DUAN d on c.MADA=d.MADA 
	where c.MAVT='P1' and  (select avg(c1.SLUONG)
							from CC c1
							where c.MADA=c1.MADA) > (select max(SLUONG)
													 from CC
													 where MADA='J1')
	group by d.MADA,d.TEN
--30)	Cho biết mã số và tên các nhà cung cấp cung cấp vật tư P1 cho một
--dự án nào đó với số lượng lớn hơn số lượng trung bình của vật tư P1 được 
--cung cấp cho dự án đó.	
	EM KHÔNG THỂ HIỂU CÂU HỎI NÊN EM XIN BỎ QUA 
--31)	Cho biết mã số và tên các dự án không được cung cấp vật 
--tư nào có quy cách màu đỏ bởi một nhà cung cấp bất kỳ ở TP.HCM.
	select d.MADA,d.TEN as [Tên dự án] 
	from CC c inner join DUAN d on d.MADA=c.MADA and
		c.MADA not in (select d1.MADA 
					from DUAN d1 inner join CC c1 on d1.MADA=c1.MADA
								 inner join NCC n1 on c1.MANCC=n1.MANCC and n1.THPHO=N'TP.HCM'
								 inner join VATTU v1 on c1.MAVT=v1.MAVT and v1.MAU=N'Đỏ'
					group by d1.MADA)
	group by d.MADA,d.TEN				
--32)	Cho biết mã số và tên các dự án được cung cấp toàn bộ vật tư bởi nhà cung cấp S1.
	select MADA,TEN as [Tên dự án]
	from DUAN 
	where MADA not in (select MADA
				   from CC 
				   where MANCC<>'S1')
--33)	Cho biết tên các nhà cung cấp cung cấp tất cả các vật tư.
	--select distinct  MANCC,MAVT
	--from cc group by MANCC,MAVT

	select  n.TEN as [Tên nhà cung cấp]
	from NCC n ,(select distinct  MANCC,MAVT
		from cc group by MANCC,MAVT) as B
	where b.MANCC=n.MANCC
	group by n.TEN
	having count(B.MANCC) = (select count(v.MAVT) from VATTU v)
--34)	Cho biết mã số và tên các vật tư được cung cấp cho tất cả các dự án tại TP.HCM.
	select MAVT,TEN as [Tên vật tư]
	from VATTU v 
	where MAVT in(select c.MAVT
				  from CC c inner join DUAN d on c.MADA=d.MADA and d.THPHO=N'TP.HCM'
				  group by c.MAVT
				  having count(*)=(select count(*) from DUAN where THPHO=N'TP.HCM'))
	group by MAVT,TEN
--35)	Cho biết mã số và tên các nhà cung cấp cung cấp cùng một vật tư 
--cho tất cả các dự án.
	--select distinct MAVT,MADA from CC
	--group by MAVT ,MADA

	select  n.TEN as [Tên nhà cung cấp]
	from NCC n ,CC c
	where c.MANCC=n.MANCC and c.MAVT in 
				( select distinct  c.MAVT
				from CC c,(select distinct MAVT,MADA from CC
							group by MAVT ,MADA) as B
				where c.MAVT=b.MAVT 
				group by c.MAVT,c.MADA
				having count(b.MAVT)=(select count(d.MADA) from DUAN d))
	group by n.TEN
--36)	Cho biết mã số và tên các dự án được cung cấp tất cả các vật tư có
--thể được cung cấp bởi nhà cung cấp S1.
	select MADA,TEN as [Tên dự án]
	from DUAN 
	where MADA in (select c.MADA
				   from	CC c,(select MAVT
							  from CC where MANCC='S1'
							  group by MAVT) as c1
				   where c.MADA not in (select MADA
									from CC
									where MAVT<>c1.MAVT))
--37)	Cho biết tất cả các thành phố mà nơi đó có ít nhất một nhà cung
--cấp, trữ ít nhất một vật tư hoặc có ít nhất một dự án.
	-- NCC vs VT có HCM,HN
	-- or
	-- NCC vs DUAN có HCM,HN,DN

	select n.THPHO
	from VATTU v ,NCC n,DUAN d
	where v.THPHO=n.THPHO or d.THPHO=n.THPHO
	group by n.THPHO
--38)	Cho biết mã số các vật tư hoặc được cung cấp bởi một nhà 
--cung cấp ở TP.HCM hoặc cung cấp cho một dự án tại TP.HCM.
	-- J5,J7 : P5,P3,P6
	-- S1,S4 : P1,P6

	select c.MAVT 
	from NCC n,DUAN d, CC c
	where (c.MANCC=n.MANCC and n.THPHO=N'TP.HCM') or (c.MADA=d.MADA and d.THPHO=N'TP.HCM')
	group by c.MAVT
--39)	Liệt kê các cặp (mã số nhà cung cấp, mã số vật tư) mà nhà
--		cung cấp không cấp vật tư.
	--select c.MANCC +'-   '+c.MAVT as CapCungCap
	--from CC c,CC c1
	--where c.MANCC=c1.MANCC 
	--group by c.MANCC+'-   '+c.MAVT

	--select n.MANCC +'-   '+v.MAVT as TongCAP
	--from NCC n,VATTU v

	select A.[MANCC & MAVT ]
	from (select n.MANCC +'-   '+v.MAVT as [MANCC & MAVT ]
		from NCC n,VATTU v) as A
	where  A.[MANCC & MAVT ] not in (select c.MANCC +'-   '+c.MAVT 
		as [MANCC & MAVT ] from CC c,CC c1 where c.MANCC=c1.MANCC
		group by c.MANCC+'-   '+c.MAVT)
	group by A.[MANCC & MAVT ]
--40)	Liệt kê các cặp mã số nhà cung cấp có thể cung cấp cùng tất cả các loại vật tư.
	select  c.MANCC+'-   '+c1.MANCC as [ MANCC & MANCC ]
	from CC c,CC c1,( select  b.MANCC
				from (select distinct  MANCC,MAVT
				from cc group by MANCC,MAVT) as B
				group by b.MANCC
				having count(B.MANCC) = (select count(v.MAVT) from VATTU v)) as c2
	where c.MANCC in ( select  b.MANCC
				from (select distinct  MANCC,MAVT
				from cc group by MANCC,MAVT) as B
				group by b.MANCC
				having count(B.MANCC) = (select count(v.MAVT) from VATTU v))
				and c1.MANCC <> c2.MANCC
	group by c.MANCC,c1.MANCC
--41)	Cho biết tên các thành phố trữ nhiều hơn 5 vật tư có quy cách 
--màu đỏ.
	select v.THPHO
	from CC c inner join VATTU v on c.MAVT=v.MAVT and v.MAU=N'Đỏ'
	group by v.THPHO
	having count(v.mau)=5























