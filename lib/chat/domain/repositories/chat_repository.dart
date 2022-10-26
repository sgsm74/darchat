import 'dart:io';

import 'package:darchat/core/errors/errors.dart';
import 'package:darchat/core/utils/ok.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<Failure, WebSocket>> connect();
  Future<Either<Failure, OK>> add<T>(WebSocket ws, T data);
  Future<Either<Failure, OK>> disconnect<T>(WebSocket ws);
}
