import 'dart:async';

class CustomException implements Exception {
  final String message;
  final String? code;
  final dynamic data;
  final StackTrace? stackTrace;

  const CustomException(
    this.message, {
    this.code,
    this.data,
    this.stackTrace,
  });

  @override
  String toString() {
    if (code != null) {
      return 'CustomException($code): $message';
    }
    return 'CustomException: $message';
  }

  // Helper method to get user-friendly message
  String get userMessage => message;
}

// Network-related exceptions
class FetchDataException extends CustomException {
  FetchDataException(super.message, {super.code, super.data});
  
  @override
  String toString() => 'FetchDataException: $message';
}

class BadRequestException extends CustomException {
  BadRequestException(super.message, {String? code, super.data}) 
      : super(code: code ?? '400');
  
  @override
  String toString() => 'BadRequestException: $message';
}

class UnauthorizedException extends CustomException {
  UnauthorizedException(super.message, {String? code, super.data}) 
      : super(code: code ?? '401');
  
  @override
  String toString() => 'UnauthorizedException: $message';
}

class ForbiddenException extends CustomException {
  ForbiddenException(super.message, {String? code, super.data}) 
      : super(code: code ?? '403');
  
  @override
  String toString() => 'ForbiddenException: $message';
}

class NotFoundException extends CustomException {
  NotFoundException(super.message, {String? code, super.data}) 
      : super(code: code ?? '404');
  
  @override
  String toString() => 'NotFoundException: $message';
}

class ConflictException extends CustomException {
  ConflictException(super.message, {String? code, super.data}) 
      : super(code: code ?? '409');
  
  @override
  String toString() => 'Error: $message';
}

class InternalServerErrorException extends CustomException {
  InternalServerErrorException(super.message, {String? code, super.data}) 
      : super(code: code ?? '500');
  
  @override
  String toString() => 'Error: $message';
}

class ServiceUnavailableException extends CustomException {
  ServiceUnavailableException(super.message, {String? code, super.data}) 
      : super(code: code ?? '503');
  
  @override
  String toString() => 'Error: $message';
}

// Validation exceptions
class ValidationException extends CustomException {
  final Map<String, List<String>>? fieldErrors;
  
  ValidationException(
    super.message, {
    this.fieldErrors,
    String? code,
    super.data,
  }) : super(code: code ?? 'VALIDATION_ERROR');
  
  @override
  String toString() => 'Error: $message';
  
  // Get errors for a specific field
  List<String>? getFieldErrors(String field) => fieldErrors?[field];
  
  // Get first error for a field
  String? getFirstFieldError(String field) => fieldErrors?[field]?.first;
  
  // Check if has field errors
  bool hasFieldErrors() => fieldErrors != null && fieldErrors!.isNotEmpty;
}

// Cache exceptions
class CacheException extends CustomException {
  CacheException(super.message, {String? code, super.data}) 
      : super(code: code ?? 'CACHE_ERROR');
  
  @override
  String toString() => 'Error: $message';
}

// Database exceptions
class DatabaseException extends CustomException {
  DatabaseException(super.message, {String? code, super.data}) 
      : super(code: code ?? 'DATABASE_ERROR');
  
  @override
  String toString() => 'Error: $message';
}

// File/Storage exceptions
class FileException extends CustomException {
  final String? filePath;
  
  FileException(
    super.message, {
    this.filePath,
    String? code,
    super.data,
  }) : super(code: code ?? 'FILE_ERROR');
  
  @override
  String toString() => 'Error: $message${filePath != null ? ' (Path: $filePath)' : ''}';
}

// Permission exceptions
class PermissionException extends CustomException {
  final String? requiredPermission;
  
  PermissionException(
    super.message, {
    this.requiredPermission,
    String? code,
    super.data,
  }) : super(code: code ?? 'PERMISSION_ERROR');
  
  @override
  String toString() => 'Error: $message';
}

// Business logic exceptions
class BusinessLogicException extends CustomException {
  BusinessLogicException(super.message, {String? code, super.data}) 
      : super(code: code ?? 'BUSINESS_ERROR');
  
  @override
  String toString() => 'Error: $message';
}

// Utility class for exception handling
class ExceptionHandler {
  static String getUserFriendlyMessage(Exception exception) {
    if (exception is CustomException) {
      return exception.userMessage;
    }
    
    // Handle common Flutter/Dart exceptions
    if (exception is FormatException) {
      return 'Invalid data format received from server';
    }
    
    if (exception is TypeError) {
      return 'Data type mismatch. Please try again.';
    }
    
    if (exception is NoSuchMethodError) {
      return 'Unexpected data structure received from server';
    }
    
    if (exception is TimeoutException) {
      return 'Request timed out. Please check your connection.';
    }
    
    // Generic fallback
    return 'An unexpected error occurred. Please try again.';
  }
  
  static bool isNetworkError(Exception exception) {
    return exception is FetchDataException ||
           exception is BadRequestException ||
           exception is UnauthorizedException ||
           exception is NotFoundException ||
           exception is InternalServerErrorException ||
           exception is ServiceUnavailableException;
  }
  
  static bool isUserError(Exception exception) {
    return exception is ValidationException ||
           exception is PermissionException ||
           exception is BusinessLogicException;
  }
  
  static bool isSystemError(Exception exception) {
    return exception is DatabaseException ||
           exception is CacheException ||
           exception is FileException;
  }
}