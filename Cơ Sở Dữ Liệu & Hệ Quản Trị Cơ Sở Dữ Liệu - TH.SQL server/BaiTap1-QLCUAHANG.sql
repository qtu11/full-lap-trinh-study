--create database QLBANHANG
create table KHACHHANG
(
	MAKH	varchar (5) not NULL primary key,
	TENKH	nvarchar (30),
	DIACHI	nvarchar(50),
	DT	varchar(11) CONSTRAINT CK_DT CHECK(DT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
										OR DT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
										OR DT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
										OR DT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
										OR DT IS NULL
											),
	EMAIL	varchar(30)
)
go
create table VATTU
(
	MAVT	varchar (5) not NULL primary key,
	TENVT	nvarchar(30),
	DVT		nvarchar(20),
	GIAMUA	money check(GIAMUA > 0),
	SLTON	int check(SLTON >= 0)
)
go
create table HOADON
(
	MAHD	varchar (10) primary key,
	NGAY	date check(NGAY < getdate()),
	MAKH	varchar (5) foreign key references KHACHHANG(MAKH) on update cascade on delete cascade ,
	TONGTG	float,
)
go
create table CTHD
(
	MAHD	varchar (10) foreign key references HOADON(MAHD) on update cascade on delete cascade ,
	MAVT	varchar (5) foreign key references VATTU(MAVT) on update cascade on delete cascade,
	SL		int check(SL > 0),
	KHUYENMAI float,
	GIABAN	float,
	primary key (MAHD,MAVT)
)
go
insert into KHACHHANG values ('KH01',N'NGUYỄN THỊ BÉ',N'TÂN BÌNH','38457895','bnt@yahoo.com')
insert into KHACHHANG values ('KH02',N'LÊ HOÀNG NAM',N'BÌNH CHÁNH','39878987','namlehoang@abc.com.vn')
insert into KHACHHANG values ('KH03',N'TRẦN THỊ CHIÊU',N'TÂN BÌNH','38457895',null)
insert into KHACHHANG values ('KH04',N'MAI THỊ QUẾ ANH',N'BÌNH CHÁNH',null,null)
insert into KHACHHANG values ('KH05',N'LÊ VĂN SÁNG',N'QUẬN 10',null,'sanglv@hcm.vnn.vn')
insert into KHACHHANG values ('KH06',N'TRẦN HOÀNG',N'TÂN BÌNH','38457897',null)
go
--------- TABLE VATTU -----------------
insert into VATTU values ('VT01',N'XI MĂNG','BAO',50000,5000)
insert into VATTU values ('VT02',N'CÁT',N'KHỐI',45000,50000)
insert into VATTU values ('VT03',N'GẠCH ỐNG',N'VIÊN',120,800000)
insert into VATTU values ('VT04',N'GẠCH THẺ',N'VIÊN',110,800000)
insert into VATTU values ('VT05',N'ĐÁ LỚN',N'KHỐI',25000,100000)
insert into VATTU values ('VT06',N'ĐÁ NHỎ',N'KHỐI',33000,100000)
insert into VATTU values ('VT07',N'LAM GÍO',N'CÁI',15000,50000)
insert into VATTU values ('VT08',N'LAM GÍO',N'CÁI',15000,50000)
GO

