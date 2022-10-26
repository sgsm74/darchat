import 'dart:async';
import 'dart:io';

import 'package:darchat/core/consts/consts.dart';
import 'package:darchat/core/utils/ok.dart';

abstract class ChatRemoteDataSource {
  Future<WebSocket> connect();
  Future<OK> add<T>(WebSocket ws, T data);
  Future<dynamic> close(WebSocket ws);
  //Future<T> listen<T>(WebSocket ws);
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
}
