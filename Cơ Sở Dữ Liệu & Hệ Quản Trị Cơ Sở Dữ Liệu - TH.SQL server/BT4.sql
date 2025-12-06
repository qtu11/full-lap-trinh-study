create database QLSV
on (name='QLSV_DATA',filename='D:\BTMONHOC\SQL server\QLSV.MDF')
log on (name='QLSV_LOG',filename='D:\BTMONHOC\SQL server\QLSV.LDF')
use QLSV

create table LOP
(
	MALOP	char(7) primary key,
	TENLOP	nvarchar(50),
	SISO	tinyint check(SISO > 0)
)
create table MONHOC
(
	MAMH	char(6) primary key,
	TENMH	nvarchar(50),
	TCLT	tinyint check(TCLT > 0),
	TCTH	tinyint check(TCTH >= 0)
)
create table SINHVIEN
(
	MSSV	char(6) primary key,
	HOTEN	nvarchar(50),
	NTNS	date,
	PHAI	bit default 1 ,
	MALOP	char(7) foreign key references LOP(MALOP)
			ON UPDATE CASCADE ON DELETE CASCADE
)
create table DIEMSV
(
	MSSV	char(6) foreign key references SINHVIEN(MSSV) 
			on update cascade on delete cascade,
	MAMH	char(6) foreign key references MONHOC(MAMH) 
			on update cascade on delete cascade,
	DIEM	decimal(3,1) check(DIEM is NULL or DIEM between 0 and 10)
)
-- Nhap bảng LỚP
insert into LOP values('18DTH01',N'CNTT Khóa 18, Lớp 1','50')
insert into LOP values('18DTH02',N'CNTT Khóa 18, Lớp 2','45')
--.....
-- NHập bảng MÔN HỌC
insert into MONHOC values('COS201',N'Kỹ thuật lập trình','2','1')
insert into MONHOC values('COS202',N'Lý thuyết đồ thị','2','1')
--.....
-- NHập bảng SINH VIÊN
set dateformat DMY
insert into SINHVIEN values('170001',N'Lê Hoài An','12/10/1999','1','18DTH01')
--.....
-- Nhập bảng ĐIỂM SV
insert into DIEMSV values('170001','COS201','10')
insert into DIEMSV values('170001','COS202','10')
--.....

--select *
--from LOP
--select *
--from MONHOC
--select *
--from SINHVIEN
--select *
--from DIEMSV

--1-	Thêm một dòng mới vào bảng SINHVIEN với giá trị:
--190001	Đào Thị Tuyết Hoa	08/03/2001	0	19DTH02
	insert into SINHVIEN values('190001',N'Đào Thị Tuyết Hoa','08/03/2001','0','19DTH02')
--2-	Hãy đổi tên môn học ‘Lý thuyết đồ thị ’thành ‘Toán rời rạc’.
	update MONHOC set TENMH=N'Toán rời rạc' where TENMH=N'Lý thuyết đồ thị'
--3-	Hiển thị tên các môn học không có thực hành.
	select TENMH
	from MONHOC
	where TCTH = 0
--4-	Hiển thị tên các môn học vừa có lý thuyết, vừa có thực hành.
	select TENMH
	from MONHOC
	where TCTH <> 0 and TCLT <> 0
--5-	In ra tên các môn học có ký tự đầu của tên là chữ ‘C’.
	select TENMH
	from MONHOC
	where TENMH like N'C%'
--6-	Liệt kê thông tin những sinh viên mà họ chứa chữ ‘Thị’.
	select *
	from SINHVIEN
	where HOTEN like N'%thị%'
--7-	In ra 2 lớp có sĩ số đông nhất (bằng nhiều cách). Hiển thị: Mã lớp, Tên lớp, Sĩ số. Nhận xét?
--C1
	select top 2 with ties SISO,MALOP,TENLOP
	from LOP
	order by siso desc
--C2
	select *
	from LOP
	order by siso 
	
--8-	In danh sách SV theo từng lớp: MSSV, Họ tên SV, Năm sinh, Phái (Nam/Nữ).
	select MSSV,HOTEN,year(NTNS) as NAMSINH ,IIf(phai=1,'NAM','NU') as PHAI
	from LOP l, SINHVIEN s
	where l.MALOP = s.MALOP