-------------------- INSERT INTO HOADON ------------
SET DATEFORMAT DMY
insert into HOADON values ('HD001','12/05/2010','KH01',NULL)
insert into HOADON values ('HD002','25/05/2010','KH02',NULL)
insert into HOADON values ('HD003','25/05/2010','KH01',NULL)
insert into HOADON values ('HD004','25/05/2010','KH04',NULL)
insert into HOADON values ('HD005','26/05/2010','KH04',NULL)
insert into HOADON values ('HD006','02/06/2010','KH03',NULL)
insert into HOADON values ('HD007','22/06/2010','KH04',NULL)
insert into HOADON values ('HD008','25/06/2010','KH03',NULL)
insert into HOADON values ('HD009','15/08/2010','KH04',NULL)
insert into HOADON values ('HD010','30/09/2010','KH01',NULL)
go
----------------Insert into CHITIETHOADON------------------
insert into CTHD values ('HD001','VT01',5,null,52000)
insert into CTHD values ('HD001','VT05',10,null,30000)
insert into CTHD values ('HD002','VT03',10000,null,150)
insert into CTHD values ('HD003','VT02',20,null,55000)
insert into CTHD values ('HD004','VT03',50000,null,150)
insert into CTHD values ('HD004','VT04',20000,null,120)
insert into CTHD values ('HD005','VT05',10,null,30000)
insert into CTHD values ('HD005','VT06',15,null,35000)
insert into CTHD values ('HD005','VT07',20,null,17000)
insert into CTHD values ('HD006','VT04',10000,null,120)
insert into CTHD values ('HD007','VT04',20000,null,150)
insert into CTHD values ('HD008','VT01',100,null,55000)
insert into CTHD values ('HD008','VT02',20,null,47000)
insert into CTHD values ('HD009','VT02',25,null,48000)
insert into CTHD values ('HD010','VT01',25,null,57000)
-- Bài Tập THÊM
--1.	Hiển thị danh sách các khách hàng có địa chỉ là “Tân Bình” gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
select MAKH as 'MÃ KHÁCH HÀNG',TENKH as 'TÊN KHÁCH HÀNG',DIACHI,DT,EMAIL
from KHACHHANG
where DIACHI = N'TÂN BÌNH'
--2.	Hiển thị danh sách các khách hàng gồm các thông tin mã khách hàng, tên khách hàng, địa chỉ và địa chỉ E-mail của những khách hàng chưa có số điện thoại.
select *
from KHACHHANG
where DT is null
--3.	Hiển thị danh sách các khách hàng chưa có số điện thoại và cũng chưa có địa chỉ Email gồm mã khách hàng, tên khách hàng, địa chỉ.
select MAKH,TENKH,DIACHI
from KHACHHANG
where DT is null and EMAIL is null
--4.	Hiển thị danh sách các khách hàng đã có số điện thoại và địa chỉ E-mail gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
select *
from KHACHHANG
where DT is not null and EMAIL is not null
--5.	Hiển thị danh sách các vật tư có đơn vị tính là “Cái” gồm mã vật tư, tên vật tư và giá mua.
select * from VATTU
select MAVT,TENVT,GIAMUA
from VATTU
where DVT = N'CÁI'
--6.	Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua trên 25000.
select *
from VATTU
where GIAMUA > 25000
--7.	Hiển thị danh sách các vật tư là “Gạch” (bao gồm các loại gạch) gồm mã vật tư, tên vật tư, đơn vị tính và giá mua.
select MAVT,TENVT,DVT,GIAMUA
from VATTU
where TENVT like N'%GẠCH%'
--8.	Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua nằm trong khoảng từ 20000 đến 40000.
select *
from VATTU
where GIAMUA between 20000 and 40000
--9.	Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại.
select * from HOADON
select * from KHACHHANG
	select MAHD,NGAY, TENKH, DIACHI,DT
	from HOADON h,KHACHHANG k
	where h.MAKH=k.MAKH
--10.	Lấy ra các thông tin gồm Mã hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của ngày 25/5/2010.
select MAHD,TENKH,DIACHI,DT
from HOADON h,KHACHHANG k
where k.MAKH=h.MAKH and day(NGAY)=25 and MONTH(NGAY)=5 AND YEAR(NGAY)=2010
--11.	Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của những hóa đơn trong tháng 6/2010.
select MAHD,NGAY,TENKH,DIACHI,DT
from HOADON h,KHACHHANG k
where k.MAKH=h.MAKH and month(ngay)=6 and year(ngay)=2010
--13.	Lấy ra danh sách những khách hàng không mua hàng trong tháng 6/2010 gồm các thông tin tên khách hàng, địa chỉ, số điện thoại.
select TENKH,DIACHI,DT,NGAY
from KHACHHANG K LEFT JOIN HOADON H ON K.MAKH =H.MAKH
GROUP BY K.MAKH,TENKH,DIACHI,DT,NGAY
select TENKH,DIACHI,DT,NGAY
from HOADON h,KHACHHANG k
where  k.MAKH=h.MAKH and month(ngay) <> 6 and year(ngay) <> 2010
--14.	Lấy ra các chi tiết hóa đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng).

--15.	Lấy ra các chi tiết hóa đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng) mà có giá bán lớn hơn hoặc bằng giá mua.

--16.	Lấy ra các thông tin gồm mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng) và cột khuyến mãi với khuyến mãi 10% cho những mặt hàng bán trong một hóa đơn lớn hơn 100.

--17.	Tìm ra những mặt hàng chưa bán được.

--18.	Tạo bảng tổng hợp gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 

--19.	Tạo bảng tổng hợp tháng 5/2010 gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
--20.	Tạo bảng tổng hợp quý 1 – 2010 gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
--21.	Lấy ra danh sách các hóa đơn gồm các thông tin: Số hóa đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn.
--22.	Lấy ra hóa đơn có tổng trị giá lớn nhất gồm các thông tin: Số hóa đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn.
--23.	Lấy ra hóa đơn có tổng trị giá lớn nhất trong tháng 5/2010 gồm các thông tin: Số hóa đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn.
--24.	Đếm xem mỗi khách hàng có bao nhiêu hóa đơn.
--25.	Đếm xem mỗi khách hàng, mỗi tháng có bao nhiêu hóa đơn.
--26.	Lấy ra các thông tin của khách hàng có số lượng hóa đơn mua hàng nhiều nhất.
--27.	Lấy ra các thông tin của khách hàng có số lượng hàng mua nhiều nhất.
--28.	Lấy ra các thông tin về các mặt hàng mà được bán trong nhiều hóa đơn nhất.
--29.	Lấy ra các thông tin về các mặt hàng mà được bán nhiều nhất.
--30.	Lấy ra danh sách tất cả các khách hàng gồm Mã khách hàng, tên khách hàng, địa chỉ, số lượng hóa đơn đã mua (nếu khách hàng đó chưa mua hàng thì cột số lượng hóa đơn để trống)

