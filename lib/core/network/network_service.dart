import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  // Singleton setup
  NetworkService._internal();
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;

  final Connectivity _connectivity = Connectivity();

  Future<bool> hasNetworkConnection() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Stream<ConnectivityResult> get onNetworkChange =>
      _connectivity.onConnectivityChanged;
}
