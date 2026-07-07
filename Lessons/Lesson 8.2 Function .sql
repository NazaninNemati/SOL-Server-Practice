--1ریسک فکتور را برای هر مشتری حساب کنیم
USE sql_invoicing
GO

CREATE  OR ALTER FUNCTION dbo.get_risk_factor_client (
	@client_id INT
)
RETURNS DECIMAL(9,2)
AS

BEGIN
	DECLARE @risk_factor DECIMAL(9,2)= 0;
	DECLARE @invoice_total DECIMAL(9,2) ;
	DECLARE @invoice_count INT;


	SELECT 
		@invoice_count = COUNT(*),
		@invoice_total =  ISNULL( SUM(invoice_total) ,0)
	FROM invoices I
	WHERE I.client_id = client_id

	
	SET  @risk_factor = @invoice_total/@invoice_count;

	RETURN @risk_factor;

END
GO


--اجرا کردن
 
SELECT 
	client_id,
	name,
	dbo.get_risk_factor_client(1)
	
FROM clients


















