import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../models/rain_status_model.dart';

class WeatherService {
  final Dio _dio = ApiClient().dio;
  static const String _apiKey = 'ccaeb5d1f322c7dfebc89cf737561fc1';

  Future<RainStatusModel> getRainStatus(String cityName) async {
    try {
      final response = await _dio.get(
        'forecast',
        queryParameters: {
          'q': cityName,
          'appid': _apiKey,
          'units': 'metric',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> forecastList = response.data['list'];
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        List<String> rainTimesToday = [];
        DateTime? nextRain;

        for (var item in forecastList) {
          final dtTxt = item['dt_txt'];
          final dateTime = DateTime.parse(dtTxt);

          final weatherList = item['weather'] as List<dynamic>?;
          final hasRain = weatherList?.any((w) =>
          (w['main']?.toString().toLowerCase() ?? '') == 'rain') ?? false;

          if (hasRain) {
            if (dateTime.year == today.year &&
                dateTime.month == today.month &&
                dateTime.day == today.day) {
              rainTimesToday.add(
                '${dateTime.hour.toString().padLeft(2, '0')}:00',
              );
            }

            if (nextRain == null && dateTime.isAfter(now)) {
              nextRain = dateTime;
            }
          }
        }

        return RainStatusModel(
          cityName: cityName,
          rainToday: rainTimesToday.isNotEmpty,
          rainTimesToday: rainTimesToday,
          nextRainDateTime: nextRain,
        );
      } else {
        throw Exception('Failed to fetch forecast data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
