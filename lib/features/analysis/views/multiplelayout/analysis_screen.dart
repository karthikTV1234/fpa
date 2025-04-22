import 'package:flutter/material.dart';
import 'analysis_landscape_layout.dart';
import 'analysis_portrait_layout.dart';

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
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? AnalysisPortraitLayout(
            selectedCategory: selectedCategory,
            selectedTimeRange: selectedTimeRange,
            onCategoryChanged: (value) => setState(() => selectedCategory = value),
            onTimeRangeChanged: (value) => setState(() => selectedTimeRange = value),
            onShowAnalysis: _handleShowAnalysis,
            showAnalysis: showAnalysis,
          )
              : AnalysisLandscapeLayout(
            selectedCategory: selectedCategory,
            selectedTimeRange: selectedTimeRange,
            onCategoryChanged: (value) => setState(() => selectedCategory = value),
            onTimeRangeChanged: (value) => setState(() => selectedTimeRange = value),
            onShowAnalysis: _handleShowAnalysis,
            showAnalysis: showAnalysis,
          );
        },
      ),
    );
  }

  void _handleShowAnalysis() {
    if (selectedCategory != null && selectedTimeRange != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Category: $selectedCategory, Time Range: $selectedTimeRange')),
      );
      setState(() => showAnalysis = true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select both Category and Time Range')));
    }
  }
}