--9-	Cho biết những sinh viên có tuổi ≥ 20, thông tin gồm: Họ tên sinh viên, Ngày sinh, Tuổi.
	select HOTEN,NTNS,year(getdate())-year(NTNS) as 'Tuổi'
	from SINHVIEN
	where year(getdate())-year(NTNS) >= 20
--10-	Liệt kê tên các môn học SV đã dự thi nhưng chưa có điểm.
	select TENMH
	from MONHOC m, DIEMSV d
	where m.MAMH=d.MAMH and DIEM is  NULL
--11-	Liệt kê kết quả học tập của SV có mã số 170001. Hiển thị: MSSV, HoTen, TenMH, Diem.
	select s.MSSV,HOTEN,TENMH,DIEM
	from SINHVIEN s, DIEMSV d,MONHOC m
	where s.MSSV=d.MSSV and m.MAMH = d.MAMH and s.MSSV='170001'
--12-	Liệt kê tên sinh viên và mã môn học mà sv đó đăng ký với điểm trên 7 điểm.
	select s.HOTEN,m.MAMH
	from SINHVIEN s, DIEMSV d,MONHOC m
	where s.MSSV=d.MSSV and m.MAMH = d.MAMH and d.DIEM > 7
--13-	Liệt tên môn học cùng số lượng SV đã học và đã có điểm.
	select m.TENMH,count(d.mssv) as SLSV
	from SINHVIEN s, DIEMSV d,MONHOC m
	where s.MSSV=d.MSSV and m.MAMH = d.MAMH and d.DIEM <> NULL
	group by m.TENMH
--14-	Liệt kê tên SV và điểm trung bình của SV đó.
	select  s.HOTEN, AVG(diem) as DTB
	from SINHVIEN s,DIEMSV d
	where s.MSSV=d.MSSV
	group by s.HOTEN
--15-	Liệt kê tên sinh viên đạt điểm cao nhất của môn học ‘Kỹ thuật lập trình’.
	select top 1 with ties d.DIEM,s.HOTEN
	from SINHVIEN s, DIEMSV d,MONHOC m
	where s.MSSV=d.MSSV and m.MAMH = d.MAMH and m.TENMH= N'Kỹ thuật lập trình'
	order by d.DIEM desc 
--16-	Liệt kê tên SV có điểm trung bình cao nhất.
	select distinct s.HOTEN,AVG(d.DIEM) as DTB
	from SINHVIEN s, DIEMSV d,MONHOC m
	where s.MSSV=d.MSSV and m.MAMH = d.MAMH
	group by s.HOTEN
--17-	Liệt kê tên SV chưa học môn ‘Toán rời rạc’.
	--select  s.HOTEN
	--from SINHVIEN s, DIEMSV d,MONHOC m
	--where s.MSSV=d.MSSV and m.MAMH = d.MAMH and m.TENMH NOT IN N'Toán rời rạc'
	--group by s.HOTEN

	select s.hoten
	from SINHVIEN s
	where s.MSSV not in
		(SELECT mssv from DIEMSV d, MONHOC m
		where d.MAMH=m.MAMH and m.TENMH = N'Toán rời rạc')
--18-	Cho biết sinh viên có năm sinh cùng với sinh viên tên ‘Danh’.
	SELECT S.HOTEN
	FROM SINHVIEN S
	WHERE YEAR(NTNS) =  (SELECT YEAR(NTNS) FROM SINHVIEN WHERE HOTEN LIKE N'%Danh')
--19-	Cho biết tổng sinh viên và tổng số sinh viên nữ.
	select  COUNT(MSSV) as TongSV,
		( select count(MSSV) from SINHVIEN where PHAI = 0 ) as SLSVNU
	from SINHVIEN 

--20-	Cho biết danh sách các sinh viên rớt ít nhất 1 môn.
	select s.mssv, s.HOTEN,count(d.mamh) as SLMONROT
	from SINHVIEN s,DIEMSV d
	where s.MSSV=d.MSSV and d.DIEM<5
	group by s.MSSV,s.HOTEN
