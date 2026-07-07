/*
USE sql_invoicing
GO 
CREATE OR ALTER VIEW sales_by_clients AS

--مجموع فروش برای هر مشتری


SELECT 
	name,
	C.client_id ,
	SUM(invoice_total) AS TOTAL_SALES

FROM clients C
JOIN invoices I
	ON C.client_id =I.client_id
GROUP BY 
	C.client_id,
	name

*/
-- بعد از اجرا کردن ،در قسمت ویوز همین دیتابیس ویو مورد نظر ایجاد میشود
--حال میتوان از ان به عنوان یک جدول مجازی استفاده کرد


/*
SELECT *
FROM dbo.sales_by_clients
WHERE TOTAL_SALES >500
ORDER BY TOTAL_SALES DESC
SELECT DB_NAME()*/


--برای پاک کردن
--DROP VIEW sales_by_clients 

--Updatable View
/*
USE sql_invoicing
GO
CREATE  OR ALTER VIEW invoices_with_balance AS

SELECT 
	invoice_id,
	number,
	client_id,
	invoice_total,
	payment_total ,
	invoice_total- payment_total AS balance,
	invoice_date,
	due_date,
	payment_date
FROM invoices
WHERE (invoice_total - payment_total )>0

--با این دستور دیگر نمیتوان سطری را حدف کرد
WITH CHECK OPTION
*/
/*
--حذف کردن
DELETE FROM invoices_with_balance
WHERE invoice_id =1
*/
/*
--آپدیت کردن
UPDATE invoices_with_balance
SET due_date = DATEADD(DAY,10,GETDATE())
WHERE invoice_id = 2
*/

