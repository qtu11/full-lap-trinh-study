USE QUANLYBANHANG
--1.	Hiển thị danh sách các khách hàng có địa chỉ là “Tân Bình” gồm mã khách hàng, 
--tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
SELECT MAKH AS [Mã khách hàng],TENKH as 'Tên khách hàng', DIACHI, DT, EMAIL
FROM KHACHHANG
WHERE DIACHI=N'TÂN BÌNH'
--
SELECT MAKH AS [Mã khách hàng],TENKH as 'Tên khách hàng', DIACHI, DT, EMAIL
FROM KHACHHANG
WHERE TENKH LIKE N'%THỊ%'
--2.	Hiển thị danh sách các khách hàng gồm các thông tin mã khách hàng, 
--tên khách hàng, địa chỉ và địa chỉ E-mail của những khách hàng chưa có số điện thoại.
SELECT *
FROM KHACHHANG 
WHERE DT IS NULL

--3.	Hiển thị danh sách các khách hàng chưa có số điện thoại và cũng chưa có địa chỉ Email gồm mã khách hàng, tên khách hàng, địa chỉ.
SELECT MAKH,TENKH,DIACHI
FROM KHACHHANG 
WHERE DT IS NULL AND EMAIL IS NULL
--4.	Hiển thị danh sách các khách hàng đã có số điện thoại và địa chỉ E-mail gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
--5.	Hiển thị danh sách các vật tư có đơn vị tính là “Cái” gồm mã vật tư, tên vật tư và giá mua.
--6.	Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua trên 25000.
--7.	Hiển thị danh sách các vật tư là “Gạch” (bao gồm các loại gạch) gồm mã vật tư, tên vật tư, đơn vị tính và giá mua.
--8.	Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà 
--có giá mua nằm trong khoảng từ 20000 đến 40000.
SELECT *
FROM VATTU
WHERE GIAMUA BETWEEN 20000 AND 40000

--9.	Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại.
--10.	Lấy ra các thông tin gồm Mã hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của ngày 25/5/2010.
--11.	Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của những hóa đơn trong tháng 6/2010.
--12.	Lấy ra danh sách những khách hàng (tên khách hàng, địa chỉ, số điện thoại) 
--đã mua hàng trong tháng 6/2010.
SELECT K.MAKH, TENKH,DIACHI,DT, CONVERT(VARCHAR(10),NGAY,103) AS NGAY
FROM KHACHHANG K, HOADON H
WHERE K.MAKH=H.MAKH AND MONTH(NGAY)=6 AND YEAR(NGAY)=2010
--
SELECT  K.MAKH,TENKH,DIACHI --distinct
FROM KHACHHANG K LEFT JOIN HOADON H ON K.MAKH =H.MAKH
GROUP BY K.MAKH,TENKH,DIACHI
--
SELECT  K.MAKH,TENKH,DIACHI --distinct
FROM KHACHHANG K RIGHT JOIN HOADON H ON K.MAKH =H.MAKH
GROUP BY K.MAKH,TENKH,DIACHI
--
SELECT  K.MAKH,TENKH,DIACHI --distinct
FROM KHACHHANG K FULL JOIN HOADON H ON K.MAKH =H.MAKH
GROUP BY K.MAKH,TENKH,DIACHI

SELECT * FROM KHACHHANG

SELECT * FROM HOADON
--
SELECT  K.MAKH,TENKH,DIACHI --distinct
FROM KHACHHANG K INNER JOIN HOADON H ON K.MAKH =H.MAKH
GROUP BY K.MAKH,TENKH,DIACHI
--

SELECT DISTINCT K.MAKH,TENKH,DIACHI 
FROM KHACHHANG K, HOADON H
WHERE K.MAKH =H.MAKH



