import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpa/features/analysis/data/repository/analysis_repository.dart';

import 'analysis_event.dart';
import 'analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  final AnalysisRepository _analysisRepository;

  // Ensure the repository is not null.
  AnalysisBloc(this._analysisRepository) : super(AnalysisInitial()) {
    // Handling LoadAnalysis event.
    on<LoadAnalysis>((event, emit) async {
      emit(AnalysisLoading());
      try {
        final results = await _analysisRepository.fetchAnalysisData(
          category: event.category,
          timeRange: event.timeRange,
        );
        emit(AnalysisLoaded(results));
      } catch (e) {
        // Handle errors more gracefully in production.
        FlutterError.reportError(FlutterErrorDetails(exception: e));
        emit(AnalysisError('Failed to load analysis data. Please try again.'));
      }
    });
  }
}
