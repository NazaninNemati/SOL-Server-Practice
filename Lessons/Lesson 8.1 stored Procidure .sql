USE sql_invoicing;
GO

--متغیر های محلی7

CREATE OR ALTER PROCEDURE risk_factor
AS

BEGIN
	DECLARE @risk_factor DECIMAL(9,2) = 0;
	DECLARE @invoice_total DECIMAL(9,2) ;
	DECLARE @invoice_count INT;

	SELECT 
	invoice_count = COUNT(*),
	 invoice_total = SUM(invoice_total)
	FROM invoices;


	SET @risk_factor = @invoice_total/@invoice_count;

	SELECT @risk_factor AS risk_factor;

END




/*
--6
--اعتبار سنجی داده ها
CREATE OR ALTER PROCEDURE make_payment
	@invoice_id INT,
	@payment_amount DECIMAL(9,2),
	@payment_date DATE
	
AS
BEGIN 
	IF @payment_amount <= 0
		 THROW  50001, 'payment amount must be gteater than zero',1
		

	UPDATE invoices 
	SET 
		payment_total = @payment_amount,
		payment_date = @payment_date
	WHERE invoice_id = @invoice_id

END

GO
*/


/*
--5
----میخواهیم یک پروسیژر ایجاد کنیم برای بروزرسانی اینویس
CREATE OR ALTER PROCEDURE make_payment
	@invoice_id INT,
	@payment_amount DECIMAL(9,2),
	@payment_date DATE
	
AS
--حال میخواهیم یک اینویس براساس ورودی که دریافت میکنه آپدیت بشه

BEGIN 
	UPDATE invoices 
	SET 
		payment_total = @payment_amount,
		payment_date = @payment_date
	WHERE invoice_id = @invoice_id

END

GO
*/



/*
--با Alis
BEGIN 
	UPDATE i
	SET 
		payment_total = @payment_amount,
		payment_date = @payment_date
		FROM invoices AS i
	WHERE invoice_id = @invoice_id



END

GO
*/










--4 
--حال اگر نال بود همه کلاینت ها رو برگردانیم
/*
--روش 2 راه قدرتمند تر
CREATE OR ALTER PROCEDURE get_client_with_state
	@state CHAR(2) = NULL
AS

BEGIN 
	SELECT * FROM clients C
	WHERE C.state = ISNULL(@state ,C.state)

END

*/




/*
-- روش 1 راه حل ابتدایی
CREATE OR ALTER PROCEDURE get_client_with_state
	@state CHAR(2) = NULL
AS

BEGIN

	IF @state IS NULL 
		SELECT * FROM clients;
	ELSE
	SELECT * FROM clients C
	WHERE C.state = @state

END

*/



--3
--اگر موقع صدا زدن پروسیژر مقداری که برای پارامتر ارسال میشه نال بود بصورت دیفالت کلاینت های ایالت کالیفرنیا برگشت داده بشن



/*
CREATE OR ALTER PROCEDURE dbo.get_client 

	@state CHAR(2) = 'CA'

AS

BEGIN 
	IF @state IS NULL 
		SET @state = 'CA' 

	SELECT *
	FROM clients C
	WHERE C.state = @state ;
	
END

GO

*/

/*
CREATE OR ALTER PROCEDURE dbo.get_client 

	@state CHAR(2) -–برای متغیر مقدار پیشفرض نال تعیین میکنیم 

AS

BEGIN 
	IF @state IS NULL 
		SET @state = 'CA' ;
	
	SELECT *
	FROM clients C
	WHERE C.state = @state ;
	
END

GO
*/










--2
--میخواهیم استور پروسیجر برای دریافت اینویس های پرداخت نشده یک کلاینت باشه 
--یعنی کلاینت ایدی بدیم و مجموع اینویس های پرداخت نشده (مقدارش) به همراه تعدادش را به ما بده. 
/*
CREATE OR ALTER PROCEDURE get_unpaid_invoices_for_client
	@client_id INT, --input parameter
	@invoice_count INT OUTPUT , -- پارامتر خروجی
	@invoice_total	DECIMAL(9,2) OUTPUT  --پارامتر خروجی
AS

BEGIN
	SELECT 
	@invoice_count = COUNT(*),
	@invoice_total = SUM(invoice_total)
	
	FROM invoices i
	WHERE I.client_id = @client_id AND payment_total = 0;
	

END;
GO
*/



/*

--1

CREATE OR ALTER PROCEDURE dbo.get_client 

@state CHAR(5) --پارامتر ورودی

AS

BEGIN 
	--SQL commands
	SELECT *
	FROM clients C
	WHERE C.state = @state ;
	
END

GO

*/












--DROP PROCEDURE get_client



















