import 'package:darchat/chat/domain/repositories/chat_repository.dart';
import 'package:darchat/core/errors/errors.dart';
import 'package:darchat/core/utils/ok.dart';
import 'package:darchat/core/utils/usecase.dart';
import 'package:dartz/dartz.dart';

class UploadUseCase implements UseCase<OK, UploadParams> {
  const UploadUseCase({
    required this.repository,
  });
  final ChatRepository repository;

  @override
  Future<Either<Failure, OK>> call(params) {
    return repository.upload(params.file);
  }
}
