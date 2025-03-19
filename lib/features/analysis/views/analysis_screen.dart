import 'package:flutter/material.dart';
import 'package:fpa/data/category_item_data.dart';
import 'package:fpa/widgets/dropdown_widget.dart';
import 'package:fpa/features/analysis/views/analysis_list_widget.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  String? selectedCategory;
  String? selectedTimeRange;
  bool showAnalysis = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Price Analysis')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Dropdown
            DropdownField(
              items: categories,
              label: 'Select Category',
              selectedValue: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Time Range Dropdown
            DropdownField(
              items: timeRanges,
              label: 'Select Time Range',
              selectedValue: selectedTimeRange,
              onChanged: (value) {
                setState(() {
                  selectedTimeRange = value;
                });
              },
            ),
            const SizedBox(height: 24),

            // Show Analysis Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedCategory != null && selectedTimeRange != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Category: $selectedCategory, Time Range: $selectedTimeRange')),
                    );
                    setState(() {
                      showAnalysis = true;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select both Category and Time Range')),
                    );
                  }
                },
                child: const Text('Show Analysis'),
              ),
            ),
            const SizedBox(height: 24),

            // Show Analysis List below button
            if (showAnalysis)
              Expanded(
                child: AnalysisListWidget(
                  category: selectedCategory!,
                  timeRange: selectedTimeRange!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
