








SHOW TRIGGRTS


--فقط تریگر های مربوط ب پیمنت به من نمایش داده بشه
SHOW TRIGGRTS LIKE 'peyment%' ('%after%') ('%insert') ('peyment%insert')









DELIMITER $$
CREATE TRIGGER payment_after_insert

	AFTER INSERT ON payments

	--FOR EACH ROW

--این تریگر برای هر رکوردی که تحت تاثیر قرار بگیره اجرا میشه مقلا اگر به جای یک رکورد 5 تا رورد با هم اینسرت کردیم این تر

BEGIN
	


END &&

DELIMITER;






























