--Câu 3: Tạo các view theo yêu cầu sau:
--1.	Cho biết mã sản phẩm, tên sản phẩm, tổng số lượng xuất của 
--từng sản phẩm trong năm 2010. Lấy dữ liệu từ View này sắp xếp
--tăng dần theo tên sản phẩm.
	select s.MASP,s.TENSP, sum(c.soluong) as [Tổng sl sản phẩm]
	from SANPHAM s,PHIEUXUAT p,CTPX c
	where s.MASP=c.MASP and c.MAPX=p.MAPX and year(p.NGAYLAP)=2010
	group by s.MASP,s.TENSP
	order by s.TENSP asc
--2.	Cho biết mã sản phẩm, tên sản phẩm, tên loại sản phẩm mà
--đã được bán từ ngày 1/1/2010 đến 30/6/2010.
	select s.MASP,s.TENSP,l.TENLOAI
	from SANPHAM s,PHIEUXUAT p,CTPX c,LOAI l
	where s.MASP=c.MASP and c.MAPX=p.MAPX and s.MALOAI=l.MALOAI
		and p.NGAYLAP  between  cast('2010-01-01'as date) and cast('2010-03-30'as date)
	group by s.MASP,s.TENSP,l.TENLOAI
--3.	Cho biết số lượng sản phẩm trong từng loại sản phẩm gồm các 
--thông tin: mã loại sản phẩm, tên loại sản phẩm, số lượng các sản phẩm.
	select l.MALOAI,l.TENLOAI ,count(s.MALOAI) as[Số lượng sản phẩm]
	from SANPHAM s,LOAI l
	where s.MALOAI=l.MALOAI
	group by l.MALOAI,l.TENLOAI 
--4.	Cho biết tổng số lượng phiếu xuất trong tháng 6 năm 2010.
	select count(c.mapx) as[Tổng số lượng phiếu xuất trong tháng 6]
	from CTPX c,PHIEUXUAT p
	where c.MAPX=p.MAPX and month(p.ngaylap)=6
--5.	Cho biết thông tin về các phiếu xuất mà nhân viên có mã NV01 đã xuất.
	select c.MAPX,c.MASP,c.SOLUONG
	from PHIEUXUAT p,CTPX c
	where p.MAPX=c.MAPX and p.MANV='NV01'
--6.	Cho biết danh sách nhân viên nam có tuổi trên 25 nhưng dưới 30.
	select n1.MANV,n1.HOTEN,n1.NGAYSINH,n1.PHAI,b.Tuổi
	from NHANVIEN n1,(select DATEDIFF(year,n.ngaysinh ,(select getdate())) as [Tuổi], n.MANV
			from Nhanvien n ) as B
	where b.MANV=n1.MANV and b.Tuổi between 26 and 29 and n1.phai = 1 
	group by n1.MANV,n1.HOTEN,n1.NGAYSINH,n1.PHAI,b.Tuổi

	 year(select getdate()) -- Lấy thời gian hiện tại
--7.	Thống kê số lượng phiếu xuất theo từng nhân viên.
	select n.MANV,n.HOTEN,count(c.mapx) as[Số lượng phiếu xuất]
	from NHANVIEN n inner join PHIEUXUAT p on n.MANV=p.MANV
		inner join  CTPX c on c.MAPX=p.MAPX 
	group by n.MANV,n.HOTEN
--8.	Thống kê số lượng sản phẩm đã xuất theo từng sản phẩm.
	select s.MAsp,s.TENSP,sum(c.SOLUONG) as[Tổng số lượng]
	from SANPHAM s,CTPX c
	where s.masp = c.masp
	group by s.MAsp,s.TENSP
--9.	Lấy ra tên của nhân viên có số lượng phiếu xuất lớn nhất.
	select top 1 with ties n.HOTEN , max(c.soluong) as[Số lượng phiếu xuất lơn nhất]
	from NHANVIEN n inner join PHIEUXUAT p on p.MANV=n.MANV
		inner join CTPX c on c.MAPX=p.MAPX 
	group by n.hoten
	order by max(c.soluong) desc
