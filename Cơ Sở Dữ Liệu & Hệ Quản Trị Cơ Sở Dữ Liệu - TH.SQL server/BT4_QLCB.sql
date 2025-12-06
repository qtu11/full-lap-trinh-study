-- Bài 4
create database QLCB 
 on ( name='QLCB_DATA',filename='D:\BTMONHOC\SQL server\QLCB.MDF' )
log on ( name='QLCB_LOG',filename='D:\BTMONHOC\SQL server\QLCB.LDF')

use QLCB

create table MAYBAY
(
	MAMB	int primary key,
	LOAI	varchar(50),
	TAMBAY	int
)
create table NHANVIEN
(
	MANV	char(9) primary key,
	TEN		nvarchar(50),
	LUONG	int
)
create table CHUNGNHAN
(
	MANV	char(9) foreign key references NHANVIEN(MANV) on update cascade,
	MAMB	int foreign key references MAYBAY(MAMB) on update cascade
)
create table CHUYENBAY
(
	MACB	char(5) primary key,
	GADI	varchar(50),
	GADEN	varchar(50),
	DODAI	int,
	GIODI	time,
	GIODEN	time,
	CHIPHI	int,
	MAMB	int foreign key references MAYBAY(MAMB) on update cascade
)

--// Nhập dữ liệu = tay mỗi bảng 1 cái
insert into MAYBAY values('747','Boeing 747 - 400','13488')
insert into NHANVIEN values ('242518965',N'Trần Văn Sơn','120433')
insert into CHUNGNHAN values ('567354612','747')
insert into CHUYENBAY values ('VN651','DAD','SGN','2798','19:30','08:00','221','727')

--1)	Cho biết các chuyến bay đi Đà Lạt (DAD).
	select *
	from CHUYENBAY
	where GADEN = 'DAD'
--2)	Cho biết các loại máy bay có tầm bay lớn hơn 10,000km.
	select LOAI,TAMBAY
	from MAYBAY
	where TAMBAY > '10000'
--3)	Tìm các nhân viên có lương nhỏ hơn 10,000.
	select *
	from NHANVIEN
	where LUONG < '10000'
--4)	Cho biết các chuyến bay có độ dài đường bay nhỏ hơn 10.000km và lớn hơn 8.000km.
	select *
	from CHUYENBAY
	where DODAI between 8000 and 10000
--5)	Cho biết các chuyến bay xuất phát từ Sài Gòn (SGN) đi Ban Mê Thuộc (BMV).
	select *
	from CHUYENBAY
	where GADI = 'SGN' and GADEN = 'BMV'
--6)	Có bao nhiêu chuyến bay xuất phát từ Sài Gòn (SGN).
	select count(*) as [Số Chuyến Bay]
	from CHUYENBAY
	where GADI='SGN'
--7)	Có bao nhiêu loại máy báy Boeing.
	select count(*) as [Số loại máy bay boeing]
	from MAYBAY
	where LOAI like '%Boeing%'
--8)	Cho biết tổng số lương phải trả cho các nhân viên.
	select sum(Luong) as TongLuong
	from NHANVIEN
--9)	Cho biết mã số của các phi công lái máy báy Boeing.
	select c.MANV
	from MAYBAY m,CHUNGNHAN c
	where m.MAMB=c.MAMB and m.LOAI like '%Boeing%' 
--	group by c.MANV
--10)	Cho biết các nhân viên có thể lái máy bay có mã số 747.
	select n.TEN
	from NHANVIEN n,CHUNGNHAN c
	where n.MANV=c.MANV and c.MAMB = '747'
--11)	Cho biết mã số của các loại máy bay mà nhân viên có họ Nguyễn có thể lái.
	select c.MAMB
	from NHANVIEN n,CHUNGNHAN c
	where n.MANV=c.MANV and n.TEN like N'Nguyễn%'
--	group by c.MAMB

	select *
	from NHANVIEN
