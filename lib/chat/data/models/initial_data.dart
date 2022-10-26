import 'package:darchat/chat/domain/entities/method.dart';
import 'package:darchat/core/consts/consts.dart';
import 'package:uuid/uuid.dart';

class InitialData {
  toJson() {
    return {
      "msg": "method",
      "method": Method.livechatGetInitialData.value,
      "id": const Uuid().v4(),
      "params": [
        {"visitorToken": SokcetData.myToken}
      ]
    };
  }
}
