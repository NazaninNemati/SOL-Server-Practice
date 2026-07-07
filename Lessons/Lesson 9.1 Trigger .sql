USE sql_invoicing
GO

/*
-- لاگ گرفتن
DROP TABLE IF EXISTS payments_audit
CREATE TABLE payments_audit
(
	client_id      INT			    NOT NULL,
	date           DATE			    NOT NULL,           
	amount		   DECIMAL(9,2)	    NOT NULL,
	action_type	   VARCHAR(50)		NOT NULL,
	action_date	   DATETIME			NOT NULL,

)
*/

--2 delete
DROP TRIGGER IF EXISTS payments_after_delete 
GO

CREATE TRIGGER payments_after_delete
ON payments
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE i
    SET i.payment_total = i.payment_total - d.amount
    FROM invoices AS i
    INNER JOIN deleted AS d
        ON i.invoice_id = d.invoice_id;

    INSERT INTO payments_audit
    (
        client_id,
        date,
        amount,
        action_type,
        action_date
    )
    SELECT
        client_id,
        date,
        amount,
        'Delete',
        GETDATE()
    FROM deleted;
END
GO

--1 insert
DROP TRIGGER IF EXISTS payments_after_insert 
GO

CREATE TRIGGER payments_after_insert
ON payments
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- آپدیت مبلغ پرداختی فاکتور
    UPDATE i
    SET i.payment_total = i.payment_total + ins.amount
    FROM invoices AS i
    INNER JOIN inserted AS ins
        ON i.invoice_id = ins.invoice_id;

    -- ثبت لاگ
    INSERT INTO payments_audit
    (
        client_id,
        date,
        amount,
        action_type,
        action_date
    )
    SELECT
        client_id,
        date,
        amount,
        'Insert',
        GETDATE()
    FROM inserted;
END
GO


/*
--حال چک مکینیم همچی درست کار میکنه یا نه

INSERT INTO payments(
      client_id,
	  invoice_id,
	  date,
	  amount,
	  payment_method)

VALUES (5,3,'2026-01-01',10,1);



DELETE FROM payments
WHERE payment_id =11


*/

























--حذف تریگر
--DROP TRIGGER IF EXISTS patment_after_delete;
/*
--مشاهده تریگر ها

SELECT *
FROM sys.triggers



--فقط تریگر های مربوط ب پیمنت به من نمایش داده بشه
--وقتی که از الگوی نامگذاری استفاده کنیم میتونیم دستور زیر رو اجرا کنیم

SELECT *
FROM sys.triggers
WHERE name LIKE '%insert'--'payment%'
*/

--2
/*
CREATE OR ALTER TRIGGER patment_after_delete
	ON payments
AFTER DELETE 

AS

BEGIN
	SET NOCOUNT ON;

	UPDATE i
	SET i.payment_total = i.payment_total - d.amount
	FROM invoices i
	INNER JOIN deleted d
		ON i.invoice_id = d.invoice_id

END
GO
*/

/*
--حذف رکوردی ک در مثال قبل اضافه کرده بودیم
DELETE 
FROM payments
WHERE payment_id = 9;
*/

/*
--1

CREATE TRIGGER payment_after_insert
	ON payments

AFTER INSERT 

AS

BEGIN
	SET NOCOUNT ON;


	UPDATE i
	SET i.payment_total = i.payment_total + ins.amount
	FROM invoices i 
	INNER JOIN inserted AS ins
		ON i.invoice_id = ins.invoice_id

END
GO
*/

/*
--اینسرت رکورد جدید تا چک کنیم تریگز اجرا میشه یا نه
USE sql_invoicing
INSERT INTO payments(
      client_id,
	  invoice_id,
	  date,
	  amount,
	  payment_method)

VALUES (5,3,'2026-01-01',10,1)

*/
