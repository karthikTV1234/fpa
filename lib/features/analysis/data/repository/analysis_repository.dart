import '../models/AnalysisResult.dart';

class AnalysisRepository {
  // Simulated network delay
  Future<List<AnalysisResult>> fetchAnalysisData({
    required String category,
    required String timeRange,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    // Dummy data for now (always returned)
    return [
      AnalysisResult(
        itemName: 'Potato',
        lowestPrice: 20.0,
        lowestPriceDate: '2024-02-10',
        highestPrice: 50.0,
        highestPriceDate: '2024-07-15',
        averagePrice: 35.0,
      ),
      AnalysisResult(
        itemName: 'Tomato',
        lowestPrice: 30.0,
        lowestPriceDate: '2024-01-05',
        highestPrice: 70.0,
        highestPriceDate: '2024-08-20',
        averagePrice: 50.0,
      ),
      AnalysisResult(
        itemName: 'Onion',
        lowestPrice: 25.0,
        lowestPriceDate: '2024-03-15',
        highestPrice: 60.0,
        highestPriceDate: '2024-09-10',
        averagePrice: 42.5,
      ),
      AnalysisResult(
        itemName: 'Banana',
        lowestPrice: 45.0,
        lowestPriceDate: '2024-03-15',
        highestPrice: 80.0,
        highestPriceDate: '2024-09-10',
        averagePrice: 35.5,
      ),
    ];
  }
}