--13.	Lấy ra danh sách những khách hàng không mua hàng trong tháng 6/2010 gồm các thông tin tên khách hàng, địa chỉ, số điện thoại.
--14.	Lấy ra các chi tiết hóa đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng).
--15.	Lấy ra các chi tiết hóa đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng) mà có giá bán lớn hơn hoặc bằng giá mua.
--16.	Lấy ra các thông tin gồm mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng) và cột khuyến mãi với khuyến mãi 10% cho những mặt hàng bán trong một hóa đơn lớn hơn 100.
--17.	Tìm ra những mặt hàng chưa bán được.
SELECT MAVT,TENVT,DVT,GIAMUA,SLTON
FROM VATTU
WHERE MAVT NOT IN(SELECT MAVT FROM CTHD)
--
SELECT MAVT,TENVT,DVT,GIAMUA,SLTON
FROM VATTU
WHERE NOT EXISTS(SELECT MAVT FROM CTHD WHERE VATTU.MAVT=CTHD.MAVT)

SELECT * FROM VATTU
SELECT * FROM CTHD

--18.	Tạo bảng tổng hợp gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
--19.	Tạo bảng tổng hợp tháng 5/2010 gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
--20.	Tạo bảng tổng hợp quý 1 – 2010 gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
--21.	Lấy ra danh sách các hóa đơn gồm các thông tin: Số hóa đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn.
--22.	Lấy ra hóa đơn có tổng trị giá lớn nhất gồm các thông tin: Số hóa đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn.
--23.	Lấy ra hóa đơn có tổng trị giá lớn nhất trong tháng 5/2010 gồm các thông tin: Số hóa đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn.
--24.	Đếm xem mỗi khách hàng có bao nhiêu hóa đơn.
SELECT K.MAKH,TENKH, COUNT(*)AS 'Số hóa đơn'
FROM HOADON H, KHACHHANG K
WHERE K.MAKH=H.MAKH
GROUP BY K.MAKH,TENKH

SELECT * FROM HOADON
SELECT * FROM KHACHHANG
--Tìm ra những hóa đơn có cùng ngày mua
select distinct h1.mahd,h1.ngay
from HOADON h1, HOADON h2
where h1.MAHD<>h2.MAHD and h1.NGAY=h2.NGAY
--25.	Đếm xem mỗi khách hàng, mỗi tháng có bao nhiêu hóa đơn.
SELECT K.MAKH,TENKH, MONTH(NGAY) AS 'THÁNG', COUNT(*)AS 'Số hóa đơn'
FROM HOADON H, KHACHHANG K
WHERE K.MAKH=H.MAKH 
GROUP BY K.MAKH,TENKH,MONTH(NGAY)

--26.	Lấy ra các thông tin của khách hàng có số lượng hóa đơn mua hàng nhiều nhất.
SELECT TOP 1 WITH TIES K.MAKH,TENKH, COUNT(*)AS 'Số hóa đơn'
FROM HOADON H, KHACHHANG K
WHERE K.MAKH=H.MAKH
GROUP BY K.MAKH,TENKH
ORDER BY COUNT(*) DESC
--C2
SELECT K.MAKH,TENKH, COUNT(*)AS 'Số hóa đơn'
FROM HOADON H, KHACHHANG K
WHERE K.MAKH=H.MAKH
GROUP BY K.MAKH,TENKH
HAVING COUNT(*)>=ALL(SELECT COUNT(*)
						FROM HOADON H, KHACHHANG K
						WHERE K.MAKH=H.MAKH
						GROUP BY K.MAKH,TENKH)
--27.	Lấy ra các thông tin của khách hàng có số lượng hàng mua nhiều nhất.
--28.	Lấy ra các thông tin về các mặt hàng mà được bán trong nhiều hóa đơn nhất.
--29.	Lấy ra các thông tin về các mặt hàng mà được bán nhiều nhất.
--30.	Lấy ra danh sách tất cả các khách hàng gồm Mã khách hàng, tên khách hàng, địa chỉ, số lượng hóa đơn đã mua (nếu khách hàng đó chưa mua hàng thì cột số lượng hóa đơn để trống)
