USE [iSMEDB]
GO
/****** Object:  StoredProcedure [dbo].[Get_Ratios]    Script Date: 7/5/2017 10:51:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author		: Md. Zubayed Hossain
-- Create date	: 17 May 2017
-- Description	: Ratio Calculation Process
-- =============================================
ALTER PROCEDURE [dbo].[Get_Ratios] @Ticker VARCHAR(100),@FYear INT,@CY dbo.FinancialValueTable READONLY,@PY dbo.FinancialValueTable READONLY,@RatioForRanking BIT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
----------------------------------------------
--Supporting Data
DECLARE @TempDecimal DECIMAL(18,5)

--Ration Start
--Get Ration List
DECLARE @Ratio TABLE(RatioId INT,Name VARCHAR(100),RatioType VARCHAR(100),Node1 INT,Node2 INT,FValue1 FLOAT DEFAULT 0, FValue2 FLOAT DEFAULT 0,Ratio FLOAT DEFAULT 0)

--Get only requred ratios for ranking
IF @RatioForRanking=0
BEGIN
	INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2)
	SELECT RatioId,Name,RatioType,Node1,Node2
	FROM dbo.RatioItemList()
END
ELSE
BEGIN
	INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2)
	SELECT RatioId,Name,RatioType,Node1,Node2
	FROM dbo.RatioItemList()
	WHERE RankingGroupId<>0
END

--Get Value for Current & Growth Ratios
UPDATE @Ratio
SET FValue1=Value
FROM @CY
WHERE RatioType IN('Ratio','Growth')
AND NodeId=Node1

UPDATE @Ratio
SET FValue2=Value
FROM @CY
WHERE RatioType='Ratio'
AND NodeId=Node2

UPDATE @Ratio
SET FValue2=Value
FROM @PY
WHERE RatioType='Growth'
AND NodeId=Node1

--Start calculation
DECLARE @Avg5 DECIMAL(18,5)=dbo.RatioGetAverage(@PY,@CY,5)
DECLARE @Avg9 DECIMAL(18,5)=dbo.RatioGetAverage(@PY,@CY,9)

UPDATE @Ratio SET FValue2=@Avg5+@Avg9 WHERE RatioId=5
UPDATE @Ratio SET FValue1=@Avg5+@Avg9 WHERE RatioId=6

DECLARE @Avg59 DECIMAL(18,5)=dbo.RatioGetAverage(@PY,@CY,59)
UPDATE @Ratio SET FValue2=@Avg59 WHERE RatioId=7
UPDATE @Ratio SET FValue1=@Avg59 WHERE RatioId=8

DECLARE @Avg7 DECIMAL(18,5)=dbo.RatioGetAverage(@PY,@CY,7)

UPDATE @Ratio
SET FValue2=@Avg7
WHERE RatioId=10

UPDATE @Ratio
SET FValue1=@Avg7
WHERE RatioId=11

UPDATE @Ratio
SET FValue2=dbo.RatioGetAverage(@PY,@CY,51)
WHERE RatioId IN (9,13)

UPDATE @Ratio
SET FValue2=dbo.RatioGetAverage(@PY,@CY,93)
WHERE RatioId=12

UPDATE @Ratio
SET FValue1=FValue1-ISNULL((SELECT SUM(Value) FROM @CY WHERE NodeId=7),0)
WHERE RatioId=20

--Sum of (52,53,55,57,64,67,68,69)
SET @TempDecimal=ISNULL((SELECT SUM(Value) FROM @CY WHERE NodeId IN (52,53,55,57,64,67,68,69)),0)
UPDATE @Ratio SET FValue2=@TempDecimal WHERE RatioId IN (28,29,30)
UPDATE @Ratio SET FValue1=@TempDecimal WHERE RatioId IN (21,31)

UPDATE @Ratio
SET FValue1=ISNULL((SELECT SUM(Value) FROM @CY WHERE NodeId IN (175,182)),0)
WHERE RatioId=23

UPDATE @Ratio
SET FValue1=ISNULL((SELECT SUM(Value) FROM @CY WHERE NodeId IN (175,154,165)),0)
WHERE RatioId=24

UPDATE @Ratio
SET FValue1=ISNULL((SELECT SUM(Value) FROM @CY WHERE NodeId IN (175,186)),0)
WHERE RatioId=25

UPDATE @Ratio
SET FValue2=FValue2*-1
WHERE RatioId=26

UPDATE @Ratio
SET FValue1=ISNULL((SELECT SUM(Value) FROM @CY WHERE NodeId IN (175,182)),0)
WHERE RatioId=30

--Sum of (139,140,141)
SET @TempDecimal=ISNULL((SELECT SUM(Value) FROM @CY WHERE NodeId IN (139,140,141)),0)
UPDATE @Ratio SET FValue2=FValue2-@TempDecimal WHERE RatioId IN (31,72)
UPDATE @Ratio SET FValue1=FValue1-@TempDecimal WHERE RatioId=64

UPDATE @Ratio
SET FValue2=ISNULL((SELECT SUM(Value) FROM @CY WHERE NodeId IN (135,136,137)),0)
WHERE RatioId=34

DECLARE @Avg2 DECIMAL(18,5)=dbo.RatioGetAverage(@PY,@CY,2)
DECLARE @Avg40 DECIMAL(18,5)=dbo.RatioGetAverage(@PY,@CY,40)
DECLARE @Avg38 DECIMAL(18,5)=dbo.RatioGetAverage(@PY,@CY,38)

UPDATE @Ratio
SET FValue2=@Avg2+@Avg38+@Avg40
WHERE RatioId=38

UPDATE @Ratio
SET FValue2=@Avg2+dbo.RatioGetAverage(@PY,@CY,74)+dbo.RatioGetAverage(@PY,@CY,75)
WHERE RatioId=39

--Sum of (2,38,40)
SET @TempDecimal=ISNULL((SELECT SUM(Value) FROM @CY WHERE NodeId IN (2,38,40)),0)
UPDATE @Ratio SET FValue1=@TempDecimal WHERE RatioId=42
UPDATE @Ratio SET FValue2=@TempDecimal WHERE RatioId IN (46,47,48,49)

UPDATE @Ratio
SET FValue1=@Avg2
WHERE RatioId=47

UPDATE @Ratio
SET FValue1=@Avg40
WHERE RatioId=48

UPDATE @Ratio
SET FValue1=@Avg38
WHERE RatioId=49

UPDATE @Ratio
SET FValue2=@Avg2
WHERE RatioId=50

UPDATE @Ratio
SET FValue2=@Avg40
WHERE RatioId=51

UPDATE @Ratio
SET FValue2=@Avg38
WHERE RatioId=52

UPDATE @Ratio
SET FValue2=dbo.RatioGetAverage(@PY,@CY,17)
WHERE RatioId=54

UPDATE @Ratio
SET FValue2=ISNULL((SELECT SUM(Value) FROM @CY WHERE NodeId IN (52,64,93)),0)
WHERE RatioId=65

UPDATE @Ratio
SET FValue2=ISNULL((SELECT SUM(Value) FROM @CY WHERE NodeId IN (175,182)),0)
WHERE RatioId=68

UPDATE @Ratio
SET FValue2=ISNULL((SELECT SUM(Value) FROM @CY WHERE NodeId IN (3,11,15,25)),0)
WHERE RatioId=79

UPDATE @Ratio
SET FValue1=ISNULL((SELECT SUM(Value) FROM @CY WHERE NodeId IN (74,75)),0)
WHERE RatioId=80

UPDATE @Ratio
SET FValue1=ISNULL((SELECT SUM(Value) FROM @CY WHERE NodeId IN (114,115)),0)
WHERE RatioId=81

--Set FValue2=1 for single item ratios
UPDATE @Ratio
SET FValue2=1
WHERE RatioId IN (16,17,32,73,74,75,76)

--Calculate Ratio & Growth Ratios
UPDATE @Ratio
SET Ratio=(CASE WHEN FValue2=0 THEN 0 ELSE FValue1/FValue2 END)
WHERE RatioType='Ratio'

UPDATE @Ratio
SET Ratio=(CASE WHEN FValue2=0 THEN 0 ELSE FValue1/FValue2-1 END)
WHERE RatioType='Growth'

--Multiply 360
UPDATE @Ratio
SET Ratio=Ratio*360
WHERE RatioId IN (6,8,11)

--Custom Ratios
--CashConversionCycle
DECLARE @CY103 DECIMAL(18,5),@CY105 DECIMAL(18,5)

SELECT @CY103=Value FROM @CY WHERE NodeId=103
SELECT @CY105=Value FROM @CY WHERE NodeId=105

UPDATE @Ratio
SET Ratio=ISNULL((CASE WHEN @CY103=0 THEN 0 ELSE 360*((@Avg5+@Avg9)/@CY103) END),0)
			+ISNULL((CASE WHEN @CY105=0 THEN 0 ELSE 360*(@Avg7/@CY105)-360*(@Avg59/@CY105) END),0)
WHERE RatioId=18

--Sum of (2,38,40)
SET @TempDecimal=ISNULL((SELECT SUM(Value) FROM @CY WHERE NodeId IN (2,38,40)),0)

IF @TempDecimal<>0
BEGIN
	DECLARE @CY111 DECIMAL(18,5)
	SELECT @CY111=ISNULL(Value,0) FROM @CY WHERE NodeId=111
	
	UPDATE @Ratio
	SET Ratio=ISNULL((@Avg2/@TempDecimal)*(CASE WHEN @Avg2=0 THEN 0 ELSE (@CY111/@Avg2) END)
					+(@Avg40/@TempDecimal)*(CASE WHEN @Avg40=0 THEN 0 ELSE (@CY111/@Avg40) END)
					+(@Avg38/@TempDecimal)*(CASE WHEN @Avg38=0 THEN 0 ELSE (@CY111/@Avg38) END),0)
	WHERE RatioId=53
END
ELSE
BEGIN
	UPDATE @Ratio
	SET Ratio=0
	WHERE RatioId=53
END

--End of Calculation

SELECT RatioId,Name,Ratio FROM @Ratio
--WHERE Ratio<>0

---------------------------------------

END




