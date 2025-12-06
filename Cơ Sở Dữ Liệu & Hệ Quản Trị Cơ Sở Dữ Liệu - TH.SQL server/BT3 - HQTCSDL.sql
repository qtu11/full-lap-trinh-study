create function tong(@a int,@b int)
returns int
as
begin
	return @a+@b
end
---
print  dbo.tong(3,4)
print N'Tổng la: ' + str(dbo.tong(3,4),2)
--
declare @tong int
set @tong = dbo.tong(6,3)
select @tong as Tổng

create function dbo.Hienthikhachhang()
returns table
as
	return 
	select * from KHACHHANG
--
select * from dbo.Hienthikhachhang()

alter function dbo.Hienthikhachhang()
returns table
as
	return 
	select * from KHACHHANG
--
create function NV_PX(@MANV varchar(5))
returns @TH table(MANV varchar(5), MAPX int)
as	
	begin
		if(@manv is NULL)
			insert into @TH
			select n.MANV,MAPX
			from NHANVIEN n,PHIEUXUAT p
			where n.MANV=p.MANV 
		else
			insert into @TH
			select n.MANV,MAPX
			from NHANVIEN n,PHIEUXUAT p
			where n.MANV=p.MANV and n.MANV = @MANV
		return 
	end
--
select * from DBO.NV_PX(NULL)
select * from DBO.NV_PX('NV01')
-----------------
--QLBANHANG
--1.	Viết hàm tính doanh thu của năm, với năm là 
--tham số truyền vào.
create function F1(@nam int)
returns bigint
as
	begin
	declare @DT Bigint
		select @DT=sum(SL*giaban)
		from Hoadon h,CTHD c
		where h.mahd = c.mahd and year(ngay)=@nam
		return @DT
	end
--drop function f1
--GOI ham
print DBO.F1(2010)
print N'Doanh Thu Của Năm: ' + str(dbo.F1(2010),8)
print N'Doanh Thu Của Năm: ' +  cast(dbo.f1(2010) as varchar(10))
print N'Doanh Thu Của Năm: ' +  convert(varchar(10), dbo.f1(2010))
--2,3 về nhà làm

--4.	Viết hàm tính tổng số lượng bán được cho từng
--mặt hàng theo tháng, năm nào đó. Với mã hàng, tháng và
--năm là các tham số truyền vào, 
--nếu tháng không nhập vào tức là tính tất cả các tháng.
create function F4(@MAVT varchar(5),@T int,@n int)
returns @TongSL table(MAVT varchar(5),Tongsl bigint)
as 
	begin
		if(@t is null) -- khong truyền tháng
			insert into @TongSL
			select mavt,sum(sl)
			from CTHD c,HOADON h
			where h.MAHD=c.MAHD and MAVT=@MAVT and YEAR(ngay)='2010'
			group by MAVT
		else		--truyền tháng và năm
			insert into @TongSL
			select mavt,sum(sl)
			from CTHD c,HOADON h
			where h.MAHD=c.MAHD and MAVT=@MAVT 
			and YEAR(ngay)=@n and MONTH(ngay)=@t
			group by MAVT
		return
	end
--drop function f4
--Truyền tham số
select * from dbo.f4('VT01',null,'2010')
select * from dbo.f4('VT01',5,2010)

-- DB3
--1.	Function F1 có 2 tham số vào là: tên sản phẩm, năm.
--Function cho biết: số lượng xuất kho của tên sản phẩm 
--đó trong năm này. 
--(Chú ý: Nếu tên sản phẩm đó không tồn tại thì phải trả về 0)
alter function F1(@tensp nvarchar(50),@n int)
returns int
as
	begin
		declare @slxuat int
		if not exists (select tensp from SANPHAM where tensp =@tensp)
			set @slxuat =0
		else
			select @slxuat=sum(soluong)
			from SANPHAM s,PHIEUXUAT p,CTPX c
			where s.MASP= c.MASP  and c.MAPX=p.MAPX
					and TENSP=@tensp and year(NGAYLAP)=@n
			group by TENSP
		return @slxuat
	end
drop function F1
-- goij ham
print N'SO luong: '+ str(dbo.f1(N'gạch',2010),10)
--Câu 5: Tạo các Procedure sau:
--1.	Procedure tên là P1 cho có 2 tham số sau:
--•	1 tham số nhận vào là: tên sản phẩm.
--•	1 tham số trả về cho biết: tổng số lượng xuất kho 
-- của tên sản phẩm này trong năm 2010 (Không viết lại truy vấn,
-- hãy sử dụng Function F1 ở câu 4 để thực hiện)
create proc p1 @tensp nvarchar(50),@tongslx int out
as
begin
	--goi ham
	select @tongslx = dbo.F1(@tensp,2010)
end
-- goi proc
declare @tongslx int
exec p1 N'Gạch',@tongslx out
print N'Tổng sl xuất: ' + str(@tongslx,2)


--Câu 6: Viết các trigger để thực hiện các ràng buộc sau:
--1.	Chỉ cho phép một phiếu xuất có tối đa 5 chi tiết phiếu xuất.
create trigger c6_1 on CTPX
for insert 
as	
	declare @mapx varchar(5)
	select @mapx=mapx from inserted
	if(select count(*) from CTPX ct, inserted i 
		where ct.MAPX=i.MAPX and i.MAPX=@mapx)>5
	begin
		raiserror ('1phieu xuat chi toi da 5 phieu xuat',16,1)
		-- Dùng print cũng ok
		rollback transaction 
	end

select * from CTPX
select * from PHIEUXUAT
select * from SANPHAM
insert into CTPX values (1,5,5)
insert into CTPX values (1,5,6)
insert into CTPX values (1,6,10)
--2.	Chỉ cho phép một nhân viên lập tối đa 10 phiếu xuất trong
--một ngày.
create trigger c6_2 on PHIeuxuat 
for insert 
as 
	if(select count(*) from PHIEUXUAT px,inserted i 
		where px.manv =i.MANV and px.NGAYLAP=i.NGAYLAP)>4
	begin
		raiserror ('MOI NHAN VIEN CHI LAP TOI DA 4 phieu xuat/NGAY ',16,1)
		-- Dùng print cũng ok
		rollback transaction 
	end

select * from CTPX
select * from PHIEUXUAT
select * from SANPHAM

set dateformat dmy

INSERT INTO PHIEUXUAT VALUES('12/03/2010','NV01')
INSERT INTO PHIEUXUAT VALUES('12/03/2010','NV01')

--3.	Khi người dùng viết 1 câu truy vấn nhập 1 dòng cho bảng chi
--tiết phiếu xuất thì CSDL kiểm tra, nếu mã phiếu xuất mới đó chưa
--tồn tại trong bảng phiếu xuất thì CSDL sẽ không cho phép nhập và 
--thông báo lỗi “Phiếu xuất này không tồn tại”. Hãy viết 1 trigger 
--đảm bảo điều này.
create trigger c6_3 on ctpx
for insert 
as
begin
	declare @mapx varchar(5)
	select @mapx=mapx from inserted
	if not exists (select px.* from PHIEUXUAT px,inserted i
		where px.MAPX=i.MAPX and i.MAPX=@mapx)
	begin
		raiserror ('phieu xuat  KHONG TON TAI',16,1)
		-- Dùng print cũng ok
		rollback tran
	end
END

INSERT INTO CTPX VALUES(9,4,12)
INSERT INTO CTPX VALUES(7,4,12)
select * from CTPX
select * from PHIEUXUAT
select * from SANPHAM	
















