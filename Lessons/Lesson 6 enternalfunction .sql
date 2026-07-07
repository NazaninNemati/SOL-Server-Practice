USE sql_store;

--case aparator
--اگه چند عبارت د اشته باشیم برای ارزیابی ازش استفاده میکنیم


SELECT 
	order_id,
	order_date,
	CASE 
		WHEN YEAR(order_date) = YEAR(GETDATE()) THEN 'ACTIVE'
		WHEN YEAR(order_date) = YEAR(GETDATE()) -1 THEN 'Last year'
		WHEN YEAR(order_date) < YEAR(GETDATE()) -1 THEN 'ARCHIVED'
		ELSE 'Future'
	END AS category

FROM orders







--بسته ب اینکه شرطمان درست یا غلط هست مقادیری رو برگشت بدیم
--if function
--حالت بولی داره
--میخواهیم اوردر هام رو در دو دسته اکتیو و ارکاید قرار بدم
--قبلا با استفاده از دوتا سکلت و با یونیون اومدیم دریت کردیم
--روش دیگر
-- ایف نداریم

SELECT 
	order_id,
	order_date,
	IIF( YEAR(order_date) = YEAR(GETDATE()) ,'AVTIVE','ARCHIVED' ) AS category

FROM orders

--راه بعدی

SELECT 
	order_id,
	order_date,
	CASE 
		WHEN YEAR(order_date) = YEAR(GETDATE()) THEN 'ACTIVE'
		ELSE 'ARCHIVED'
	END AS category

FROM orders



--IF NULL
--به جای فرتسان نال ب کاربر یک چیز دیگ بنویسیم
USE sql_store
SELECT order_id,
	COALESCE(CAST( shipper_id AS VARCHAR(15)) ,'Not assigned') AS D,
--اگر شیپر ایدی نال بود از ستون کامنت استفاده کن برای رو قرار بده اگر کامنت هم نال بود نات اساینت رو بزار

	COALESCE(CAST( shipper_id AS VARCHAR(15)),comments ,'Not assigned') AS D
     --ISNULL(shipper_id AS VARCHAR(15) ,'Not assigned') 
FROM orders;




---------------------------------
--3 date /time


--محاسبه تفاوت تاریخ ها
SELECT DATEDIFF(DAY,'2019-01-2','2020-04-11'),
	 DATEDIFF(YEAR,'2019-01-2',GETDATE()),
	 DATEDIFF(MINUTE,GETDATE()-2,GETDATE()),
	 DATEDIFF(HOUR,GETDATE()-2,GETDATE()),
	 DATEDIFF(MINUTE,2,30)




--انجام محاسبات روی زمان وتاریخ
SELECT DATEADD(DAY,-1,GETDATE())
SELECT DATEADD(MONTH,10,GETDATE())
SELECT DATEADD(YEAR,10,GETDATE())
SELECT DATEADD(HOUR,10,GETDATE())








--فرمت دهی تاریخ و زمان

SELECT 
	--فرمت دهی تاریخ
	FORMAT(GETDATE(),'M'),-- also 'm' -- June 30
	FORMAT(GETDATE(),'MMM'),--Jun
	FORMAT(GETDATE(),'MMMM'),-- June
	FORMAT(GETDATE(),'Y'),--also 'y' June 2026
	FORMAT(GETDATE(),'yyyy'),-- 2026
	FORMAT(GETDATE(),'yy'),-- 26
	FORMAT(GETDATE(),'d'),-- 6/30/2026
	FORMAT(GETDATE(),'dd'),-- 30
	FORMAT(GETDATE(),'ddd'),-- Tue 
	FORMAT(GETDATE(),'dddd'),-- Tuesday
	--فرمت دهی زمان
	FORMAT(GETDATE(),'HH'),-- 13 , 24h
	FORMAT(GETDATE(),'hh'),-- 01 , 12h
	FORMAT(GETDATE(),'mm'),-- 31 minute
	FORMAT(GETDATE(),'ss'),-- 49 second
	FORMAT(GETDATE(),'tt')-- AM,PM


SELECT FORMAT(GETDATE(),'%p%H/MMMm/*^^MMMM/yyyy/hh-HH tt')






--دریافت همه سفارش های مربوط به امسال
USE sql_store
SELECT * 
FROM orders
WHERE YEAR(order_date) >= YEAR(GETDATE())


-- روش خوبی نیست چون سال تغییر میکنه و همش باید عوضش کرد ب جای هارد کد نوشتن به صورت بالا مینویسیم
SELECT * 
FROM orders
WHERE order_date >= '2019-01-01'




--DATENAME
SELECT 
	DATENAME(MONTH,GETDATE()) AS month_name,
	DATENAME(WEEKDAY,GETDATE()) AS month_name

--DATEPART()
SELECT 
	DATEPART(YEAR,GETDATE()) AS year,
	DATEPART(MONTH,GETDATE()) AS month,
	DATEPART(WEEKDAY,GETDATE()) AS day_number,
	DATEPART(DAY,GETDATE()) AS day,
	DATEPART(HOUR,GETDATE()) AS hour,
	DATEPART(MINUTE,GETDATE()) AS minute,
	DATEPART(SECOND,GETDATE()) AS second




SELECT GETDATE() AS 'date and time ',
	CAST(GETDATE() AS DATE) AS date,
	CAST(GETDATE() AS TIME) AS time,
	YEAR(GETDATE())AS year,
	MONTH(GETDATE()) AS month,
	DAY(GETDATE()) AS day


--تاریخ و ساعت
SELECT GETDATE()

----------------------------------
--2 SRTING FUNCTIONS


--چسباندن رشته ها
SELECT CONCAT('ALI','REZA')
--EX)
SELECT CONCAT(first_name,' ',last_name) AS full_name 
FROM customers


SELECT REPLACE('ALI','L','6')

--مکان اولین رخداد یک یا چند کاراکتر(رشت یا دنباله ای از کاراکتر ها) را میدهد
SELECT CHARINDEX('NAZ ','NaZANIN')

--طول رشته
SELECT LEN('NEOMGHT')

--از سومین کاراکتر به بعد دو کاراکتر نشون بده
SELECT SUBSTRING('HELLOWE',3,2)



--فاصله هارا حذف میکند
SELECT 
	TRIM('   RGRRT   '),
	RTRIM('   RGRRT   '),
	LTRIM('   RGRRT   ')

--------------------------------------
--فانکشن های مربوط به مقادیر عددی1

--رندم تولید میکنه
SELECT RAND()
--قدر مطلق
SELECT ABS(- 2.8) 
--رند به پایین
SELECT FLOOR(2.8)
--رند به بالا
SELECT CEILING(0.1)

--عدد را رند میکند
--ROUND(numaric_expression,lenth[,function])
--فلان عدد را تا دو رقم اعشار رند کن
SELECT ROUND(3.122,2)














