import 'dart:developer';

class ErrorHandler implements Exception {
  final String errorText;
  ErrorHandler(this.errorText) {
    log(errorText);
  }
}