--10.	Lấy ra tên sản phẩm được xuất nhiều nhất trong năm 2010.
	select top 1 with ties s.TENSP, sum(c.soluong) as Tong
	from SANPHAM s,PHIEUXUAT p,CTPX c
	where s.MASP=c.MASP and p.MAPX=c.MAPX and year(p.NGAYLAP)=2010
	group by s.TENSP
	order by Tong desc


--Câu 4:Tạo các Function sau:
--1.	Function F1 có 2 tham số vào là: tên sản phẩm, năm. Function 
--cho biết: số lượng xuất kho của tên sản phẩm đó trong năm này. 
--(Chú ý: Nếu tên sản phẩm đó không tồn tại thì phải trả về 0)
	create function F1(@tensp nvarchar(50),@nam int) -- Sửa thì đổi thành Alter
	returns int
	as
		begin 
			declare @slxuat int
			if not exists ( select tensp from sanpham where tensp=@tensp )
				set @slxuat=0
			else
				select @slxuat=sum(soluong)
				from CTPX c,PHIEUXUAT p,SANPHAM s
				where s.MASP= c.MASP  and c.MAPX=p.MAPX 
					and tensp=@tensp and year(ngaylap)=@nam
				group by tensp 
			return @slxuat
		end 
-- Goi ham
print N'SO luong bột mì: '+ str(dbo.f1(N'Bột mì',2010),10)
print N'SO luong bánh mì: '+ str(dbo.f1(N'Bánh mì',2010),10)
--2.	Function F2 có 1 tham số nhận vào là mã nhân viên. Function trả về
--số lượng phiếu xuất của nhân viên truyền vào. Nếu nhân viên này không 
--tồn tại thì trả về 0.
	create function F2(@manv varchar(6))
	returns int
	as
		begin
			declare @slpx int
			if not exists ( select MANV from NHANVIEN where MANV=@manv )
				set @slpx=0
			else
				select @slpx=count(c.mapx) 
				from NHANVIEN n, PHIEUXUAT p, CTPX c
				where n.MANV=p.MANV  and c.MAPX=p.MAPX and n.MANV=@manv
				group by n.manv
			return @slpx
		end
-- Gọi hàm
print N'SO luong phiếu xuất của NV01: '+ str(dbo.f2('NV01'),10)
print N'SO luong phiếu xuất của NV02: '+ str(dbo.f2('NV09'),10)
--3.	Function F3 có 1 tham số vào là năm, trả về danh sách các sản 
--phẩm được xuất trong năm truyền vào. 
	alter function F3(@nam int)
	returns @bangmoi table(MASP varchar(4),TENSP nvarchar(30),TENLOAI nvarchar(50))
	as
		begin
			if not exists (select NGAYLAP from PHIEUXUAT where year(ngaylap)=@nam)
				--insert into @bangmoi values ('Null',N'Null',N'Null')
				select s.MASP,s.TENSP,l.TENLOAI
				from SANPHAM s,LOAI l,PHIEUXUAT p
				where s.MALOAI=l.MALOAI 
				group by s.MASP,s.TENSP,l.TENLOAI
			else
				insert into @bangmoi
				select s.MASP,s.TENSP,l.TENLOAI
				from SANPHAM s,LOAI l,PHIEUXUAT p
				where s.MALOAI=l.MALOAI and s.MASP=p.MAPX
					and year(ngaylap)=@nam
				group by s.MASP,s.TENSP,l.TENLOAI
			return
		end
-- Truyền tham số
print N'danh sách các sản phẩm được xuất trong năm la:'
select * from dbo.f3(2010)
select * from dbo.f3(2011)
--4.	Function F4 có một tham số vào là mã nhân viên để trả về danh sách các phiếu xuất của nhân viên đó. Nếu mã nhân viên không truyền vào thì trả về tất cả các phiếu xuất.

--5.	Function F5 để cho biết tên nhân viên của một phiếu xuất có mã phiếu xuất là tham số truyền vào.

--6.	Function F6 để cho biết danh sách các phiếu xuất từ ngày T1 đến ngày T2. (T1, T2 là tham số truyền vào). Chú ý: T1 <= T2.

--7.	Function F7 để cho biết ngày xuất của một phiếu xuất với mã phiếu xuất là tham số truyền vào.

--Câu 5: Tạo các Procedure sau:

