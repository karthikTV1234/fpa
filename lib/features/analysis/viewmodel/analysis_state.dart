import 'package:equatable/equatable.dart';
import '../model/AnalysisResult.dart';

/// Base class for all analysis-related states.
abstract class AnalysisState extends Equatable {
  const AnalysisState();

  @override
  List<Object> get props => [];
}

/// Initial state before any action is taken.
class AnalysisInitial extends AnalysisState {}

/// State when analysis data is being loaded.
class AnalysisLoading extends AnalysisState {}

/// State when analysis data is successfully loaded.
class AnalysisLoaded extends AnalysisState {
  final List<AnalysisResult> results;

  const AnalysisLoaded(this.results);

  @override
  List<Object> get props => [results];
}

/// State when an error occurs during analysis.
class AnalysisError extends AnalysisState {
  final String message;

  const AnalysisError(this.message);

  @override
  List<Object> get props => [message];
}
