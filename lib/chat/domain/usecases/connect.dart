import 'dart:io';

import 'package:darchat/chat/domain/repositories/chat_repository.dart';
import 'package:darchat/core/errors/errors.dart';
import 'package:darchat/core/utils/usecase.dart';
import 'package:dartz/dartz.dart';

class ConnectUseCase implements UseCase<WebSocket, NoParams> {
  const ConnectUseCase({
    required this.repository,
  });
  final ChatRepository repository;

  @override
  Future<Either<Failure, WebSocket>> call(params) {
    return repository.connect();
  }
}
