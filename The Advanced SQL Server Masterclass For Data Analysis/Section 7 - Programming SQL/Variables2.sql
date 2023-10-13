USE [AdventureWorks2017]

DECLARE @Today DATE 

SET @Today = CAST(GETDATE() AS DATE)


DECLARE @CurrentMonth DATE

SET @CurrentMonth = DATEFROMPARTS(YEAR(@Today), MONTH(@Today), 14)


DECLARE @PayPeriodEnd DATE

SET @PayPeriodEnd = CASE WHEN DAY(@Today) < 15 THEN DATEADD(MONTH, -1, @CurrentMonth) ELSE @CurrentMonth END


DECLARE @PayPeriodStart DATE

SET @PayPeriodStart = DATEADD(DAY, 1, DATEADD(MONTH, -1, @PayPeriodEnd))



SELECT @Today
SELECT @CurrentMonth
SELECT @PayPeriodStart
SELECT @PayPeriodEnd