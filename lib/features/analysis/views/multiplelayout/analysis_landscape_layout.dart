import 'package:flutter/material.dart';
import '../../../../common/widgets/my_dropdown_widget.dart';
import '../../../../data/category_item_data.dart';
import '../analysis_list_widget.dart';

class AnalysisLandscapeLayout extends StatelessWidget {
  final String? selectedCategory;
  final String? selectedTimeRange;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onTimeRangeChanged;
  final VoidCallback onShowAnalysis;
  final bool showAnalysis;

  const AnalysisLandscapeLayout({
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
    return Row(
      children: [
        // Left Panel - Filters
        Flexible(
          flex: 2,
          child: SingleChildScrollView(
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
                ElevatedButton(
                  onPressed: onShowAnalysis,
                  child: const Text('Show Analysis'),
                ),
              ],
            ),
          ),
        ),

        // Right Panel - Analysis List
        Flexible(
          flex: 3,
          child: showAnalysis
              ? Padding(
            padding: const EdgeInsets.all(16),
            child: AnalysisListWidget(
              category: selectedCategory!,
              timeRange: selectedTimeRange!,
            ),
          )
              : const SizedBox(),
        ),
      ],
    );
  }
}
