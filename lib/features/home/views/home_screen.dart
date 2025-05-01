import 'package:flutter/material.dart';
import 'package:fpa/features/home/views/rain_card_widget.dart';
import '../../../core/network/network_service.dart';
import '../../../data/models/rain_status_model.dart';
import '../../../data/service/weather_service.dart';

class HomeScreen extends StatelessWidget {
  final _weatherService = WeatherService();
  final _networkService = NetworkService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: FutureBuilder<RainStatusModel>(
        future: _checkInternetAndFetchData(context),
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

  // Method to check for internet and fetch weather data
  Future<RainStatusModel> _checkInternetAndFetchData(BuildContext context) async {
    bool isConnected = await _networkService.hasNetworkConnection();
    if (!isConnected) {
      // If no internet, throw an error
      throw Exception('No internet connection. Please try again later.');
    }
    // If there is internet, fetch the weather data
    return await _weatherService.getRainStatus('Hyderabad');
  }
}
