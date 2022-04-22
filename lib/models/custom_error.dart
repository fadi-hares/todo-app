import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String message;
  final int resultCode;
  CustomError({
    required this.message,
    required this.resultCode,
  });

  @override
  List<Object> get props => [message, resultCode];

  @override
  String toString() =>
      'CustomError(message: $message, resultCode: $resultCode)';
}
