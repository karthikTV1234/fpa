import 'package:flutter/material.dart';
import '../../../../data/category_item_data.dart';
import '../../../../widgets/my_dropdown_widget.dart';
import '../analysis_list_widget.dart';

class AnalysisPortraitLayout extends StatelessWidget {
  final String? selectedCategory;
  final String? selectedTimeRange;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onTimeRangeChanged;
  final VoidCallback onShowAnalysis;
  final bool showAnalysis;

  const AnalysisPortraitLayout({
    super.key,
    required this.selectedCategory,
    required this.selectedTimeRange,
    required this.onCategoryChanged,
    required this.onTimeRangeChanged,
    required this.onShowAnalysis,
    required this.showAnalysis,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyDropdownField(
            items: categories,
            label: 'Select Category',
            selectedValue: selectedCategory,
            onChanged: onCategoryChanged,
          ),
          const SizedBox(height: 16),
          MyDropdownField(
            items: timeRanges,
            label: 'Select Time Range',
            selectedValue: selectedTimeRange,
            onChanged: onTimeRangeChanged,
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: onShowAnalysis,
              child: const Text('Show Analysis'),
            ),
          ),
          const SizedBox(height: 24),
          if (showAnalysis)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: AnalysisListWidget(
                category: selectedCategory!,
                timeRange: selectedTimeRange!,
              ),
            ),
        ],
      ),
    );
  }
}
