import 'package:flutter/material.dart';
import '../../../data/models/AnalysisResult.dart';

class AnalysisListItemWidget extends StatelessWidget {
  final AnalysisResult analysis;

  const AnalysisListItemWidget({super.key, required this.analysis});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              analysis.itemName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.trending_down, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'Lowest Price: ₹${analysis.lowestPrice.toStringAsFixed(2)} on ${analysis.lowestPriceDate}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.trending_up, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  'Highest Price: ₹${analysis.highestPrice.toStringAsFixed(2)} on ${analysis.highestPriceDate}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

