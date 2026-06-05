import '../../domain/entity/stock.dart';

class StockModel {
  final String id;
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

  const StockModel({
    required this.id,

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

  factory StockModel.fromJson(String id, Map<String, dynamic> json) {
    return StockModel(
      id: id,
      stockName: json['stock_name'].toString(),
      stockSymbol: json['stock_symbol'].toString(),

      buyPrice: (json['buy_price'] as num).toDouble(),
      sellPrice: (json['sell_price'] as num).toDouble(),

      buyDate: DateTime.parse(json['buy_date'].toString()),

      sellDate: json['sell_date'] != null
          ? DateTime.parse(json['sell_date'].toString())
          : null,

      quantity: json['quantity'] as int,

      investedAmount: (json['invested_amount'] as num).toDouble(),

      profitLoss: (json['profit_loss'] as num).toDouble(),

      profitLossPercentage: (json['profit_loss_percentage'] as num).toDouble(),

      sector: json['sector'].toString(),
      exchange: json['exchange'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stock_name': stockName,
      'stock_symbol': stockSymbol,

      'buy_price': buyPrice,
      'sell_price': sellPrice,

      'buy_date': buyDate.toIso8601String(),

      'sell_date': sellDate?.toIso8601String(),

      'quantity': quantity,

      'invested_amount': investedAmount,

      'profit_loss': profitLoss,

      'profit_loss_percentage': profitLossPercentage,

      'sector': sector,
      'exchange': exchange,
    };
  }

  static Stock toEntity(StockModel model) {
    return Stock(
      stockName: model.stockName,
      stockSymbol: model.stockSymbol,

      buyPrice: model.buyPrice,
      sellPrice: model.sellPrice,

      buyDate: model.buyDate,
      sellDate: model.sellDate,

      quantity: model.quantity,

      investedAmount: model.investedAmount,

      profitLoss: model.profitLoss,

      profitLossPercentage: model.profitLossPercentage,

      sector: model.sector,
      exchange: model.exchange,
      id: model.id,
    );
  }

  static StockModel fromEntity(Stock entity) {
    return StockModel(
      stockName: entity.stockName,
      stockSymbol: entity.stockSymbol,

      buyPrice: entity.buyPrice,
      sellPrice: entity.sellPrice,

      buyDate: entity.buyDate,
      sellDate: entity.sellDate,

      quantity: entity.quantity,

      investedAmount: entity.investedAmount,

      profitLoss: entity.profitLoss,

      profitLossPercentage: entity.profitLossPercentage,

      sector: entity.sector,
      exchange: entity.exchange,
      id: entity.id,
    );
  }
}
