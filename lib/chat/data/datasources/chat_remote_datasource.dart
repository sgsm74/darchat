import 'dart:async';
import 'dart:io';

import 'package:darchat/core/consts/consts.dart';
import 'package:darchat/core/errors/errors.dart';
import 'package:darchat/core/utils/ok.dart';
import 'package:dio/dio.dart';

abstract class ChatRemoteDataSource {
  Future<WebSocket> connect();
  Future<OK> add<T>(WebSocket ws, T data);
  Future<dynamic> close(WebSocket ws);
  //Future<T> listen<T>(WebSocket ws);
  Future<OK> upload(File file);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  @override
  Future<WebSocket> connect() async {
    return await WebSocket.connect(SokcetData.websocket);
  }

  @override
  Future<OK> add<T>(WebSocket ws, T data) async {
    ws.add(data);
    return OK();
  }

  @override
  Future<dynamic> close(WebSocket ws) async {
    return ws.close();
  }

  @override
  Future<OK> upload(File file) async {
    Dio dio = Dio();
    try {
      FormData formData = FormData.fromMap({
        "file": file,
      });
      final result = await dio.post(
        SokcetData.upload(SokcetData.roomId),
        data: formData,
        options: Options(
          headers: {
            'x-visitor-token': SokcetData.myToken,
            'content-type':
                'multipart/form-data; boundary=----WebKitFormBoundarySBoorupw4A3Qnjpr',
          },
        ),
      );
      print(result);
      return OK();
    } on DioError catch (e) {
      throw ServerFailure(message: e.message);
    }
  }
}
