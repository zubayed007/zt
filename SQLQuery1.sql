USE [iSMEDB]
GO
/****** Object:  StoredProcedure [dbo].[RatiosCalculation]    Script Date: 7/5/2017 10:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Md.Zubayed
-- Create date: 2017-05-17
-- =============================================
ALTER PROCEDURE [dbo].[RatiosCalculation]
	-- Add the parameters for the stored procedure here
	@UserId varchar(max),@TICKER AS varchar(50) = ''
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

DECLARE @YEAR INT
Declare @StartYear Int
Declare @EndYear Int

Select @StartYear=Min(FYear),@EndYear=Max(FYear) From FinancialStatement Where Ticker =@TICKER And Yearly=1
Set @YEAR=@StartYear

Declare @DataTable As Table( Ratioid Int,Name Varchar(max),Ratio Float)

While(@YEAR<=@EndYear)
Begin
	DECLARE @CY dbo.FinancialValueTable--TABLE (NodeId INT,Value float)

	DECLARE @PY dbo.FinancialValueTable--TABLE (NodeId INT,Value float)

	Delete From @CY
	Delete From @PY
		
	INSERT INTO @CY
	SELECT V.NodeId,V.Value
	FROM FinancialStatement V INNER JOIN FinancialStatementHead H
	ON V.NodeId=H.NodeId
	WHERE V.Ticker=@Ticker
	AND V.FYear=@YEAR
	AND V.Yearly=1
	AND H.IsRatioItem=1
		 
	INSERT INTO @PY
	SELECT V.NodeId,V.Value
	FROM FinancialStatement V INNER JOIN FinancialStatementHead H
	ON V.NodeId=H.NodeId
	WHERE V.Ticker=@Ticker
	AND V.FYear=@YEAR-1
	AND V.Yearly=1
	AND H.IsRatioItem=1

	Delete From @DataTable 
	Insert Into @DataTable ( Ratioid ,Name ,Ratio)
	EXEC [dbo].[Get_Ratios] @Ticker=@Ticker,@FYear=@YEAR,@CY=@CY,@PY=@PY	
		
	Update @DataTable
		Set Name=replace( Name, ' ', '' )
		
	--Select * From @DataTable
		
	Delete From FinancialRatios Where Ticker=@Ticker And Year=@YEAR
		
	Insert Into FinancialRatios(Ticker,[Year],EntryID,GrossMargin,OperatingMargin,NetProfitMargin,InterestCoverageRatio,AccountsReceiveableTurnOver,
	AverageCollectionPeriod,AccountsPayableTurnOver,AveragePaymentPeriod,AssetTurnOver,InventoryTurnOver,
	InventoryTurnDays,ROE,ROA,NetProfitGrowth,RevenueGrowth,Revenue,EPS,CashConversionCycle,CurrentRatio,
	QuickRatio,DebtToEquity,OperatingCashFlowRatio,FreeCashFlowToRevenue,CashInterestCoverageRatio,
	CashCurrentDebtCoverageRatio,CapitalExpenditureRatio,TotalDebtRatio,FundFromOperationByTotalDebt,
	OperatingCashFlowByTotalDebt,FCFByTotalDebt,TotalDebtByEBITDA,OperatingExpenditures,CostToIncomeRatio,
	InterestToNonInterestRatio,TotalAssetGrowth,OperatingIncomeGrowth,DepositGrowth,NetInterestMargin,
	CostofFund,CreditDepositRatio,LoanToTotalAssets,EarningAssetsToTotalAssets,DepositToLiabilities,
	EquityToTotalAssets,NetInterestMarginToTotalAsset,NetInterestMarginToTotalEarningAsset,
	WeightageofAverageBankBalance,WeightageofAverageLoansandAdvances,WeightageofAverageMoneyatCall,
	YieldonAverageBankBalance,YieldonAverageLoansandAdvances,YieldonAverageMoneyatCall,AverageYieldonLoans,
	AverageYieldonInvesment,OperatingCostTotalAsset,PreTaxMargin,CAR,NPLToLoans,DepositMarketShare,LoanMarketShare,
	NPLToTotalAssets,Tier1CapitalRatio,Tier2CapitalRatio,EBITDAMargin,ROIC,OCFpershare,FCFpershare,Cashpershare,PByE,PByBV,PbyEBITDA)
		
	Select @Ticker,@YEAR,@UserId, GrossMargin,OperatingMargin,NetProfitMargin,InterestCoverageRatio,AccountsReceiveableTurnOver,
	AverageCollectionPeriod,AccountsPayableTurnOver,AveragePaymentPeriod,AssetTurnOver,InventoryTurnOver,
	InventoryTurnDays,ROE,ROA,NetProfitGrowth,RevenueGrowth,Revenue,EPS,CashConversionCycle,CurrentRatio,
	QuickRatio,DebtToEquity,OperatingCashFlowRatio,FreeCashFlowToRevenue,CashInterestCoverageRatio,
	CashCurrentDebtCoverageRatio,CapitalExpenditureRatio,TotalDebtRatio,FundFromOperationByTotalDebt,
	OperatingCashFlowByTotalDebt,FCFByTotalDebt,TotalDebtByEBITDA,OperatingExpenditures,CostToIncomeRatio,
	InterestToNonInterestRatio,TotalAssetGrowth,OperatingIncomeGrowth,DepositGrowth,NetInterestMargin,
	CostofFund,CreditDepositRatio,LoanToTotalAssets,EarningAssetsToTotalAssets,DepositToLiabilities,
	EquityToTotalAssets,NetInterestMarginToTotalAsset,NetInterestMarginToTotalEarningAsset,
	WeightageofAverageBankBalance,WeightageofAverageLoansandAdvances,WeightageofAverageMoneyatCall,
	YieldonAverageBankBalance,YieldonAverageLoansandAdvances,YieldonAverageMoneyatCall,AverageYieldonLoans,
	AverageYieldonInvesment,OperatingCostTotalAsset,PreTaxMargin,CAR,NPLToLoans,DepositMarketShare,LoanMarketShare,
	NPLToTotalAssets,Tier1CapitalRatio,Tier2CapitalRatio,EBITDAMargin,ROIC,OCFpershare,FCFpershare,Cashpershare,PByE,PByBV,PbyEBITDA
	from
	(
		select Name, col, value
		from @DataTable
		unpivot
		(
		value
		for col in (Ratio)
		) unpiv
	) src
	pivot
	(
		max(value)
		for Name in (GrossMargin,OperatingMargin,NetProfitMargin,InterestCoverageRatio,AccountsReceiveableTurnOver,
	AverageCollectionPeriod,AccountsPayableTurnOver,AveragePaymentPeriod,AssetTurnOver,InventoryTurnOver,
	InventoryTurnDays,ROE,ROA,NetProfitGrowth,RevenueGrowth,Revenue,EPS,CashConversionCycle,CurrentRatio,
	QuickRatio,DebtToEquity,OperatingCashFlowRatio,FreeCashFlowToRevenue,CashInterestCoverageRatio,
	CashCurrentDebtCoverageRatio,CapitalExpenditureRatio,TotalDebtRatio,FundFromOperationByTotalDebt,
	OperatingCashFlowByTotalDebt,FCFByTotalDebt,TotalDebtByEBITDA,OperatingExpenditures,CostToIncomeRatio,
	InterestToNonInterestRatio,TotalAssetGrowth,OperatingIncomeGrowth,DepositGrowth,NetInterestMargin,
	CostofFund,CreditDepositRatio,LoanToTotalAssets,EarningAssetsToTotalAssets,DepositToLiabilities,
	EquityToTotalAssets,NetInterestMarginToTotalAsset,NetInterestMarginToTotalEarningAsset,
	WeightageofAverageBankBalance,WeightageofAverageLoansandAdvances,WeightageofAverageMoneyatCall,
	YieldonAverageBankBalance,YieldonAverageLoansandAdvances,YieldonAverageMoneyatCall,AverageYieldonLoans,
	AverageYieldonInvesment,OperatingCostTotalAsset,PreTaxMargin,CAR,NPLToLoans,DepositMarketShare,LoanMarketShare,
	NPLToTotalAssets,Tier1CapitalRatio,Tier2CapitalRatio,EBITDAMargin,ROIC,OCFpershare,FCFpershare,Cashpershare,PByE,PByBV,PbyEBITDA)
	) piv       

    Set @YEAR=@YEAR+1
End

END