--12)	Cho biết mã số của các phi công vừa lái được Boeing vừa lái được Airbus.
	select c.MANV
	from MAYBAY m,CHUNGNHAN c
	where m.MAMB=c.MAMB and m.LOAI like '%boeing%' and c.MANV in 
		( select c1.MANV
		from MAYBAY m1,CHUNGNHAN c1
		where m1.MAMB=c1.MAMB and m1.LOAI like '%Airbus%'
		group by c1.MANV )
	group by c.MANV
--13)	Cho biết các loại máy bay có thể thực hiện chuyến bay VN280.
	select m.LOAI
	from CHUYENBAY c,MAYBAY m
	where   c.MACB='VN280' and m.TAMBAY > c.DODAI
--14)	Cho biết các chuyến bay có thể được thực hiện bởi máy bay Airbus A320.
	select c.MACB
	from CHUYENBAY c,MAYBAY m
	where m.TAMBAY > c.DODAI and c.DODAI < m.TAMBAY and m.LOAI = 'Airbus A320'

	--C2
	select *
	from CHUYENBAY c
	where c.DODAI < ( select TAMBAY
					from MAYBAY 
					where LOAI='Airbus A320')
--15)	Cho biết tên của các phi công lái máy bay Boeing.
	select n.TEN
	from MAYBAY m,NHANVIEN n,CHUNGNHAN c
	where m.MAMB=c.MAMB and c.MANV=n.MANV and m.LOAI like '%boeing%'
	group by n.ten
--16)	Với mỗi loại máy bay có phi công lái cho biết mã số, loại máy báy và tổng số phi 
--công có thể lái loại máy bay đó.
	select m.MAMB,m.LOAI,count(*) as [Tổng số Phi Công có thể lái]
	from MAYBAY m,CHUNGNHAN c
	where m.MAMB=c.MAMB 
	group by m.MAMB,m.LOAI
--17)	Giả sử một hành khách muốn đi thẳng từ ga A đến ga B rồi quay
--trở về ga A. Cho biết các đường bay nào có thể đáp ứng yêu cầu này.
	select c2.MACB as DI ,c1.MACB as VE
	from CHUYENBAY c1,CHUYENBAY c2
	where c1.GADI=c2.GADEN and c1.GADEN=c2.GADI
--Gom nhóm:
--18)	Với mỗi ga có chuyến bay xuất phát từ đó cho biết có bao nhiêu
--chuyến bay khởi hành từ ga đó.
	select Gadi, count(*) as [Số chuyến bay khởi hành]
	from CHUYENBAY
	group  by GADI
--19)	Với mỗi ga có chuyến bay xuất phát từ đó cho biết tổng chi phí 
--phải trả cho phi công lái các chuyến bay khởi hành từ ga đó.
	select Gadi, count(*) as [Số chuyến bay khởi hành],sum(chiphi) as TongTien
	from CHUYENBAY
	group  by GADI
--20)	Với mỗi địa điểm xuất phát cho biết có bao nhiêu chuyến bay có 
--thể khởi hành trước 12:00.
	select Gadi, count(*) as [Số chuyến bay khởi hành trước 12h]
	from CHUYENBAY
	where GIODI < '12:00'
	group  by GADI
--21)	Cho biết mã số của các phi công chỉ lái được 3 loại máy bay.
	select MANV
	from CHUNGNHAN
	group by MANV
	having count(MAMB) = 3
--22)	Với mỗi phi công có thể lái nhiều hơn 3 loại máy bay, cho biết
--mã số phi công và tầm bay lớn nhất của các loại máy bay mà phi công đó có thể lái.
	select c.MANV,max(m.TAMBAY) as TAMBAYMAX
	from CHUNGNHAN c,MAYBAY m
	where c.MAMB=m.MAMB 
	group by c.MANV
	having count(c.MAMB) > 3 
	-- 747
--23)	Với mỗi phi công cho biết mã số phi công và tổng số loại máy bay
--mà phi công đó có thể lái.
	select n.MANV,count(c.MAMB) as [Số máy bay có thể lái]
	from NHANVIEN n,CHUNGNHAN c
	where n.MANV=c.MANV 
	group by n.MANV
