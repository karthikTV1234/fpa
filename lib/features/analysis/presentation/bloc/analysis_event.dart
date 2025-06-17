import 'package:equatable/equatable.dart';

/// Base class for all analysis-related events.
abstract class AnalysisEvent extends Equatable {
  const AnalysisEvent();

  @override
  List<Object> get props => [];
}

/// Event to load analysis data for a specific category and time range.
class LoadAnalysis extends AnalysisEvent {
  final String category;
  final String timeRange;

  const LoadAnalysis({required this.category, required this.timeRange});

  @override
  List<Object> get props => [category, timeRange];
}
