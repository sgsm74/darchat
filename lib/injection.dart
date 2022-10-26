import 'package:darchat/chat/data/datasources/chat_remote_datasource.dart';
import 'package:darchat/chat/data/repositories/chat_repository.dart';
import 'package:darchat/chat/domain/repositories/chat_repository.dart';
import 'package:darchat/chat/domain/usecases/connect.dart';
import 'package:darchat/chat/presentation/bloc/chat_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  _injectChat();
}

void _injectChat() {
  //bloc
  sl.registerFactory(
    () => ChatBloc(connectUseCase: sl()),
  );

  //usecase
  sl.registerLazySingleton(() => ConnectUseCase(repository: sl()));

  //repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(chatRemoteDataSource: sl()),
  );

  //datasource
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(),
  );
}
