
SELECT
	servicename,
	status_desc

FROM sys.dm_server_services
WHERE servicename LIKE '%SQl Server Agent%'