--24)	Cho biết mã số của các phi công có thể lái được nhiều loại máy
--bay nhất.
	select top 1 with ties n.MANV,count(c.MAMB) as [Số máy bay có thể lái]
	from NHANVIEN n,CHUNGNHAN c
	where n.MANV=c.MANV 
	group by n.MANV
	order by [Số máy bay có thể lái] desc
--25)	Cho biết mã số của các phi công có thể lái được ít loại máy bay 
--nhất.
	select top 1 with ties n.MANV,count(c.MAMB) as [Số máy bay có thể lái]
	from NHANVIEN n,CHUNGNHAN c
	where n.MANV=c.MANV 
	group by n.MANV
	order by [Số máy bay có thể lái] asc

--Truy vấn lồng:
--26)	Tìm các nhân viên không phải là phi công.
	-- Tổng nhân viên
	select count(*)
	from nhanvien
	-- Tổng phi công
	select  count(*)
	from CHUNGNHAN
	group by MANV
--=> Nhân viên không là phi công
	select m.TEN as [NV không phải phi công]
	from NHANVIEN m
	where m.MANV not in 
		( select c1.MANV
		from CHUNGNHAN c1
		group by c1.MANV )
--27)	Cho biết mã số của các nhân viên có lương cao nhất.
	select top 1 with ties MANV
	from NHANVIEN
	order by luong desc
--28)	Cho biết tổng số lương phải trả cho các phi công.
	select sum(n.luong) as [Tổng lương phi công]
	from NHANVIEN n
	where  n.MANV in (
					select CHUNGNHAN.MANV
					from CHUNGNHAN )
--29)	Tìm các chuyến bay có thể được thực hiện bởi tất 
--cả các loại máy bay Boeing.
	select c.MACB
	from CHUYENBAY c
	where c.DODAI < all (
					select m1.TAMBAY
					from MAYBAY m1 )
		and c.MAMB in (
					select m1.MAMB
					from MAYBAY m1
					where m1.LOAI like '%boeing%')
	group by c.MACB
	
	select distinct *
	from CHUYENBAY c
	where c.MACB in ( select macb from MAYBAY where LOAI like 'Boeing%')
--30)	Cho biết mã số của các máy bay có thể được sử dụng
--để thực hiện chuyến bay từ Sài Gòn (SGN) đến Huế (HUI).
	select m.MAMB
	from MAYBAY m
	where m.TAMBAY >  (
					select c.DODAI
					from CHUYENBAY c 
					where c.GADI = 'SGN' and c.GADEN= 'HUI')
--31)	Tìm các chuyến bay có thể được lái bởi các phi công
--có lương lớn hơn 100,000.
	select c.MACB
	from CHUYENBAY c,CHUNGNHAN c1
	where c.MAMB=c1.MAMB and c1.MANV in (
				select NHANVIEN.MANV
				from NHANVIEN
				where nhanvien.LUONG > 100000)
	group by c.MACB
--32)	Cho biết tên các phi công có lương nhỏ hơn chi phí thấp
--nhất của đường bay từ Sài Gòn (SGN) đến Buôn Mê Thuộc (BMV).
	select n.TEN
	from NHANVIEN n,CHUNGNHAN c
	where c.MANV=n.MANV and n.LUONG < (
				select top 1 with ties CHUYENBAY.CHIPHI
				from CHUYENBAY
				where CHUYENBAY.GADEN = 'BMV' and CHUYENBAY.GADI= 'SGN'
				order by CHUYENBAY.CHIPHI asc)
--33)	Cho biết mã số của các phi công có lương cao nhất.
	select top 1 with ties NHANVIEN.MANV
	from NHANVIEN 
	where NHANVIEN.MANV in (
				select CHUNGNHAN.MANV
				from CHUNGNHAN)
	order by NHANVIEN.LUONG desc
--34)	Cho biết mã số của các nhân viên có lương cao thứ nhì.
	select top 1 with ties n1.MANV
	from  NHANVIEN n1
	where n1.MANV not in (
				select top 1 with ties n.MANV
				from NHANVIEN n 
				order by n.LUONG desc)
	order by n1.LUONG desc
