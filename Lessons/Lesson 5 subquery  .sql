
--Subguery


--سابکوئری در FROM

--اصلاح کن

SELECT *
FROM(

	SELECT 
		client_id,
		name,
		invoice_total,
		average_of_invoises,
		invoice_total- average_of_invoises AS differance
	FROM(
	SELECT 
		C.client_id,
		name,
		(SELECT SUM(invoice_total) FROM invoices WHERE client_id=C.client_id ) AS invoice_total,
		(SELECT AVG(invoice_total) FROM invoices WHERE client_id=C.client_id) AS average_of_invoises
	
		FROM clients C

) AS sales_summary
WHERE total_sales IS NOT NULL5

USE sql_invoicing
--ساب کوئری در SELECT

--10کوئری روی جدول کلاینت یک گزارش 5 ستونه کلاینت آیدی، نام، مجموع فروش هر کلاینت،
--میانگین همه فروش های مربوط به هر کلاینت، تفریق ستون سوم و چهارم
SELECT 
	client_id,
	name,
	invoice_total,
	average_of_invoises,
	invoice_total- average_of_invoises AS differance
FROM(
SELECT 
	C.client_id,
	name,
	(SELECT SUM(invoice_total) FROM invoices WHERE client_id=C.client_id ) AS invoice_total,
	(SELECT AVG(invoice_total) FROM invoices WHERE client_id=C.client_id) AS average_of_invoises
	
	FROM clients C
) AS SA

/*
SELECT 
	C.client_id,
	name,
	(SELECT SUM(invoice_total) FROM invoices WHERE client_id=C.client_id ) AS invoice_total,
	(SELECT AVG(invoice_total) FROM invoices WHERE client_id=C.client_id) AS average_of_invoises
	
	FROM clients C
--برای بدست آوردن مورد اخر از این کوئری به عنوان سابکوئری استفاده میکنیم
*/
/*
--راه دیگه
SELECT 
	C.client_id,
	name,
	invoice_total,
	AVG(invoice_total) 
FROM clients C
JOIN invoices  I
	ON I.client_id = C.client_id
GROUP BY 
	C.client_id

*/





--9 آماده کردن گزارش شامل آیدی سفارش، سفارش کل، سفارش میانگین،حاصل تفریق دوم و سوم

SELECT 
	invoice_id,
	invoice_total,
	 AVG(invoice_total) OVER() AS invoice_average,
	 --راه دیگر (SELECT AVG(invoice_total) FROM invoices) AS invoice_average
	 invoice_total -  AVG(invoice_total) OVER() AS diffrance
FROM invoices






--EXISTS
--8مشتریانی که حداقل یک اینویش دارن پیدا کنیم
USE sql_invoicing


SELECT *
FROM clients C
WHERE EXISTS(
	SELECT client_id
	FROM invoices 
	WHERE client_id = C.client_id
)

SELECT *
FROM clients
WHERE client_id IN(
	SELECT DISTINCT client_id
	FROM invoices 
)


;
--Corrolation
--7میخواهیم کارمندانی را انتخاب کنیم که حقوقشان از میانگین حقوق کسانی که در دفترشان کارمیکند بیشتر باشد
USE sql_hr

SELECT *
FROM employees E
WHERE salary > (
	SELECT AVG(salary)
	FROM employees
	WHERE office_id = E.office_id
)




USE sql_invoicing
--ANY
--6 مشتریانی را سلکت کنیم که حداقل 2 تا انویس داشته باشن
SELECT *
FROM clients
WHERE client_id = ANY(
	SELECT client_id
	FROM invoices 
	GROUP BY client_id
	HAVING COUNT(invoice_id) >=2 
)


--بدون ANY
SELECT *
FROM clients
WHERE client_id IN (
	SELECT client_id
	FROM invoices 
	GROUP BY client_id
	HAVING COUNT(invoice_id) >=2 --another way COUNT(invoice_id) 
)
--5کلاینت هایی که هیچ فاکتوری ندارند دریافت کنیم ابتدا لیست یونیک ای از کلاینت ها رو بدست بیاریم

SELECT *
FROM clients
WHERE  client_id NOT IN (
	SELECT DISTINCT client_id
	FROM invoices
)

--با استفاده از جوین

SELECT *
FROM clients C
LEFT JOIN invoices I
	ON C.client_id = I.client_id
WHERE I.client_id IS NULL




--4دنبال محصولاتی هستیم که تاحلا سفارش داده نشدن
--محصولاتی ک داخل جدول سفارش ها نیستن
USE sql_store
SELECT  *
FROM products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id
	FROM order_items
	)
--با استفاده از جوین
SELECT  *
FROM products P
LEFT JOIN order_items O ON P.product_id = O.product_id
WHERE O.product_id IS NULL

---3



--2
--صورت حساب های کل ای را سلکت کنیکم که از همه صورت‌حساب هایی که مربوط به کلاینت ایدی 3 بزرگ تر باشن
USE sql_invoicing
SELECT client_id, invoice_total
FROM invoices
WHERE invoice_total > ALL (
-- صورت‌حساب هایی که کلاینت ایدی 3 دارند
SELECT invoice_total
FROM invoices
WHERE client_id = 3
)
--راه دیگه
SELECT client_id, invoice_total
FROM invoices
WHERE invoice_total >  (
-- صورت‌حساب هایی که کلاینت ایدی 3 دارند
SELECT MAX(invoice_total)
FROM invoices
WHERE client_id = 3
)
--1 همه محصولاتی که قیمتشان بیشتر از قیمت کاهو است
USE sql_store

SELECT *
FROM products
WHERE unit_price > (
	SELECT unit_price
	FROM products
	WHERE product_id = 3 --پروداکت آیدی کاهو 3 است
)

--راه دیگه












































