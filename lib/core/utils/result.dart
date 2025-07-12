class Result<T> {
  final T? data;
  final String? error;

  Result._({this.data, this.error});

  bool get isSuccess => error == null;
  bool get isError => error != null;

  static Result<T> success<T>(T data) => Result._(data: data);
  static Result<T> failure<T>(String error) => Result._(error: error);
}
