class Stock {
  final String stockName;
  final String stockSymbol;

  final double buyPrice;
  final double sellPrice;

  final DateTime buyDate;
  final DateTime? sellDate;

  final int quantity;

  final double investedAmount;

  final double profitLoss;
  final double profitLossPercentage;

  final String sector;
  final String exchange;

  const Stock({
    required this.stockName,
    required this.stockSymbol,

    required this.buyPrice,
    required this.sellPrice,

    required this.buyDate,
    this.sellDate,

    required this.quantity,

    required this.investedAmount,

    required this.profitLoss,
    required this.profitLossPercentage,

    required this.sector,
    required this.exchange,
  });
}
