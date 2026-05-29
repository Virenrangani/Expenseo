class StockModel {
  final String stockName;
  final String stockSymbol;

  final double currentPrice;
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

  final String note;

  const StockModel({
    required this.stockName,
    required this.stockSymbol,

    required this.currentPrice,
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

    required this.note,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      stockName: json['stock_name'].toString(),
      stockSymbol: json['stock_symbol'].toString(),

      currentPrice: (json['current_price'] as num).toDouble(),
      buyPrice: (json['buy_price'] as num).toDouble(),
      sellPrice: (json['sell_price'] as num).toDouble(),

      buyDate: DateTime.parse(json['buy_date'].toString()),

      sellDate: json['sell_date'] != null
          ? DateTime.parse(json['sell_date'].toString())
          : null,

      quantity: json['quantity'] as int,

      investedAmount: (json['invested_amount'] as num).toDouble(),

      currentValue: (json['current_value'] as num).toDouble(),

      profitLoss: (json['profit_loss'] as num).toDouble(),

      profitLossPercentage: (json['profit_loss_percentage'] as num).toDouble(),

      isProfit: json['is_profit'] as bool,
      isSold: json['is_sold'] as bool,

      sector: json['sector'].toString(),
      exchange: json['exchange'].toString(),

      note: json['note'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stock_name': stockName,
      'stock_symbol': stockSymbol,

      'current_price': currentPrice,
      'buy_price': buyPrice,
      'sell_price': sellPrice,

      'buy_date': buyDate.toIso8601String(),

      'sell_date': sellDate?.toIso8601String(),

      'quantity': quantity,

      'invested_amount': investedAmount,
      'current_value': currentValue,

      'profit_loss': profitLoss,

      'profit_loss_percentage': profitLossPercentage,

      'is_profit': isProfit,
      'is_sold': isSold,

      'sector': sector,
      'exchange': exchange,

      'note': note,
    };
  }
}
