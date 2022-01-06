abstract class Failure implements Exception {}

class ServerFailure extends Failure {
  final String? message;

  ServerFailure([this.message]);
}

class InvalidCredentials extends Failure {
  final String? message;

  InvalidCredentials([this.message]);
}

class InvalidInputFailure extends Failure {
  final String message;
  final List errors;

  InvalidInputFailure(this.message, this.errors);
}

class UnprocessableEntityFailure extends Failure {
  final String message;
  final Map<String, dynamic> errors;

  UnprocessableEntityFailure(this.message, this.errors);
}

class UnauthorizedFailure extends Failure {
  final String message;

  UnauthorizedFailure(this.message);
}

class ForbiddenFailure extends Failure {
  final String message;

  ForbiddenFailure(this.message);
}

class NotFoundFailure extends Failure {
  final String message;

  NotFoundFailure(this.message);
}

class NetworkFailure extends Failure {
  final String message;

  NetworkFailure(this.message);
}