--21-	Cho biết MSSV, Họ tên SV đã học và có điểm ít nhất 3 môn.
	select s.MSSV,s.HOTEN
	from SINHVIEN s,DIEMSV d
	where s.MSSV=d.MSSV and d.DIEM is not null
	group by s.MSSV,s.HOTEN
	having count(d.diem) >= 3
--22-	In danh sách sinh viên có điểm môn ‘Kỹ thuật lập trình’ cao nhất theo từng lớp.
	select  s.MALOP,s.HOTEN,m.TENMH,d.DIEM
	from SINHVIEN s, DIEMSV d,MONHOC m
	where s.MSSV=d.MSSV  and m.MAMH=d.MAMH and m.TENMH=N'Kỹ thuật lập trình' and d.DIEM >= all (
		select diem
		from DIEMSV d1,SINHVIEN s1, MONHOC m1
		where d1.MSSV=s1.MSSV and m1.MAMH = d1.MAMH and m1.TENMH=N'Kỹ thuật lập trình' and s1.MALOP=s.MALOP)
		
--23-	In danh sách sinh viên có điểm cao nhất theo từng môn, từng lớp.
	select  s.MALOP,m.TENMH, s.HOTEN,m.TENMH,d.DIEM
	from SINHVIEN s, DIEMSV d,MONHOC m
	where s.MSSV=d.MSSV  and m.MAMH=d.MAMH  and d.DIEM >= all (
		select diem
		from DIEMSV d1,SINHVIEN s1, MONHOC m1
		where d1.MSSV=s1.MSSV and m1.MAMH = d1.MAMH and s1.MALOP=s.MALOP)
--24-	Cho biết những sinh viên đạt điểm cao nhất của từng môn.
	select top 1 with ties d.MAMH,s.HOTEN,d.DIEM
	from SINHVIEN s,DIEMSV d
	where s.MSSV = d.MSSV
	order by DIEM desc

	select  s.MALOP,s.HOTEN,m.TENMH,m.TENMH,d.DIEM
	from SINHVIEN s, DIEMSV d,MONHOC m
	where s.MSSV=d.MSSV  and m.MAMH=d.MAMH  and d.DIEM >= all (
		select max(d1.diem)
		from DIEMSV d1,SINHVIEN s1, MONHOC m1
		where d1.MSSV=s1.MSSV and m1.MAMH = d1.MAMH and m.MAMH = m1.MAMH
		group by  m1.MAMH )


--25-	Cho biết MSSV, Họ tên SV chưa đăng ký học môn nào.
	select *
	from SINHVIEN
	where MSSV not in (
		select MSSV 
		from DIEMSV
		)
--26-	Danh sách sinh viên có tất cả các điểm đều 10. Diem cao nhat
	select *
	from SINHVIEN s, DIEMSV d
	where s.MSSV=d.mssv and d.DIEM=10
	
	--s.MSSV in (
	--	select MSSV
	--	from DIEMSV
	--	where DIEM=10
	--	)
--27-	Đếm số sinh viên nam, nữ theo từng lớp.
	select l.TENLOP,sum(case phai when 1 then 1 else 0 end) as SLNAM ,
			sum(case phai when 0 then 1 else 0 end) as SLNu
	from SINHVIEN s,LOP l
	where s.MALOP=l.MALOP
	group by  l.TENLOP

	select *
	from SINHVIEN
--28-	Cho biết những sinh viên đã học tất cả các môn nhưng không rớt môn nào.
	select *
	from SINHVIEN 
	where MSSV in (
		select MSSV
		from DIEMSV
		where  diem > 5 
		group by mssv
		having count(mssv) = (  -- dem so mon hoc 
			select count(*)
			from MONHOC
			))
--29-	Xóa tất cả những sinh viên chưa dự thi môn nào.
	delete 
	from SINHVIEN 
	where MSSV not in (
		select mssv
		from DIEMSV
		--group by mssv
		)
	select *
	from SINHVIEN
--30-	Cho biết những môn đã được tất cả các sinh viên đăng ký học.
	select *
	from MONHOC
	where MAMH in (
		select MAMH
		from DIEMSV
		group by MAMH
		having count(mssv)= (
			select count(mssv)
			from SINHVIEN
		))



