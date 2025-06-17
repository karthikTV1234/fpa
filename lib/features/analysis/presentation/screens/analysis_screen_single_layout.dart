import 'package:flutter/material.dart';
import 'package:fpa/features/entries/data/category_item_data.dart';
import '../../../../common/widgets/my_dropdown_widget.dart';
import 'analysis_list_widget.dart';

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
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Dropdown
                MyDropdownField(
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
                MyDropdownField(
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
                  SizedBox(
                    //creates a box with a specific height that is 45% of the screen’s total height.
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: AnalysisListWidget(
                      category: selectedCategory!,
                      timeRange: selectedTimeRange!,
                    ),
                  ),
              ],
            ),
          )
      )
    );
  }
}
