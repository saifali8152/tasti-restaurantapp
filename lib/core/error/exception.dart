class FetchDataException implements Exception {
  final String message;
  FetchDataException(this.message);

  @override
  String toString() => message;
}


class BadRequestException extends FetchDataException {
  BadRequestException(super.message);
}

class UnauthorizedException extends FetchDataException {
  UnauthorizedException(super.message);
}

class NotFoundException extends FetchDataException {
  NotFoundException(super.message);
}

class ConflictException extends FetchDataException {
  ConflictException(super.message);
}

class InternalServerErrorException extends FetchDataException {
  InternalServerErrorException(super.message);
}
