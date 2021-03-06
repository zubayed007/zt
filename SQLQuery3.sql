USE [iSMEDB]
GO
/****** Object:  UserDefinedFunction [dbo].[RatioItemList]    Script Date: 7/5/2017 10:51:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Md. Zubayed Hossain
-- Create date: 17 May 2017
-- Description:	List of Ratios
-- =============================================
ALTER FUNCTION [dbo].[RatioItemList]
(	
	-- Add the parameters for the function here
)
--Value Type: 1=Higher value has higher point,2=Lower value has higher point
RETURNS @Ratio TABLE(RatioId INT,Name VARCHAR(100),RatioType VARCHAR(100),Node1 INT DEFAULT 0,Node2 INT DEFAULT 0,ValueType BIT DEFAULT 1,RankingGroupId INT DEFAULT 0)
as
begin
-- Add the SELECT statement with parameter references here

INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(1,'Gross Margin','Ratio',110,103)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(2,'Operating Margin','Ratio',153,103)--For Manufacturing Company
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(3,'Net Profit Margin','Ratio',167,103)--For Manufacturing Company
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(4,'Interest Coverage Ratio','Ratio',153,154)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(5,'Accounts Receiveable TurnOver','Ratio',103,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(6,'Average Collection Period','Ratio',0,103)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(7,'Accounts Payable TurnOver','Ratio',105,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(8,'Average Payment Period','Ratio',0,105)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(9,'Asset TurnOver','Ratio',103,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(10,'Inventory TurnOver','Ratio',105,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(11,'Inventory Turn Days','Ratio',0,105)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(12,'ROE','Ratio',167,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(13,'ROA','Ratio',167,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1) VALUES(14,'Net Profit Growth','Growth',167)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1) VALUES(15,'Revenue Growth','Growth',103)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(16,'Revenue','Ratio',103,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(17,'Net Profit','Ratio',167,0)
INSERT INTO @Ratio(RatioId,Name,RatioType) VALUES(18,'Cash Conversion Cycle','Custom')
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(19,'Current Ratio','Ratio',16,63)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(20,'Quick Ratio','Ratio',16,93)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(21,'Debt To Equity','Ratio',0,93)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(22,'Operating Cash Flow Ratio','Ratio',175,63)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(23,'Free Cash Flow To Revenue','Ratio',0,103)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(24,'Cash Interest Coverage Ratio','Ratio',0,154)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(25,'Cash Current Debt Coverage Ratio','Ratio',0,63)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(26,'Capital Expenditure Ratio','Ratio',175,179)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(27,'Total Debt Ratio','Ratio',175,86)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(28,'Fund From Operation By Total Debt','Ratio',153,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(29,'Operating Cash Flow By Total Debt','Ratio',175,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(30,'FCF By Total Debt','Ratio',0,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(31,'Total Debt By EBITDA','Ratio',0,138)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(32,'Operating Expenditures','Ratio',152,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(33,'Cost To Income Ratio','Ratio',152,138)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(34,'Interest To Non Interest Ratio','Ratio',113,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1) VALUES(35,'Total Asset Growth','Growth',51)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1) VALUES(36,'Operating Income Growth','Growth',138)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1) VALUES(37,'Deposit Growth','Growth',75)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(38,'Net Interest Margin','Ratio',113,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(39,'Cost of Fund','Ratio',112,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(40,'Credit Deposit Ratio','Ratio',40,75)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(41,'Loan To Total Assets','Ratio',40,51)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(42,'Earning Assets To Total Assets','Ratio',0,51)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(43,'Deposit To Liabilities','Ratio',75,86)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(44,'Equity To Total Assets','Ratio',93,51)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(45,'Net Interest Margin To Total Asset','Ratio',113,51)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(46,'Net Interest Margin To Total Earning Asset','Ratio',113,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(47,'Weightage of Average Bank Balance','Ratio',0,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(48,'Weightage of Average Loans and Advances','Ratio',0,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(49,'Weightage of Average Moneyat Call','Ratio',0,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(50,'Yieldon Average Bank Balance','Ratio',111,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(51,'Yieldon Average Loans and Advances','Ratio',111,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(52,'Yieldon Average Moneyat Call','Ratio',111,0)
INSERT INTO @Ratio(RatioId,Name,RatioType) VALUES(53,'Average Yield on Loans','Custom')
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(54,'Average Yieldon Invesment','Ratio',135,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(55,'Operating Cost Total Asset','Ratio',152,51)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(56,'Pre Tax Margin','Ratio',167,164)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(57,'CAR','Ratio',219,218)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(58,'NPL To Loans','Ratio',214,40)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(59,'Deposit Market Share','Ratio',75,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(60,'Loan Market Share','Ratio',40,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(61,'NPL To Total Assets','Ratio',214,51)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(62,'Tier1Capital Ratio','Ratio',26,218)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(63,'Tier2Capital Ratio','Ratio',70,218)

INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(64,'EBITDA Margin','Ratio',138,103)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(65,'ROIC','Ratio',167,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(66,'EPS','Ratio',167,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(67,'OCF per share','Ratio',175,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(68,'FCF per share','Ratio',0,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(69,'Cash per share','Ratio',193,0)

INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(70,'PByE','Ratio',0,167)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(71,'PByBV','Ratio',0,93)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(72,'PbyEBITDA','Ratio',0,138)

INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(73,'Deposit','Ratio',0,75)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(74,'Total Asset','Ratio',0,51)
INSERT INTO @Ratio(RatioId,Name,RatioType) VALUES(75,'Deposit Market','Ratio')
INSERT INTO @Ratio(RatioId,Name,RatioType) VALUES(76,'Loan Market','Ratio')

INSERT INTO @Ratio(RatioId,Name,RatioType) VALUES(77,'Dividend Yield','Ratio')
INSERT INTO @Ratio(RatioId,Name,RatioType) VALUES(78,'Dividend Yield (FYE)','Ratio')

INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(79,'Loan Provision for the year','Ratio',56,0)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(80,'Leverage(DEBT/ASSETS)','Ratio',0,51)
INSERT INTO @Ratio(RatioId,Name,RatioType,Node1,Node2) VALUES(81,'Diversification: Lease as % of revenue','Ratio',0,138)

--Set ValyeType for ratios which get higher point for lower value
UPDATE @Ratio SET ValueType=0 WHERE RatioId IN (6,7,11,18,21,27,31,32,33,39,55,58,61,70,71,72,79,80)

--Set Ranking Groups
UPDATE @Ratio SET RankingGroupId=1 WHERE RatioId IN (5,10,19,21)
UPDATE @Ratio SET RankingGroupId=2 WHERE RatioId IN (1,3,15,16,17)
UPDATE @Ratio SET RankingGroupId=3 WHERE RatioId IN (2,12,13,38,39)
UPDATE @Ratio SET RankingGroupId=4 WHERE RatioId IN (33,34,57,58,79,80,81)
UPDATE @Ratio SET RankingGroupId=5 WHERE RatioId IN (14,35,36,37)
UPDATE @Ratio SET RankingGroupId=6 WHERE RatioId IN (59,60,74)
UPDATE @Ratio SET RankingGroupId=7 WHERE RatioId IN (70,71,78)

return
END
