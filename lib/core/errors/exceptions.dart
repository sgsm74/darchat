import 'package:equatable/equatable.dart';

///This is used to report server Exceptions like 404,500,etc.
class ServerException extends Equatable implements Exception {
  const ServerException({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class PortException extends Equatable implements Exception {
  const PortException({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
