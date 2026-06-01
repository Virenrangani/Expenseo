class StockEntity {
  final String stockName;
  final String stockSymbol;

  final double buyPrice;
  final double sellPrice;

  final DateTime buyDate;
  final DateTime? sellDate;

  final int quantity;

  final double investedAmount;
  final double currentValue;

  final double profitLoss;
  final double profitLossPercentage;

  final bool isProfit;
  final bool isSold;

  final String sector;
  final String exchange;

  const StockEntity({
    required this.stockName,
    required this.stockSymbol,

    required this.buyPrice,
    required this.sellPrice,

    required this.buyDate,
    this.sellDate,

    required this.quantity,

    required this.investedAmount,
    required this.currentValue,

    required this.profitLoss,
    required this.profitLossPercentage,

    required this.isProfit,
    required this.isSold,

    required this.sector,
    required this.exchange,
  });
}
