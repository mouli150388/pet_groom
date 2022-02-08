



class UnauthorisedException implements Exception {}

class InvalidException implements Exception {
  final String error;

  InvalidException(this.error);
}

class InvalidAccessTokenException implements Exception {
  String token;
  InvalidAccessTokenException(this.token);
}

class NetworkException implements Exception {
  final String error;

  NetworkException(this.error);
}


