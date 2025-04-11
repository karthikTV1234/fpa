import 'package:flutter/material.dart';
import '../../../data/models/rain_status_model.dart';

class RainCardWidget extends StatelessWidget {
  final RainStatusModel rainStatus;

  const RainCardWidget({super.key, required this.rainStatus});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity, // Make it take full width
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '🌧️ Rain Status',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  '📍 City: ${rainStatus.cityName}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  '📍 Rain Today: ${rainStatus.rainToday ? 'Yes' : 'No'}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                if (rainStatus.rainTimesToday.isNotEmpty)
                  Text(
                    '🕒 Rain Today: ${rainStatus.rainTimesToday!.join(', ')}',
                    style: const TextStyle(fontSize: 16),
                  ),
                const SizedBox(height: 8),
                if (rainStatus.nextRainDateTime != null)
                  Text(
                    '🔮 Next Rain: ${_formatTime(rainStatus.nextRainDateTime!)}',
                    style: const TextStyle(fontSize: 16),
                  )
                else
                  Text('🔮 Next Rain: No rain expected soon')
              ],
            ),
          ),
        ),
      ),
    );
  }


  String _formatTime(DateTime dt) {
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '${dt.day}/${dt.month} at $hour:$minute';
  }
}
