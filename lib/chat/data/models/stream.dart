import 'package:darchat/core/consts/consts.dart';
import 'package:uuid/uuid.dart';

class StreamModel {
  toJson() {
    return {
      "msg": "sub",
      "id": const Uuid().v4(),
      "name": "stream-room-messages",
      "params": [
        SokcetData.roomId,
        {
          "useCollection": false,
          "args": [
            {"visitorToken": SokcetData.myToken}
          ]
        }
      ]
    };
  }
}
