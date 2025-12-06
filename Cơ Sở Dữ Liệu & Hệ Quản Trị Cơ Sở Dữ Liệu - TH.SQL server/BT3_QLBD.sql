create database QLBD
on (name='QLBD_DATA',filename='D:\BTMONHOC\SQL server\QLBD.MDF')
log on (name='QLBD_LOG',filename='D:\BTMONHOC\SQL server\QLBD.LDF')
use QLBD

create table SAN 
(
	MASAN	char(3) PRIMARY KEY,
	TENSAN	nvarchar(50),
	DIACHI	nvarchar(50)
)
create table DOI
(
	MADOI	char(3) primary key,
	TENDOI	nvarchar(50),
	MASAN	char(3) foreign key references SAN(MASAN) 
			on update cascade on delete cascade
)
create table TRANDAU
(
	MATD	char(2) primary key,
	MASAN	char(3) foreign key references SAN(MASAN) 
			on update cascade on delete cascade,
	NGAY	date,
	GIO		time
)
create table CT_TRANDAU
(
	MATD	char(2) foreign key references TRANDAU(MATD) 
			on update no action,
	MADOI	char(3) foreign key references DOI(MADOI) 
			on update no action,
	SOBANTHANG tinyint check(SOBANTHANG >= 0)
)

--1-	In số trận đấu mà mỗi đội đã thi đấu. Hiển thị:  MaDoi, TenDoi.
	select d.TENDOI,count(c.madoi) as 'Số Trận'
	from DOI d,CT_TRANDAU c
	where d.MADOI=c.MADOI
	group by d.TENDOI
--2-	In kết quả trận đấu theo tỷ số:
--MaTran  | Đội trận đấu | Tỷ số
--  01         | VN-TL         | 3-1
	select a.MATD,a.MADOI + '-' +b.MADOI as DOITRANDAU
			,str(a.sobanthang,2)+'-'+STR(b.sobanthang,2) as TYSO
	from CT_TRANDAU a,CT_TRANDAU b
	where a.MATD=b.MATD and a.MADOI > b.MADOI
--3-	In kết quả mỗi trận theo điểm:
--MaTran  | Doi  | Diem
--01	   | VN  |  3
--01         | TL   |  0 
	select a.MATD,a.MADOI, Case 
							 when  a.SoBanThang > b.SoBanThang then 3
							 when  a.SoBanThang = b.SoBanThang then 1
							 else 0
							 end as DIEM
	from CT_TRANDAU a,CT_TRANDAU b
	where a.MATD=b.MATD and a.MADOI <> b.MADOI
	
--4-	In mã đội, tên đội, tổng số điểm:
--      VN   |  Việt Nam  | 6   
	select a.MADOI,d.TENDOI,sum(Case 
							 when  a.SoBanThang > b.SoBanThang then 3
							 when  a.SoBanThang = b.SoBanThang then 1
							 else 0
							 end) as DIEM
	from DOI d,CT_TRANDAU a,CT_TRANDAU b
	where a.MATD=b.MATD and a.MADOI <> b.MADOI 
			and d.MADOI=a.MADOI 
	group by a.MADOI,d.TENDOI
--5-	Sắp xếp danh sách các đội để biết thứ hạng:
--    | MaDoi  | Ten Doi     | Tổng số điểm | Hiệu số bàn thắng
--        VN     |  Viet Nam  |      6                |    7
	select a.MADOI,d.TENDOI,sum(Case 
							 when  a.SoBanThang > b.SoBanThang then 3
							 when  a.SoBanThang = b.SoBanThang then 1
							 else 0
							 end) as DIEM, 
							 sum(a.sobanthang)-sum(b.sobanthang) as 'Hiệu số bàn thắng'
	from DOI d,CT_TRANDAU a,CT_TRANDAU b
	where a.MATD=b.MATD and a.MADOI <> b.MADOI and d.MADOI=a.MADOI 
	group by a.MADOI,d.TENDOI
--6-	Hiển thị các trận chưa đá:
-- đã đá - chưa đá
--    Các trận chưa đá:
--       LA - CPC 
--       VN - CPC
	select a.MADOI+'-'+b.MADOI as 'Các trận chưa đá'
	from CT_TRANDAU a, CT_TRANDAU b
	where  a.MATD<>b.MATD and a.MADOI <> b.MADOI 
			and a.MADOI+'-'+b.MADOI not in (
			select a1.MADOI+'-'+b1.MADOI 
			from CT_TRANDAU a1, CT_TRANDAU b1
			where  a1.MATD = b1.MATD and a1.MADOI <> b1.MADOI)
	group by a.MADOI+'-'+b.MADOI



