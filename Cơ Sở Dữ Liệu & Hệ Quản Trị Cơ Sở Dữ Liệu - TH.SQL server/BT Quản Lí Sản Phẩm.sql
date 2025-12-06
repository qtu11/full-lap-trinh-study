create database QLSP
 on ( name='QLSP_DATA',filename='D:\BTMONHOC\SQL server\QLSP.MDF' )
log on ( name='QLSP_LOG',filename='D:\BTMONHOC\SQL server\QLSP.LDF')

use QLSP

create table SANPHAM
(
	MASP	varchar(5) primary key,
	TENSP	nvarchar(100),
	XUATXU	nvarchar(20)
)
create table KHACHHANG
(
	MAKH	varchar(5) primary key,
	TENKH	nvarchar(50),
	DIACHI	nvarchar(100)
)
create table DONDATHANG
(
	MADH	varchar(3) primary key,
	NGAYDAT date,
	MAKH	varchar(5) foreign key references KHACHHANG(MAKH) ON UPDATE CASCADE,
)
create table CHITIETDONHANG
(
	MADH	varchar(3) foreign key references DONDATHANG(MADH) ON UPDATE CASCADE,
	MASP	varchar(5) foreign key references SANPHAM(MASP) ON UPDATE CASCADE,
	SOLUONGDAT int CHECK(SOLUONGDAT < 11 and SOLUONGDAT > 0)
)
set dateformat dmy


--Câu 3. Viết các câu truy vấn sau bằng ngôn ngữ SQL. (6 điểm)
--a. Hiển thị danh sách các sản phẩm có xuất xứ từ Nhật có số lượng đặt hàng trên 2 mặt hàng. Thông tin gồm MASP, TENSP, XUATXU, SOLUONGDAT. (1 điểm)
SELECT S.MASP,TENSP,XUATXU,C.SOLUONGDAT
FROM SANPHAM S,CHITIETDONHANG C
WHERE S.MASP=C.MASP AND S.XUATXU LIKE N'NHẬT%' AND C.SOLUONGDAT>2

--b. Hiện thị danh sách các khách hàng có tổng số đơn đặt hàng nhiều nhất. Thông thị gồm: MAKH, TENKH, TỔNG SỐ ĐƠN ĐẶT HÀNG (1.5 điểm)
SELECT TOP 1 WITH TIES  D.MAKH,K.TENKH ,COUNT(D.MAKH) AS TONGSODONHANGNHIEUNHAT
FROM KHACHHANG K,DONDATHANG D
WHERE K.MAKH=D.MAKH 
GROUP BY D.MAKH,K.TENKH
ORDER BY TONGSODONHANGNHIEUNHAT DESC 

--c. Tạo truy vấn tìm các sản phẩm chưa được đặt trong tháng 12 (năm 2017). Thông tin hiển thị kết quả gồm: MASP, TENSP (1.5 điểm)
SELECT MASP,TENSP
FROM SANPHAM 
WHERE MASP  NOT IN (SELECT C.MASP
					FROM DONDATHANG D,CHITIETDONHANG C
					WHERE C.MADH=D.MADH AND MONTH(NGAYDAT)=12 AND YEAR(NGAYDAT)=2017)
--d. Tạo truy vấn thống kê tổng số lượng đặt hàng của từng sản phẩm trong năm 2017. Thông tin hiển thị kết quả như sau: (2 điểm)
SELECT S.MASP,S.TENSP,COUNT(*) AS TONGSOLUONGDATHANG
FROM SANPHAM S, CHITIETDONHANG C,DONDATHANG D
WHERE S.MASP=C.MASP AND C.MADH=D.MADH AND YEAR(D.NGAYDAT)=2017
GROUP BY S.MASP,S.TENSP






