USE sql_invoicing
GO;


-- ==========================================
-- Subquery in SELECT (30-21) ← آسان تا متوسط
-- ==========================================

-- 30. کنار هر مشتری، تعداد فاکتورهای او را نمایش بده.

SELECT * ,
	(
	SELECT COUNT(*) 
	FROM invoices I
	WHERE I.client_id = C.client_id --کورولیشن داریم
	) AS invoice_count
FROM clients C


-- 29. کنار هر مشتری، مجموع مبلغ فاکتورهای او را نمایش بده.

SELECT *,
	(
	SELECT SUM(invoice_total) 
	FROM invoices I
	WHERE I.client_id = C.client_id
	) AS total_invoices


FROM clients C


-- 28. کنار هر مشتری، میانگین مبلغ فاکتورهای او را نمایش بده.

SELECT *,
	(SELECT AVG (invoice_total) 
	FROM invoices I 
	WHERE I.client_id = C.client_id
	) AS average_invoices
FROM clients C

-- 27. کنار هر مشتری، بیشترین مبلغ فاکتور او را نمایش بده.
SELECT *,
	(SELECT MAX(invoice_total) 
	FROM invoices I
	WHERE I.client_id =C.client_id
	) AS max_invoices
FROM clients C



-- 26. کنار هر مشتری، کمترین مبلغ فاکتور او را نمایش بده.
SELECT *,
	(
	SELECT MIN (invoice_total)
	FROM invoices I
	WHERE I.client_id = C.client_id
	) AS min_invoices
FROM clients C


-- 25. کنار هر مشتری، آخرین تاریخ فاکتور او را نمایش بده.

SELECT *,
	(
	 SELECT MAX(invoice_date)
	 FROM invoices I 
	 WHERE I.client_id = C.client_id
	) AS max_invoice_date
FROM clients C



-- 24. کنار هر مشتری، اولین تاریخ فاکتور او را نمایش بده.

SELECT *,
	(
	SELECT MIN (invoice_date)
	FROM invoices I 
	WHERE I.client_id = C.client_id
	) AS min_invoice_date
FROM clients C


-- 23. کنار هر فاکتور، تعداد فاکتورهای همان مشتری را نمایش بده.

SELECT *,
	(SELECT COUNT(client_id)
	FROM invoices I2
	WHERE I2.client_id = I1.client_id
	) AS count_invoices_of_clients
FROM  invoices I1



-- 22. کنار هر فاکتور، میانگین مبلغ فاکتورهای همان مشتری را نمایش بده.

SELECT *,
	(
	SELECT AVG(invoice_total)
	FROM invoices I2
	WHERE I1.client_id = I2.client_id
	) AS average_invoice_of_clients
FROM invoices I1


-- 21. کنار هر فاکتور، بیشترین مبلغ فاکتورهای همان مشتری را نمایش بده.


SELECT *,
	(
	SELECT MAX(invoice_total)
	FROM invoices I2
	WHERE I1.client_id = I2.client_id
	) AS max_invoice_of_clients
FROM invoices I1


-- ==========================================
-- EXISTS (20-11) ← آسان تا متوسط
-- ==========================================

-- 20. مشتریانی را نمایش بده که حداقل یک فاکتور دارند.

SELECT *
FROM clients C
WHERE EXISTS(
	SELECT *
	FROM invoices I
	WHERE C.client_id = I.client_id
)

-- 19. مشتریانی را نمایش بده که هیچ فاکتوری ندارند.
SELECT *
FROM clients C
WHERE  NOT EXISTS (
	SELECT *
	FROM invoices I
	WHERE I.client_id = C.client_id
)

-- 18. فاکتورهایی را نمایش بده که پرداخت شده‌اند.

SELECT *
FROM invoices I1
WHERE EXISTS (
	SELECT *
	FROM invoices I2
	WHERE I1.invoice_total = I2.payment_total
)


-- 17. فاکتورهایی را نمایش بده که پرداخت نشده‌اند.
SELECT *
FROM invoices I1
WHERE  NOT EXISTS (
	SELECT *
	FROM invoices I2
	WHERE I2.invoice_total = I1.payment_total
)



-- 16. مشتریانی را نمایش بده که حداقل یک پرداخت انجام داده‌اند.
SELECT *
FROM clients C
WHERE EXISTS(
	SELECT *
	FROM invoices I
	WHERE C.client_id = I.client_id AND payment_total != 0
)


-- 15. مشتریانی را نمایش بده که هیچ پرداختی انجام نداده‌اند.
--*****
SELECT *
FROM clients C
WHERE NOT EXISTS(
	SELECT *
	FROM invoices I
	WHERE I.client_id =C.client_id AND  payment_total != 0
)



-- 14. روش‌های پرداختی را نمایش بده که حداقل یک بار استفاده شده‌اند.
SELECT *
FROM payment_methods P_M
WHERE EXISTS (
	SELECT *
	FROM payments P
	WHERE P_M.payment_method_id = P.payment_method
)


-- 13. روش‌های پرداختی را نمایش بده که هیچ‌وقت استفاده نشده‌اند.
SELECT *
FROM payment_methods P_M
WHERE NOT EXISTS(
	SELECT *
	FROM payments P
	WHERE P.payment_method = P_M.payment_method_id 
)

