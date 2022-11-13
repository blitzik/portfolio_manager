class ResultObject<T> {
  final T? _result;
  T? get value => _result;

  final List<String> _errorMessages = <String>[];
  List<String> get errorMessages => _errorMessages.toList();
  String get lastErrorMessage => _errorMessages.last;
  int get errorsCount => _errorMessages.length;
  bool get isSuccess => _errorMessages.isEmpty;
  bool get isFailure => _errorMessages.isNotEmpty;


  ResultObject([this._result]);

  void addErrorMessage(String message) {
    _errorMessages.add(message);
  }
}