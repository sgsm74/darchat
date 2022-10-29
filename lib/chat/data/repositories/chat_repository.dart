import 'dart:convert';
import 'dart:io';

import 'package:darchat/chat/data/models/connect.dart';
import 'package:darchat/chat/data/models/initial_data.dart';

import 'package:darchat/core/utils/ok.dart';
import 'package:dartz/dartz.dart';

import 'package:darchat/chat/data/datasources/chat_remote_datasource.dart';
import 'package:darchat/chat/domain/repositories/chat_repository.dart';
import 'package:darchat/core/errors/errors.dart';
import 'package:dio/dio.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl({
    required this.chatRemoteDataSource,
  });
  final ChatRemoteDataSource chatRemoteDataSource;

  @override
  Future<Either<Failure, WebSocket>> connect() async {
    try {
      final ws = await chatRemoteDataSource.connect();
      await initial(ws);
      // ws.asBroadcastStream().listen((data) => {
      //       //print(jsonDecode(data)),
      //       if (jsonDecode(data)['msg'] == 'ping')
      //         {ws.add(jsonEncode(PongModel().toJson()))}
      //     });
      return Right(ws);
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, OK>> add<T>(WebSocket ws, T data) async {
    try {
      await chatRemoteDataSource.add<T>(ws, data);
      return Right(OK());
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, OK>> disconnect<T>(WebSocket ws) async {
    try {
      chatRemoteDataSource.close(ws);
      return Right(OK());
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  Future<Either<Failure, OK>> initial(WebSocket ws) async {
    try {
      add(ws, jsonEncode(ConnectModel().toJson()));
      add(ws, jsonEncode(InitialData().toJson()));
      //await Future.delayed(const Duration(seconds: 3));
      //await add(ws, jsonEncode(VisitorModel().toJson()));
      //await Future.delayed(const Duration(seconds: 5));
      return Right(OK());
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, OK>> upload<T>(File file) async {
    try {
      await chatRemoteDataSource.upload(file);
      return Right(OK());
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  // Future<Either<Failure, T>> listen<T>(WebSocket ws) async {
  //   try {
  //     ws.listen(
  //       (event) {},
  //     );
  //     return Right(ws);
  //   } on SocketException catch (e) {
  //     return Left(ServerFailure(message: e.message));
  //   }
  // }
}
