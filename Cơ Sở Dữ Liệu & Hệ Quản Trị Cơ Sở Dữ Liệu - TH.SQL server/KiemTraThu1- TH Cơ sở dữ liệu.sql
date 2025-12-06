create database QL_DETAI
 on ( name='QLDT_DATA',filename='D:\BTMONHOC\SQL server\QLDT.MDF' )
log on ( name='QLDT_LOG',filename='D:\BTMONHOC\SQL server\QLDT.LDF')

use QL_DETAI

create table GIANGVIEN
(
	MAGV	varchar(5) primary key,
	TENGV	nvarchar(50)
)
create table DETAI
(
	MADT	varchar(2) primary key,
	TENDT	nvarchar(100),
	SOSV	int,

	MAGV	varchar(5) foreign key references GIANGVIEN(MAGV) ON UPDATE CASCADE
)
create table SINHVIEN
(
	MASV	varchar(5) primary key,
	HOTENSV nvarchar(50),
	PHAI	bit,
	TENLOP	nvarchar(50)
)
create table THUCHIEN
(
	MADT	varchar(2) foreign key references DETAI(MADT) ON UPDATE CASCADE,
	MASV	varchar(5) foreign key references SINHVIEN(MASV) ON UPDATE CASCADE,
	PRIMARY KEY (MADT,MASV),
	NGAYBD	date,
	NGAYKT	date
)
SET DATEFORMAT dmy
select * from THUCHIEN

--1. Liệt kê tên các đề tài chưa có SV nào đăng ký thực hiện. (2 điểm)
	select DETAI.TENDT as 'TENDT CHUA CO SV DK'
	from DETAI 
	where DETAI.MADT not in (select THUCHIEN.MADT from THUCHIEN )
--2. In ra tên SV cùng tên đề tài thực hiện không thành công (NGAYKT là NULL).  (2 điểm)
	select s.HOTENSv +'-   '+d.TENDT as [tên SV cùng tên đề tài thực hiện không thành công]
	from DETAI d inner join THUCHIEN t on t.MADT=d.MADT inner join 
			SINHVIEN s on s.MASV=t.MASV
	where t.NGAYKT is null
--3. Cập nhật cột SOSV của bảng DETAI dựa vào số lượng SV cùng tham gia 
--thực hiện đề tài đó (dựa vào bảng THUCHIEN). (2 điểm)
	update DETAI
	set SOSV = (select count(i.MADT)
				from THUCHIEN i
				where i.MADT=DETAI.MADT
				group by i.MADT)
	from DETAI d inner join THUCHIEN t on t.MADT=d.MADT
--4. Hiển thị tên các đề tài đã hoàn thành và có thời gian thực hiện ngắn nhất.
--Thông tin hiển thị: MADT, TENDT, [Số tháng thực hiện]. (2 điểm)
	select top 1 with ties  d.TENDT as [tên các đề tài đã hoàn thành và có thời gian thực hiện ngắn nhất],b.[Thời gian thực hiện]
	from DETAI d inner join (select DATEDIFF(day,t.NGAYBD,t.NGAYKT) as [Thời gian thực hiện],
			t.MADT,t.MASV from THUCHIEN t ) as B on B.MADT=d.MADT and b.[Thời gian thực hiện] is not null
	order by b.[Thời gian thực hiện] asc

	
			