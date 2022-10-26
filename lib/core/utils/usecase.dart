import 'dart:io';

import 'package:darchat/core/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class WebSocketParams extends Equatable {
  const WebSocketParams({required this.ws});

  final WebSocket ws;

  @override
  List<Object?> get props => [ws];
}