--35)	Cho biết mã số của các nhân viên có lương cao thứ nhất
--hoặc thứ nhì.
	select top 2 with ties n.MANV ,n.LUONG
	from NHANVIEN n
	order by n.LUONG desc

	select   manv
	from NHANVIEN
	where LUONG=(select max(n1.Luong) from NHANVIEN n1) 
		or luong in
			(select top 1 with ties n2.luong from NHANVIEN n2 
			where n2.LUONG not in
				( select max(n3.luong) 
				from NHANVIEN n3)
				order by n2.LUONG desc)
--	order by LUONG 
--36)	Cho biết tên và lương của các nhân viên không phải 
--là phi công và có lương lớn hơn lương trung bình của tất 
--cả các phi công.
	select n.TEN,n.LUONG
	from NHANVIEN n
	where    n.LUONG >= all
			 ( select AVG(luong) from NHANVIEN where MANV in
					(select MANV from CHUNGNHAN))
			and MANV not in (select manv from CHUNGNHAN)


	--select n1.TEN ,n1.LUONG
	-- from CHUNGNHAN c1,NHANVIEN n1
	-- where c1.MANV=n1.MANV 
	-- group by n1.ten,n1.LUONG

	--select TEN,LUONG
	--from NHANVIEN
	--where MANV not in (
	--		select c1.MANV
	-- from CHUNGNHAN c1,NHANVIEN n1
	-- where c1.MANV=n1.MANV 
	-- group by c1.MANV)

	-- select n.TEN
	--from NHANVIEN n,CHUNGNHAN c,MAYBAY m
	--where n.MANV=c.MANV and m.MAMB=c.MAMB
	--and c.MANV in ( select c1.MANV
	--				from CHUNGNHAN c1,MAYBAY m1
	--				where c1.MAMB=m1.MAMB and m1.TAMBAY > 3200
	--				 )
	--group by n.TEN
--37)	Cho biết tên các phi công có thể lái các máy bay có 
--tầm bay lớn hơn 4,800km nhưng không có chứng nhận lái máy 
--bay Boeing.
	select distinct n.TEN
	from NHANVIEN n,CHUNGNHAN c,MAYBAY m
	where n.MANV=c.MANV and m.TAMBAY > 4800 and c.MANV not in (
			select c1.MANV
			from CHUNGNHAN c1,MAYBAY m1
			where c1.MAMB=m1.MAMB and m1.LOAI like '%boeing%') 
	group by n.TEN
--38)	Cho biết tên các phi công lái ít nhất 3 loại máy bay 
--có tầm bay xa hơn 3200km.
-- TRuy vấn lồng
	select n.TEN
	from NHANVIEN n,CHUNGNHAN c,MAYBAY m
	where n.MANV=c.MANV and m.MAMB=c.MAMB
	and c.MANV in ( select c1.MANV
					from CHUNGNHAN c1,MAYBAY m1
					where c1.MAMB=m1.MAMB and m1.TAMBAY > 3200
					group by c1.MANV
					having count(c1.mamb) >=3  )
	group by n.TEN
--Kết ngoài:
--39)	Với mỗi nhân viên cho biết mã số, tên nhân viên 
--và tổng số loại máy bay mà nhân viên đó có thể lái.
	select NHANVIEN.MANV, nhanvien.TEN,count(chungnhan.MAMB) as TongMBcotheLai
	from NHANVIEN left join CHUNGNHAN 
	on nhanvien.manv=chungnhan.manv
	group by NHANVIEN.MANV ,NHANVIEN.TEN
--40)	Với mỗi nhân viên cho biết mã số, tên nhân viên và tổng số 
--loại máy bay Boeing mà nhân viên đó có thể lái.
	select NHANVIEN.MANV, nhanvien.TEN,count(chungnhan.MAMB) as TongMBBoeingCoTheLai
	from NHANVIEN left join CHUNGNHAN 
		on nhanvien.manv=chungnhan.manv left join MAYBAY 
		on MAYBAY.MAMB=CHUNGNHAN.MAMB
	where  MAYBAY.LOAI like '%boeing%'
	group by NHANVIEN.MANV ,NHANVIEN.TEN

	select NHANVIEN.MANV, nhanvien.TEN,count(chungnhan.MAMB) as TongMBBoeingCoTheLai
	from NHANVIEN inner join CHUNGNHAN 
		on nhanvien.manv=chungnhan.manv inner join MAYBAY 
		on  MAYBAY.LOAI like '%boeing%'
		and  MAYBAY.MAMB=CHUNGNHAN.MAMB
	group by NHANVIEN.MANV ,NHANVIEN.TEN