-- 12. مشتریانی را نمایش بده که حداقل یک فاکتور با مبلغ بیشتر از 200 دارند.
SELECT *
FROM clients C
WHERE EXISTS(
	SELECT *
	FROM invoices I
	WHERE C.client_id = I.client_id AND invoice_total >200
)

-- 11. مشتریانی را نمایش بده که حداقل یک فاکتور در سال 2019 دارند.

SELECT *
FROM clients C
WHERE EXISTS (
	SELECT *
	FROM invoices I
	WHERE  C.client_id = I.client_id AND  YEAR(invoice_date) = 2019

)




-- ==========================================
-- Correlated Subquery (10-1) ← آسان تا متوسط
-- ==========================================

-- 10. فاکتورهایی را نمایش بده که مبلغشان از میانگین فاکتورهای همان مشتری بیشتر باشد.

SELECT *
FROM invoices I
WHERE invoice_total >(
	SELECT AVG(invoice_total)
	FROM invoices I2
	WHERE I2.client_id = I.client_id

)

-- 9. فاکتورهایی را نمایش بده که مبلغشان از میانگین فاکتورهای همان مشتری کمتر باشد.

SELECT *
FROM invoices I
WHERE invoice_total < (
	SELECT AVG(invoice_total)
	FROM invoices I1
	WHERE I1.client_id =I.client_id

)



-- 8. برای هر مشتری، گران‌ترین فاکتور را نمایش بده.
-- بدون جوین  
SELECT 
	client_id,
	C.name,
	(
	SELECT MAX(invoice_total)
	FROM invoices I
	WHERE I.client_id = C.client_id
	) AS max_invoice
FROM clients C


--با جوین
SELECT DISTINCT
	C.client_id,
	C.name AS client_name,
	(
	SELECT MAX(invoice_total)
	FROM invoices I2
	WHERE I2.client_id = I.client_id
	) AS max_invoice

FROM clients C
JOIN invoices I
	ON C.client_id =I.client_id;





-- 7. برای هر مشتری، ارزان‌ترین فاکتور را نمایش بده.

SELECT DISTINCT
	C.client_id,
	(
	SELECT MIN(invoice_total)
	FROM invoices I2
	WHERE I2.client_id = C.client_id
	) AS min_invoice

FROM clients C




-- 6. مشتریانی را نمایش بده که حداقل یک فاکتور بالاتر از میانگین فاکتورهای خود دارند.
-- بدون جوین با EXISTS

SELECT *
FROM clients C
WHERE EXISTS (
	SELECT 1
	FROM invoices I1
	WHERE I1.client_id = C.client_id 
		AND  
		invoice_total  > (
			SELECT AVG(invoice_total)
			FROM invoices I2
			WHERE I2.client_id =C.client_id
	
		)
)






--با جوین
SELECT 
	C.client_id,
	name AS client_name,
	STRING_AGG( invoice_total,' , ') AS total_ivoice_more_than_average,
	AVG (invoice_total) AS average_invoice

FROM clients C

JOIN invoices I
	ON I.client_id = C.client_id

WHERE invoice_total > (
	SELECT AVG(invoice_total)
	FROM invoices I2
	WHERE I2.client_id = I.client_id 
)

GROUP BY C.client_id,name

-- 5. فاکتورهایی را نمایش بده که مبلغشان با بیشترین مبلغ فاکتور همان مشتری برابر باشد.

SELECT *
FROM invoices I1
WHERE invoice_total = (
	SELECT MAX(invoice_total)
	FROM invoices I2
	WHERE I2.client_id = I1.client_id
)



-- 4. فاکتورهایی را نمایش بده که مبلغشان با کمترین مبلغ فاکتور همان مشتری برابر باشد.


SELECT *
FROM invoices I1
WHERE invoice_total = (
	SELECT MIN(invoice_total)
	FROM invoices I2
	WHERE I2.client_id = I1.client_id

)

-- 3. فاکتورهایی را نمایش بده که تاریخ آن‌ها آخرین تاریخ فاکتور همان مشتری باشد.
SELECT *
FROM invoices I1
WHERE invoice_date = (
	SELECT MAX(invoice_date)
	FROM invoices I2
	WHERE I2.client_id = I1.client_id
)


-- 2. فاکتورهایی را نمایش بده که تاریخ آن‌ها اولین تاریخ فاکتور همان مشتری باشد.
SELECT *
FROM invoices I1
WHERE invoice_date =(
	SELECT MIN(invoice_date)
	FROM invoices I2
	WHERE I2.client_id = I1.client_id
)



-- 1. مشتریانی را نمایش بده که بیش از یک فاکتور دارند و یکی از فاکتورهایشان از میانگین فاکتورهای خودشان بیشتر است.
SELECT 
	C.client_id,
	C.name AS 'client_name',
	invoice_id,
	invoice_total
FROM clients C
JOIN invoices I1
	ON I1.client_id = C.client_id
WHERE  1 < (
	SELECT COUNT(invoice_id)
	FROM invoices I2
	WHERE I2.client_id = I1.client_id 
	)
	AND 
	invoice_total > (
	SELECT AVG(invoice_total)
	FROM invoices I3
	WHERE I3.client_id = I1.client_id
	
	)
ORDER BY C.client_id





