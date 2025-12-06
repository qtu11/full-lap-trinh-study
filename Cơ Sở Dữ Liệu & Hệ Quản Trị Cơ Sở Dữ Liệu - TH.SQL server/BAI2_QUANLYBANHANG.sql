--TẠO DATABASE
CREATE DATABASE QUANLYBANHANG
ON(NAME='DATA_QUANLYBANHANG',FILENAME='D:\TAM\QUANLYBANHANG.MDF')
LOG ON(NAME='LOG_QUANLYBANHANG',FILENAME='D:\TAM\QUANLYBANHANG.LDF')
GO
USE QUANLYBANHANG
GO
--TẠO BẢNG
CREATE TABLE KHACHHANG
(
	MAKH	varchar(5) PRIMARY KEY,
	TENKH	nvarchar(30) NOT NULL,
	DIACHI	nvarchar(50),
	DT	varchar(11) CONSTRAINT CK_DT CHECK(DT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
										OR DT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
										OR DT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
										OR DT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
										OR DT IS NULL
											),
	EMAIL	varchar(30)
)
GO
CREATE TABLE VATTU
(
	MAVT	varchar(5) PRIMARY KEY,
	TENVT	Nvarchar(30) NOT NULL,
	DVT	Nvarchar(20),
	GIAMUA	Money CHECK(GIAMUA>0), 	
	SLTON	Int CHECK(SLTON>=0)	
)
--

GO
--lưu ý: cân nhắc khi sử dụng ON UPDATE CASCADE ON DELETE CASCADE 
CREATE TABLE HOADON
(
	MAHD	varchar(10) PRIMARY KEY,
	NGAY	Date CHECK(NGAY<GETDATE()),
	MAKH	varchar(5) FOREIGN KEY REFERENCES KHACHHANG(MAKH) ON UPDATE CASCADE ON DELETE CASCADE,
	TONGTG	Float	
)
GO
CREATE TABLE CTHD
(
	MAHD	varchar(10) FOREIGN KEY REFERENCES HOADON(MAHD) ON UPDATE CASCADE ON DELETE CASCADE,
	MAVT	varchar(5) FOREIGN KEY REFERENCES VATTU(MAVT) ON UPDATE CASCADE ON DELETE CASCADE,
	SL	int CHECK(SL>0), 	
	KHUYENMAI	Float,	
	GIABAN	Float,
	PRIMARY KEY(MAHD,MAVT)
)
----===================NHAP LIEU CHO CAC TABLE ============-----------
--dữ liệu có thể copy/paste  
---------------------INSERT INTO TABLE KHACHHANG --------------
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

--XÓA DL TRONG BẢNG
--DELETE CTHD
--DELETE HOADON
--DELETE KHACHHANG
--WHERE MAKH='KH01'
--DELETE VATTU

SELECT * 
FROM KHACHHANG
SELECT *
FROM HOADON

SELECT MAHD,MAVT,SL,GIABAN
FROM CTHD


select *
into...
from VATTU
where TENVT like N'sắt'
--Câu 6: Tạo các trigger để thực hiện các ràng buộc sau:
--1.	Thực hiện việc kiểm tra các ràng buộc khóa ngoại.
--2.	Không cho phép CASCADE DELETE trong các ràng buộc khóa ngoại. Ví dụ không cho phép xóa các HOADON nào có SOHD còn trong table CTHD.
--3.	Không cho phép user nhập vào hai vật tư có cùng tên.
--4.	Khi user đặt hàng thì KHUYENMAI là 5% nếu
--SL > 100, 10% nếu SL > 500.
	create trigger t4 on cthd
	for insert ,update
	as
		declare @mahd varchar(5),@mavt varchar(5)
		select @mahd=mahd from inserted
		select @mavt=mavt from inserted
		update cthd
		set KHUYENMAI= case when sl>500 then 0.1*sl*GIABAN
							when sl>100 then 0.05*sl*GIABAN
						end 
		where MAHD=@mahd and MAVT=@mavt
--TEST
	update CTHD
	set KHUYENMAI=0
	where sl>0

	select * from CTHD
	insert into CTHD (MAHD,MAVT,SL,GIABAN) values ('HD010','VT02',600,50000)

--5.	Chỉ cho phép mua các mặt hàng có số lượng tồn lớn hơn hoặc bằng số lượng cần mua và tính lại số lượng tồn mỗi khi có đơn hàng.
--6.	Không cho phép user xóa một lúc nhiều hơn một vật tư.
--7.	Mỗi hóa đơn cho phép bán tối đa 5 mặt hàng.
--8.	Mỗi hóa đơn có tổng trị giá tối đa 50000000.
--9.	Không được phép bán hàng lỗ quá 50%.
--10.	Chỉ bán mặt hàng Gạch (các loại gạch) với số lượng là bội số của 100.