--41)	Với mỗi loại máy bay cho biết loại máy bay và tổng số phi công
--có thể lái loại máy bay đó.
	select MAYBAY.LOAI,count(chungnhan.manv) as TongSoPhiCongCoTheLai
	from MAYBAY left join CHUNGNHAN on MAYBAY.MAMB=CHUNGNHAN.MAMB
	group by MAYBAY.LOAI
--42)	Với mỗi loại máy bay cho biết loại máy bay và tổng số chuyến bay
--không thể thực hiện bởi loại máy bay đó.
	select MAYBAY.LOAI,count(CHUYENBAY.MACB) as TongSoCBkhongThucHienDuoc
	from MAYBAY left  join CHUYENBAY on MAYBAY.TAMBAY < CHUYENBAY.DODAI -- Phù hợp điều kiện mới đếm
	and MAYBAY.MAMB=CHUYENBAY.MAMB
	group by MAYBAY.LOAI
--43)	Với mỗi loại máy bay cho biết loại máy bay và tổng số phi công 
--có lương lớn hơn 100,000 có thể lái loại máy bay đó.
	select MAYBAY.MAMB,count(chungnhan.manv) as [TONGSOPHICONG luong>100000 có thể lái]
	from MAYBAY left join CHUNGNHAN on MAYBAY.MAMB=CHUNGNHAN.MAMB
		left join NHANVIEN on CHUNGNHAN.MANV=NHANVIEN.MANV
	and LUONG > 100000
	group by MAYBAY.MAMB
--44)	Với mỗi loại máy bay có tầm bay trên 3200km, cho biết tên 
--của loại máy bay và lương trung bình của các phi công có thể lái 
--loại máy bay đó.
	select MAYBAY.LOAI,AVG(nhanvien.luong) as LUONGTB
	from MAYBAY left join CHUNGNHAN on MAYBAY.MAMB=CHUNGNHAN.MAMB 
		left join NHANVIEN on NHANVIEN.MANV=CHUNGNHAN.MANV
	and  MAYBAY.TAMBAY > 3200
	group by MAYBAY.loai
--45)	Với mỗi loại máy bay cho biết loại máy bay và tổng số nhân viên
--không thể lái loại máy bay đó.
	select count(n.manv) as TONGNV
	from NHANVIEN n
	
	select m.MAMB,count(c.MANV) as TONGPC
	from MAYBAY m left join CHUNGNHAN c on M.MAMB=C.MAMB 
	group by M.MAMB

	select m.LOAI,D.TONGNV - C.TONGSLNVcothelai as TONGNVKHONGTHELAI
	from maybay m, ( select m.MAMB,count(c.MANV) as TONGSLNVcothelai
								from MAYBAY m left join CHUNGNHAN c on M.MAMB=C.MAMB 
								group by M.MAMB ) as C, (select count(n.manv) as TONGNV
								from NHANVIEN n) as D
	where m.MAMB=c.MAMB 
	group by  m.LOAI ,D.TONGNV - C.TONGSLNVcothelai


	


--46)	Với mỗi loại máy bay cho biết loại máy bay và tổng số phi công
--không thể lái loại máy bay đó.
	select MAYBAY.LOAI,B.TONGPC-C.TONGPC as TONGPCKHONGLAIDUOC
	from MAYBAY, ( select count(n.MANV) as TONGPC
				from NHANVIEN n
				where  n.MANV in (
					select CHUNGNHAN.MANV
					from CHUNGNHAN ) ) as B, (
				select m.MAMB,count(c.MANV) as TONGPC
				from MAYBAY m left join CHUNGNHAN c on M.MAMB=C.MAMB 
				group by M.MAMB) as C
	where MAYBAY.MAMB=c.MAMB
	group by MAYBAY.LOAI,B.TONGPC-C.TONGPC

