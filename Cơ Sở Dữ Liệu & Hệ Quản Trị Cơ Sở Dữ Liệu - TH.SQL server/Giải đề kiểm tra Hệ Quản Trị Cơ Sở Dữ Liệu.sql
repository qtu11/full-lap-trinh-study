create database QLTV
on ( name='QLTV_DATA',filename='D:\BTMONHOC\SQL server\QLTV.MDF' )
log on ( name='QLTV_LOG',filename='D:\BTMONHOC\SQL server\QLTV.LDF')

use QLTV

create table DOCGIA
(
	MADG	varchar(10) primary key,
	TENDG	nvarchar(50),
	SODT	varchar(11)  CHECK(SODT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)

create table SACH
(
	MASACH	varchar(10) primary key,
	TENSACH nvarchar(100),
	THELOAI nvarchar(50) check (THELOAI LIKE N'Truyện ngắn' or THELOAI LIKE N'Tiểu thuyết' or THELOAI LIKE N'Thơ' ),
	NAMXB	int check(NAMXB > 1944 and NAMXB < 2022)
)

create table PHIEUMUON
(
	SOPM	varchar(10) primary key,
	NGAYMUON date check (NGAYMUON <= (select getdate()) ),
	SOSACHMUON int  check (SOSACHMUON > 0 and SOSACHMUON < 3),
	MADG	varchar(10) foreign key references DOCGIA(MADG) ON UPDATE CASCADE
)

create table CHITIETPHIEUMUON
(
	SOPM	varchar(10),
	MASACH  varchar(10),
	SOLUONG int,
	NGAYTRA date,
	primary key (SOPM,MASACH)
)

--Câu 2: Thực hiện tạo các ràng buộc sau bằng ngôn ngữ SQL  (1 điểm) 
--Ngày mượn nhỏ hơn hoặc bằng ngày hiện tại. 
--alter table Phieumuon
--add constraint check_ngay check(NGAYMUON <= (select getdate()) )

--Năm xuất bản từ 1945 đến hiện tại. 

--Thể loại chỉ nhập được các thể loại Truyện ngắn, Tiểu thuyết hoặc Thơ 

--Số lượng sách mượn lớn hơn 0 và không mượn quá 2 cuốn sách. 

--Câu 3: Thực hiện các truy vấn sau bằng ngôn ngữ SQL  (5 điểm)  
--a) Tạo truy vấn tìm các cuốn sách là truyện ngắn xuất bản cách hiện tại
--dưới 10 năm. Thông tin hiển thị gồm MASACH, TENSACH, THELOAI, NAMXB  (0.5 điểm) 
	select *
	from SACH 
	where NAMXB between (year((select getdate())) - 10) and (select getdate())
--b) Tạo truy vấn tìm các đọc giả chưa mượn sách tiểu thuyết trong tháng 9
--. Thông tin hiển thị gồm MADG, TENDG (0.5 điểm) 
	select MADG,TENDG
	from DOCGIA 
	where MADG not in (select p.MADG
					  from PHIEUMUON p,CHITIETPHIEUMUON c,SACH s
					  where p.SOPM=c.SOPM and c.MASACH=s.MASACH 
						and month(p.NGAYMUON)=9 and s.THELOAI=N'Tiểu thuyết')
--c) Tạo truy vấn tìm các cuốn sách có số ngày mượn lâu nhất. 
--Thông tin hiển thị gồm MASACH, TENSACH, SONGAYMUON 
--(SỐ NGÀY MƯỢN= NGAYTRA - NGAYMUON)  (1 điểm) 
	select top 1 with ties s.MASACH,s.TENSACH,B.SONGAYMUON
	from SACH s,( select DATEDIFF(day,p.NGAYMUON,c.NGAYTRA) as SONGAYMUON,c.MASACH    from PHIEUMUON p,CHITIETPHIEUMUON c
				where c.SOPM=p.SOPM ) as B
	where s.MASACH=B.MASACH and b.SONGAYMUON is not null
	group by s.MASACH,s.TENSACH,B.SONGAYMUON
	order by B.SONGAYMUON desc

--d) Tạo truy vấn cập nhật số sách mượn (SOSACHMUON) vào table Phiếu mượn 
--(PHIEUMUON). 
--Số sách mượn được tính dựa vào chi tiết phiếu mượn là tổng của SỐ LƯỢNG  (1 điểm) 
	update PHIEUMUON 
	set SOSACHMUON=(select sum(SOLUONG)
					from CHITIETPHIEUMUON c
					where PHIEUMUON.SOPM=c.SOPM
					group by SOPM)
--e) Tạo truy vấn tìm đọc giả đã mượn cả hai cuốn sách thuộc loại tiểu thuyết 
--và truyện ngắn. Thông tin hiển thị gồm MADG, TENDG, SACHLOAI1, SACHLOAI2   ((1 điểm) 
	select d.MADG,d.TENDG,s1.THELOAI,s2.THELOAI
	from DOCGIA d,PHIEUMUON p,CHITIETPHIEUMUON c,SACH s1,SACH s2
	where d.MADG=p.MADG and c.SOPM=p.SOPM and s1.MASACH=c.MASACH and s2.MASACH=c.MASACH and s1.MASACH <> s2.MASACH
		and c.MASACH in (select MASACH from SACH where THELOAI like N'Tiểu thuyết' or THELOAI like N'Truyện ngắn')
	group by d.MADG,d.TENDG,s1.THELOAI,s2.THELOAI
--f) Tạo truy vấn thống kê số lượng sách mượn đã trả và chưa trả. 
--Thông tin hiển thị gồm 
--TỔNG SỐ SÁCH MƯỢN, TỔNG SỐ SÁCH ĐÃ TRẢ, TỔNG SỐ SÁCH CHƯA TRẢ. (1 điểm) 
	select a.[TỔNG SỐ SÁCH CHƯA TRẢ] + b.[TỔNG SỐ SÁCH ĐÃ TRẢ] as [TỔNG SỐ SÁCH MƯỢN],b.[TỔNG SỐ SÁCH ĐÃ TRẢ],a.[TỔNG SỐ SÁCH CHƯA TRẢ]
	from (select count(*) as [TỔNG SỐ SÁCH CHƯA TRẢ] from CHITIETPHIEUMUON c where c.ngaytra is null) as A,
			(select count(*) as [TỔNG SỐ SÁCH ĐÃ TRẢ] from CHITIETPHIEUMUON c where c.ngaytra is not null) as B
	group by b.[TỔNG SỐ SÁCH ĐÃ TRẢ],a.[TỔNG SỐ SÁCH CHƯA TRẢ]



























