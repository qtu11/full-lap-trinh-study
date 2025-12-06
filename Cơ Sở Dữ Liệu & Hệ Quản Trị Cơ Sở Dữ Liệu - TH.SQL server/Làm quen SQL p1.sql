--lệnh chọn database 
--use ten database
select makh as [mã khách hàng],tenkh as 'tên khách hàng',diachi,dt,email
from khachhang
where tenkh like N'%thị%'

select *
from khachhang
where dt is NULL and email is NULL

select vattu
where giamua between 20 and 40

select k.tenkh,diachi,dt,convert(varchar (10),ngay,103) as ngay
from khachhang k,hoadon h,
where k.makh = h.makh and month(ngay) = 6 and year(ngay)=2010

-- tối ưu nhất
select  k.makh,tenkh,diachi
from khachhang k inner join hoadon h on k.makh = h.makh
group by k.makh,tenkh,diachi

-- dễ viết hơn
select distinct k.makh,tenkh,diachi
from khachhang k hoadon h on k.makh = h.makh

-- right join là lấy trùng bên phải tồn tại
select  k.makh,tenkh,diachi
from khachhang k right join hoadon h on k.makh = h.makh

-- Tìm ra những mặt hàng chưa bán được
select * from vattu
select * from cthd

select * from vattu
where mavt not in(select mavt from cthd)

select * from vattu
where mavt not exists(select mavt from cthd where vattu.mavt = cthd.mavt)

-- đếm xem mỗi khách hàng có bao nhiêu hóa đơn
select makh,count(*) as 'Số hóa đơn'
from hoadon h,khachhang k
where k.makh =h.makh 
group by k.makh,tenkh

-- Lấy ra thông tin của khách hàng có số hóa đơn nhiều nhất
select top 1 with ties makh,count(*) as 'Số hóa đơn'
from hoadon h,khachhang k
where k.makh =h.makh 
group by k.makh,tenkh
order by count (*) -- mặc định xapxep tăng dần
				desc 
	-- cách 2
select makh,count(*) as 'Số hóa đơn'
from hoadon h,khachhang k
where k.makh =h.makh 
group by k.makh,tenkh
having count(*) >= all(select cou(*)
						from hoadonh,khachhang k
						where k.makh = h.makh
						group by k.makh,tenkh )

-- đếm xem mỗi khách hàng mỗi tháng có bao nhiêu hóa đơn
select k.makh,tenkh,month(ngay) as 'Tháng',count(*) as 'SỐ hÓA ĐƠn'
from hoadon h,khachhang k
where
group by k.makh,tenkh,month(ngay)

--đếm có bao nhiêu khách hàng 
select count(*)
from khachhang

-- Tìm ra những hóa đơn cùng ngày mua 
select h1.mahd,h1.ngay -- có thể dùng distinct
from hoadon h1,hoadon h2
where h1.mahd <> h2.mahd and h1.ngay=h2.ngay