select distinct  count(NHANVIEN.MANV) as TONGPC
from NHANVIEN inner join CHUNGNHAN on NHANVIEN.MANV=CHUNGNHAN.MANV
--47)	Với mỗi nhân viên cho biết mã số, tên nhân viên và tổng số 
--chuyến bay xuất phát từ Sài Gòn mà nhân viên đó có thể lái.
	select n.MANV,n.TEN,count(ch.macb) as SOCHUYENBAY
	from NHANVIEN n inner join CHUNGNHAN c on c.MANV=n.MANV
		inner join  CHUYENBAY ch
		on c.MAMB=ch.MAMB and ch.gadi = 'SGN'
	group by n.MANV,n.TEN
--48)	Với mỗi nhân viên cho biết mã số, tên nhân viên và tổng
--số chuyến bay xuất phát từ Sài Gòn mà nhân viên đó không thể 
--lái.
	select b.MANV,b.TEN,c.TONGCB-b.SOCHUYENBAY as SOCHUYENBAYPCKHONGLAIDUOC
	from chuyenbay c1,chungnhan c2, (select n.MANV,n.TEN,count(ch.macb) as SOCHUYENBAY
				from NHANVIEN n inner join CHUNGNHAN c on c.MANV=n.MANV
					inner join  CHUYENBAY ch
					on c.MAMB=ch.MAMB and ch.gadi = 'SGN'
				group by n.MANV,n.TEN) as B,
				(select count(macb) as TONGCB
				from CHUYENBAY
				where GADI='SGN') as C
	where c1.MAMB=c2.MAMB and c2.MANV=b.MANV
	group by b.MANV,b.TEN,c.TONGCB-b.SOCHUYENBAY 
--49)	Với mỗi phi công cho biết mã số, tên phi công và tổng số chuyến bay xuất phát từ Sài Gòn mà phi công đó có thể lái.
--50)	Với mỗi phi công cho biết mã số, tên phi công và tổng số chuyến bay xuất phát từ Sài Gòn mà phi công đó không thể lái.
--51)	Với mỗi chuyến bay cho biết mã số chuyến bay và tổng số loại máy 
--bay không thể thực hiện chuyến bay đó.
	select c.MACB,count(m.mamb) as TONGMBKHONGTHUCHIENDUOCCB
	from CHUYENBAY c inner join MAYBAY m on c.DODAI > m.TAMBAY
	group by  c.MACB,TONGMBKHONGTHUCHIENDUOCCB
--52)	Với mỗi chuyến bay cho biết mã số chuyến bay và tổng số loại máy bay có thể thực hiện chuyến bay đó.
--53)	Với mỗi chuyến bay cho biết mã số chuyến bay và tổng số nhân viên không thể lái chuyến bay đó.
--54)	Với mỗi chuyến bay cho biết mã số chuyến bay và tổng số phi công không thể lái chuyến bay đó.

--Exists và các dạng khác:
--55)	Một hành khách muốn đi từ Hà Nội (HAN) đến Nha Trang (CXR) mà không phải đổi chuyến bay quá một lần. Cho biết mã chuyến bay và thời gian khởi hành từ Hà Nội nếu hành khách muốn đến Nha Trang trước 16:00.
--56)	Cho biết tên các loại máy bay mà tất cả các phi công có thể lái đều có lương lớn hơn 200,000.
--57)	Cho biết thông tin của các đường bay mà tất cả các phi công có thể bay trên đường bay đó đều có lương lớn hơn 100,000.
--58)	Cho biết tên các phi công chỉ lái các loại máy bay có tầm bay xa hơn 3200km.
--59)	Cho biết tên các phi công chỉ lái các loại máy bay có tầm bay xa hơn 3200km và một trong số đó là Boeing.
--60)	Tìm các phi công có thể lái tất cả các loại máy bay.
--61)	Tìm các phi công có thể lái tất cả các loại máy bay Boeing.
 




