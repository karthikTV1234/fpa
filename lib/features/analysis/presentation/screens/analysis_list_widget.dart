import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpa/features/analysis/data/repository/analysis_repository.dart';
import '../bloc/analysis_bloc.dart';
import '../bloc/analysis_event.dart';
import '../bloc/analysis_state.dart';
import '../widgets/analysis_list_item_widget.dart';

class AnalysisListWidget extends StatelessWidget {
  final String category;
  final String timeRange;

  const AnalysisListWidget({Key? key, required this.category, required this.timeRange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnalysisBloc(AnalysisRepository())..add(LoadAnalysis(category: category, timeRange: timeRange)),
      child: BlocBuilder<AnalysisBloc, AnalysisState>(
        builder: (context, state) {
          if (state is AnalysisLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AnalysisLoaded) {
            if (state.results.isEmpty) {
              return const Center(child: Text("No analysis data available."));
            }
            return ListView.builder(
              itemCount: state.results.length,
              itemBuilder: (context, index) {
                return AnalysisListItemWidget(analysis: state.results[index]);
              },
            );
          } else {
            return const Center(child: Text("Something went wrong."));
          }
        },
      ),
    );
  }
}
