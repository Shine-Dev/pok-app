class GeolocationException implements Exception {
  final String message;

  GeolocationException({this.message});
}

class GeolocationDisabledException extends GeolocationException {
  GeolocationDisabledException(String message) : super(message: message);
}

class GeolocationDeniedException extends GeolocationException {
  GeolocationDeniedException(String message) : super(message: message);
}

class GeolocationDeniedForeverException extends GeolocationException {
  GeolocationDeniedForeverException(String message) : super(message: message);
}