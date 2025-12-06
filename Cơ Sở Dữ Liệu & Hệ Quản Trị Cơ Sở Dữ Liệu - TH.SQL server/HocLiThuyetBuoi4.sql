alter  procedure SP_KHACHHANG @DIACHI nvarchar(50)  -- tuong tu proc
AS
	select *
	from KHACHHANG
	where DIACHI like @DIACHI 
-- Goi Thuc thi ( execute )
declare  @DIACHI nvarchar(50) 
set @DIACHI = N'Tân Bình'

 exec SP_KHACHHANG @diachi

ALTER PROC XOA_KHACHHANG_THEOMAKH  @MAKH NVARCHAR(20),@SOKHCL INT OUTPUT
 AS
	 DELETE KHACHHANG
	 WHERE MAKH = @MAKH
	 SELECT *
	 FROM KHACHHANG
	 SET @SOKHCL = @@ROWCOUNT
-- GOI THUC THI
DECLARE @SOKHCL INT
EXEC XOA_KHACHHANG_THEOMAKH 'kh06',@SOKHCL OUT
PRINT N'SỐ MẪU TIN CÒN LẠI: ' + STR(@SOKHCL,3)

--1.	Lấy ra danh các khách hàng đã mua hàng trong ngày X, với X là tham số truyền vào.
CREATE PROC P1 @X SMALLDATETIME
AS 
	SELECT K.MAKH,TENKH,NGAY
	FROM KHACHHANG K,HOADON H
	WHERE K.MAKH=H.MAKH AND NGAY=@X --'12-05-2010'
--
SET DATEFORMAT DMY
EXEC P1 '25-05-2010'
--2.	Lấy ra danh sách khách hàng có tổng trị giá các đơn hàng lớn hơn X (X là tham số).
CREATE PROC P2 @X BIGINT
AS
	SELECT K.MAKH,K.TENKH,SUM(SL*GIABAN) AS [TỔNG TRỊ GIÁ]	
	FROM KHACHHANG K,HOADON H, CTHD C
	WHERE K.MAKH=H.MAKH AND H.MAHD=C.MAHD
	GROUP BY K.MAKH,K.TENKH
	HAVING SUM(SL*GIABAN) > @X
-- GỌI SP
EXEC P2 1000000
--3.	Lấy ra danh sách X khách hàng có tổng trị giá các đơn hàng lớn nhất (X là tham số).
CREATE PROC P3 @X BIGINT
AS
	SELECT K.TENKH ,SUM(SL*GIABAN) AS [TỔNG TRỊ GIÁ]
	FROM KHACHHANG K,HOADON H, CTHD C
	WHERE K.MAKH=H.MAKH AND H.MAHD=C.MAHD
	GROUP BY K.MAKH,K.TENKH
	HAVING SUM(SL*GIABAN) = @X
--4.	Lấy ra danh sách X mặt hàng có số lượng bán lớn nhất (X là tham số).

--5.	Lấy ra danh sách X mặt hàng bán ra có lãi ít nhất (X là tham số).
CREATE PROC P5 @X INT	
	SELECT TOP (@X) WITH TIES V.MAVT,TENVT,SUM((GIABAN-GIAMUA)*SL) AS [LÃI]
	FROM VATTU V,CTHD C
	WHERE V.MAVT=C.MAVT
	GROUP BY V.MAVT,TENVT
	ORDER BY [LÃI]
EXEC P5 2
--6.	Lấy ra danh sách X đơn hàng có tổng trị giá lớn nhất (X là tham số).
--7.	Tính giá trị cho cột khuyến mãi như sau: Khuyến mãi 5% nếu SL > 100, 10% nếu SL > 500.
CREATE PROC P7
AS	
	UPDATE CTHD SET KHUYENMAI=(CASE WHEN SL>500 THEN 0.1
									WHEN SL >100 THEN 0.05
									ELSE 0
									END)*SL*GIABAN
-- 
EXEC P7
--8.	Tính lại số lượng tồn cho tất cả các mặt hàng (SLTON = SLTON – tổng SL bán được).
CREATE PROC P8
AS
	UPDATE VATTU
	SET SLTON=SLTON-(SELECT SUM(SL)
					FROM CTHD
					WHERE VATTU.MAVT=CTHD.MAVT
					GROUP BY MAVT)
--
EXEC P8 
--9.	Tính trị giá cho mỗi hóa đơn.
--10.	Tạo ra table KH_VIP có cấu trúc giống với cấu trúc table KHACHHANG. Lưu các khách hàng có tổng trị giá của tất cả các đơn hàng >=10.000.000 vào table KH_VIP.
SELECT *
INTO KH-VIP 
FROM KHACHHANG
