class AnalysisResult {
  final String itemName;
  final double lowestPrice;
  final String lowestPriceDate;
  final double highestPrice;
  final String highestPriceDate;
  final double averagePrice;

  AnalysisResult({
    required this.itemName,
    required this.lowestPrice,
    required this.lowestPriceDate,
    required this.highestPrice,
    required this.highestPriceDate,
    required this.averagePrice,
  });

  // Factory constructor to create AnalysisResult from a Map (for SQLite)
  factory AnalysisResult.fromMap(Map<String, dynamic> map) {
    return AnalysisResult(
      itemName: map['itemName'],
      lowestPrice: map['lowestPrice'].toDouble(),
      lowestPriceDate: map['lowestPriceDate'],
      highestPrice: map['highestPrice'].toDouble(),
      highestPriceDate: map['highestPriceDate'],
      averagePrice: map['averagePrice'].toDouble(),
    );
  }
}
