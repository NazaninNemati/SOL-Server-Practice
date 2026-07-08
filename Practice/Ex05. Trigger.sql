USE sql_invoicing
GO;
/*==========================================================
سوال 1 (آسان)

یک Trigger از نوع AFTER INSERT روی جدول clients بنویس.

بعد از ثبت هر مشتری جدید، پیام زیر را چاپ کند:

New Client Added

راهنمایی:
از AFTER INSERT استفاده کن.

==========================================================*/
CREATE  OR ALTER TRIGGER clients_after_insert
	ON clients

AFTER INSERT
AS

BEGIN
	PRINT 'New Client Added :)'
END

--تست کردن 
INSERT INTO clients(client_id,name,address,city,state,phone)
VALUES (6,'Sara','US','San Francisco' ,'CA',0952146112)


GO
/*==========================================================
سوال 2 (آسان)

یک Trigger از نوع AFTER DELETE روی جدول clients بنویس.

بعد از حذف مشتری، پیام زیر را چاپ کند:

Client Deleted

==========================================================*/

CREATE OR ALTER TRIGGER clients_after_delete
	ON clients
AFTER DELETE
AS
BEGIN
	PRINT 'Client Deleted :('
END


GO


/*==========================================================
سوال 3 متوسط)

یک Trigger از نوع AFTER UPDATE روی جدول clients بنویس.

اگر شماره تلفن مشتری تغییر کرد، پیام زیر را چاپ کند:

Phone Updated

راهنمایی:
از جدول inserted و deleted استفاده کن.

==========================================================*/
CREATE OR ALTER TRIGGER clients_after_update
	ON clients
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS (
		SELECT 1 
		FROM inserted I
		JOIN deleted D
			ON D.client_id = I.client_id
		WHERE I.phone <> D.phone
	)BEGIN
		PRINT 'Phone Updated'
	 END


END

GO

/*==========================================================
سوال 4 (آسان)

یک Trigger روی جدول invoices بنویس.

بعد از INSERT شدن یک فاکتور، تعداد رکوردهای جدول invoices را نمایش بده.

راهنمایی:
از COUNT(*) استفاده کن.

==========================================================*/

CREATE OR ALTER TRIGGER invoices_after_insert
	ON invoices
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT COUNT(*) AS count_of_records
	FROM invoices
END

--تست
INSERT INTO invoices(invoice_id,client_id,number,invoice_total,invoice_date,payment_date,due_date)
VALUES (50,1,'8458380',210.7,'2025-02-11','2025-09-11','2026-01-01')


GO
/*==========================================================
--****
سوال 5 (متوسط)

یک Trigger روی جدول invoices بنویس.

اگر invoice_total کمتر از صفر باشد،

اجازه ثبت رکورد را نده.

پیام:

Invoice Total Cannot Be Negative

راهنمایی:
از INSTEAD OF INSERT یا ROLLBACK TRANSACTION استفاده کن.

==========================================================*/

CREATE OR ALTER TRIGGER invoices_instead_of_insert
	ON invoices
INSTEAD OF INSERT

AS
BEGIN
	SET NOCOUNT ON;

		IF EXISTS(
		SELECT *
		FROM inserted
		WHERE invoice_total < 0
		)
		BEGIN
			PRINT  'Invoice Total Cannot Be Negative'
			ROLLBACK TRANSACTION 
		END

		ELSE
		BEGIN
			INSERT INTO invoices(
				invoice_id,
				client_id,
				number,
				invoice_total,
				invoice_date,
				payment_date,
				due_date
			)
			SELECT
				invoice_id,
				client_id,
				number,
				invoice_total,
				invoice_date,
				payment_date,
				due_date
			FROM inserted;			
		END
END

-- نباید ثبت شود
INSERT INTO invoices
(
    invoice_id,
    client_id,
    number,
    invoice_total,
    invoice_date,
    payment_date,
    due_date
)
VALUES
(
    51,
    1,
    '1001',
    500,
    '2025-01-01',
    '2025-01-02',
    '2025-02-01'
);

GO



/*==========================================================
سوال 6 (متوسط)

یک Trigger روی جدول invoices بنویس.

اگر payment_total از invoice_total بیشتر بود،

عملیات را لغو کن.

پیام:

Payment Cannot Be Greater Than Invoice Total

راهنمایی:
از inserted استفاده کن.

==========================================================*/
CREATE OR ALTER TRIGGER invoices_insted_of_update
	ON invoices
INSTEAD OF UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS(
		SELECT 1
		FROM inserted
		WHERE payment_total > invoice_total
	
	
	)
	BEGIN
		PRINT 'Payment Cannot Be Greater Than Invoice Total'
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		UPDATE I
        SET
            payment_total = INSR.payment_total,
            invoice_total = INSR.invoice_total,
            client_id = INSR.client_id,
            invoice_date = INSR.invoice_date,
            payment_date = INSR.payment_date,
            due_date = INSR.due_date,
            number = INSR.number
        FROM invoices I
        JOIN inserted INSR
            ON I.invoice_id = INSR.invoice_id;
		
	END
END


GO
/*==========================================================
سوال 7 (متوسط)

یک Trigger روی جدول clients بنویس.

اگر مشتری‌ای که قرار است حذف شود فاکتور داشته باشد،

اجازه حذف را نده.

پیام:

Cannot Delete Client

راهنمایی:
از deleted و جدول invoices استفاده کن.

==========================================================*/
CREATE OR ALTER TRIGGER clieants_instead_of_delete
	ON clients
INSTEAD OF DELETE
AS
BEGIN
	IF EXISTS(
	SELECT 1
	FROM deleted D
	JOIN invoices I
		ON D.client_id = I.client_id
	--WHERE D.client_id = I.client_id
	)
	BEGIN
		PRINT 'Cannot Delete Client';
		ROLLBACK TRANSACTION;
	END

	ELSE
	BEGIN
		DELETE C 
		FROM clients C
		JOIN deleted D
			ON D.client_id =C.client_id
		WHERE C.client_id = D.client_id

	END

END




/*==========================================================
سوال 8 (متوسط)

یک Trigger روی جدول invoices بنویس.

بعد از UPDATE شدن invoice_total،

اگر مبلغ جدید بیشتر از مبلغ قبلی بود،

پیام زیر را چاپ کن:

Invoice Increased

راهنمایی:
جدول inserted و deleted را با هم JOIN کن.

==========================================================*/









/*==========================================================
سوال 9 (متوسط)

یک Trigger روی جدول invoices بنویس.

بعد از DELETE شدن فاکتور،

شناسه فاکتور حذف شده (invoice_id) را نمایش بده.

راهنمایی:
از جدول deleted استفاده کن.

==========================================================*/


/*==========================================================
سوال 10 (متوسط)

یک Trigger روی جدول invoices بنویس.

اگر هنگام INSERT یا UPDATE مقدار payment_total برابر NULL بود،

به صورت خودکار مقدار آن را صفر قرار بده.

راهنمایی:
از inserted استفاده کن.
می‌توانی از INSTEAD OF Trigger استفاده کنی.

==========================================================*/