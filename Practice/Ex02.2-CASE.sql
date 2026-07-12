/*==========================================================
سوال 1 (آسان)

تمام فاکتورها را نمایش بده.

یک ستون جدید به نام Status بساز.

اگر invoice_total بیشتر از 150 بود:

High

در غیر این صورت:

Low

راهنمایی:
از CASE داخل SELECT استفاده کن.

==========================================================*/
SELECT 
	*,
	CASE
		WHEN invoice_total > 150 THEN 'High'
		ELSE 'Low'
	END AS status

FROM invoices

/*==========================================================
سوال 2 (آسان)

تمام مشتریان را نمایش بده.

اگر state برابر 'CA' بود:

California

در غیر این صورت:

Other State

را در ستونی به نام StateName نمایش بده.

==========================================================*/
SELECT *,
	CASE 
		WHEN state = 'CA' THEN 'California'
		ELSE 'Other State'

	END AS StateName
FROM clients

/*==========================================================
سوال 3 (آسان)

تمام فاکتورها را نمایش بده.
یک ستون به نام Payment_Status بساز.
اگر payment_total برابر صفر بود:

Not Paid

در غیر این صورت:

Paid

را نمایش بده.

==========================================================*/
SELECT *,
	CASE 
		WHEN payment_total  = 0 THEN 'Not Paid'
		ELSE 'Paid'
	END AS 'Payment_Status'

FROM invoices

/*==========================================================
سوال 4 (آسان)

تمام فاکتورها را نمایش بده.
یک ستون به نام invoice_status بساز.
اگر invoice_total بزرگتر از payment_total بود:

Unpaid

در غیر این صورت:

Paid

را نمایش بده.

==========================================================*/
SELECT *,
	CASE
		WHEN invoice_total > payment_total THEN 'Unpaid'
		ELSE 'Paid'

	END AS 'invoice_status'
FROM invoices


/*==========================================================
سوال 5 (متوسط)

تمام فاکتورها را نمایش بده.

یک ستون به نام PriceLevel بساز.

اگر مبلغ:

بیشتر از 180  →  Expensive

بین 100 و 180  →  Medium

کمتر از 100  →  Cheap

==========================================================*/
SELECT *,
	CASE
		WHEN invoice_total > 180 THEN 'Expensive'
		WHEN invoice_total BETWEEN 100 AND 180 THEN 'Medium'
		WHEN invoice_total < 100 THEN 'Cheap'
	END AS PriceLevel

FROM invoices

/*==========================================================
سوال 6 (متوسط)
تمام مشتریان را نمایش بده.

اگر city برابر:
'Los Angeles'
باشد:
LA
اگر city برابر:
'New York'
باشد:
NY
در غیر این صورت:
Other
نمایش بده.

==========================================================*/
SELECT *,
	CASE 
		WHEN city = 'Los Angeles' THEN 'LA'
		WHEN city = 'New York' THEN 'NY'
		ELSE 'Other'
	END
FROM clients




/*==========================================================
سوال 7 (متوسط)

تمام فاکتورها را نمایش بده.

اگر payment_total برابر invoice_total بود:

Fully Paid

اگر payment_total برابر صفر بود:

No Payment

در غیر این صورت:

Partial PaymentC

را نمایش بده.

==========================================================*/
SELECT *,
	CASE 
		WHEN payment_total = invoice_total THEN 'Fully Paid'
		WHEN payment_total = 0 THEN 'No Payment'
		ELSE 'Partial Payment'


	END

FROM invoices

/*==========================================================
سوال 8 (متوسط)
تمام مشتریان را نمایش بده.
اگر شماره تلفن NULL بود:
No Phone
در غیر این صورت:
Phone Exists
را نمایش بده.

==========================================================*/
SELECT *,
	CASE 
		WHEN phone IS NULL THEN 'No Phone'
		ELSE 'Phone Exists'

	END

FROM clients

/*==========================================================
سوال 9 (متوسط)

تمام فاکتورها را نمایش بده.

اگر due_date از تاریخ امروز (GETDATE()) گذشته باشد:

Overdue

در غیر این صورت:

Active

را نمایش بده.

راهنمایی:
از GETDATE() داخل CASE استفاده کن.

==========================================================*/

SELECT *,
	CASE 
		WHEN due_date  <  GETDATE() THEN 'Overdue' --(بدهکار)
		ELSE 'Active'
	END

FROM invoices



/*==========================================================
سوال 10 (متوسط)

تمام فاکتورها را نمایش بده.
یک ستون به نام PaymentPercent بساز.
اگر payment_total برابر invoice_total بود:
100%
اگر payment_total برابر صفر بود:
0%
در غیر این صورت:
Partial
را نمایش بده.
==========================================================*/


SELECT *,
	CASE 
		WHEN payment_total = invoice_total THEN '100%'
		WHEN payment_total = 0 THEN '0%'
		ELSE 'Partial'
	END AS PaymentPercent

FROM invoices





