import 'package:flutter/material.dart';
import 'package:fpa/features/home/views/rain_card_widget.dart';
import '../../../data/models/rain_status_model.dart';
import '../../../data/service/weather_service.dart';

class HomeScreen extends StatelessWidget {
  final _weatherService = WeatherService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: FutureBuilder<RainStatusModel>(
        future: _weatherService.getRainStatus('Hyderabad'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return RainCardWidget(rainStatus: snapshot.data!);
          } else {
            return const Center(child: Text('No Data'));
          }
        },
      ),
    );
  }
}
