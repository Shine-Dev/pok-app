class NetworkException implements Exception {
  final String message;

  NetworkException({this.message});
}

class FetchException extends NetworkException {
  FetchException(String message) : super(message: message);
}

class BadRequestException extends NetworkException {
  BadRequestException(String message) : super(message: message);
}

class UnauthorisedException extends NetworkException {
  UnauthorisedException(String message) : super(message: message);
}