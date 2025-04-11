class RainStatusModel {
  final String cityName;
  final bool rainToday;
  final List<String> rainTimesToday;
  final DateTime? nextRainDateTime;

  RainStatusModel({
    required this.cityName,
    required this.rainToday,
    required this.rainTimesToday,
    required this.nextRainDateTime,
  });
}