--1.	Procedure tên là P1 cho có 2 tham số sau:
--•	1 tham số nhận vào là: tên sản phẩm.
--•	1 tham số trả về cho biết: tổng số lượng xuất kho của tên sản phẩm này
--trong năm 2010 (Không viết lại truy vấn, hãy sử dụng Function F1 ở câu 
--4 để thực hiện)
	create procedure P1 @tensp nvarchar(50),@tongslx int output
	as
		begin
			select @tongslx = dbo.f1(@tensp,2010)
		end
-- drop proc p1
-- Goi procedure
	declare @tongslx int
	exec p1 N'Gạch',@tongslx output
	print N'Tổng số lượng xuất: '+ str(@tongslx,2)
--2.	Procedure tên là P2 có 2 tham số sau:
--•	1 tham số nhận vào là: tên sản phẩm.
--•	1 tham số trả về cho biết: tổng số lượng xuất kho của tên sản phẩm này 
--trong khoảng thời gian từ đầu tháng 4/2010 đến hết tháng 6/2010 
--(Chú ý: Nếu tên sản phẩm này không tồn tại thì trả về 0)
	create proc P2 @tensp nvarchar(50),@tong int output
	as
		begin 
			--declare @trave int
			if not exists (select tensp from SANPHAM where tensp=@tensp)
				set @tong=0
			else
				select @tong=sum(c.soluong)
				from SANPHAM s,PHIEUXUAT p,CTPX c
				where s.MASP=c.MASP and c.MAPX=p.MAPX and
					NGAYLAP between cast('2010-04-01' as date) and 
					cast('2010-06-30' as date) and s.TENSP=@tensp
		end
-- Gọi proceduce
	declare @a int
	exec P2 N'Gạch hoa',@a output
	print N'Tổng số lượng xuất: '+ str(@a,2)

	declare @b int
	exec P2 N'Kệ chén',@b output
	print N'Tổng số lượng xuất: '+ str(@b,2)
				
--3.	Procedure tên là P3 chỉ có duy nhất 1 tham số nhận vào là tên 
--sản phẩm. Trong Procedure này có khai báo 1 biến cục bộ được gán giá 
--trị là: số lượng xuất kho của tên sản phẩm này trong khoảng thời gian 
--từ đầu tháng 4/2010 đến hết tháng 6/2010. Việc gán trị này chỉ được 
--thực hiện bằng cách gọi Procedure P2.
	create procedure P3 @tenspp nvarchar(50),@tong int output
	as
		begin
			select @tong=dbo.P2(@tenspp)
		end

	declare @c int
	exec P3 N'Kệ chén',@c output
	print N'Tổng số lượng xuất: '+ str(@c,2)
--4.	Procedure P4 để INSERT một record vào trong table LOAI. Giá trị các field là tham số truyền vào.

--5.	Procedure P5 để DELETE một record trong Table NhânViên theo mã nhân viên. Mã NV là tham số truyền vào.


--Câu 6: Viết các trigger để thực hiện các ràng buộc sau:
--1.	Chỉ cho phép một phiếu xuất có tối đa 5 chi tiết phiếu
--xuất.
--	drop trigger c6_1
	alter trigger T6 on CTPX
	for insert 
	as
		declare @mpx varchar(5)
		select @mpx=mapx from inserted
		if(select count(*) from CTPX c,inserted i where c.MAPX=i.MAPX 
			and i.MAPX=@mpx) > 4
				begin
					raiserror ('1 phieu xuat chi toi da 4 chi tiet px',16,1)
					rollback transaction 
				end
insert into CTPX values (4,4,30)
insert into CTPX values (1,2,6)
insert into CTPX values (1,6,10)
select * from CTPX
--2.	Chỉ cho phép một nhân viên lập tối đa 10 phiếu xuất
--trong một ngày.

--3.	Khi người dùng viết 1 câu truy vấn nhập 1 dòng cho bảng
--chi tiết phiếu xuất thì CSDL kiểm tra, nếu mã phiếu xuất mới
--đó chưa tồn tại trong bảng phiếu xuất thì CSDL sẽ không cho 
--phép nhập và thông báo lỗi “Phiếu xuất này không tồn tại”.
--Hãy viết 1 trigger đảm bảo điều này.

