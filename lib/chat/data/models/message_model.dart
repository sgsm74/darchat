import 'package:darchat/chat/domain/entities/messsge.dart';
import 'package:darchat/chat/domain/entities/method.dart';
import 'package:darchat/core/consts/consts.dart';
import 'package:uuid/uuid.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.roomId,
    required super.body,
    required super.userId,
    required super.name,
    required super.date,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      roomId: json['fields']['args'].first['rid'],
      body: json['fields']['args'].first['msg'],
      userId: json['fields']['args'].first['u']['_id'],
      name: json['fields']['args'].first['u']['name'],
      date: json['fields']['args'].first['ts']['\$date'],
    );
  }
  toJson(String message) {
    return {
      "msg": "method",
      "method": Method.sendMessageLivechat.value,
      "id": const Uuid().v4(),
      "params": [
        {
          "_id": const Uuid().v4(),
          "rid": SokcetData.roomId,
          "msg": message,
          "token": SokcetData.myToken
        }
      ]
    };
  }

  Message toEntity() {
    return Message(
      id: id,
      roomId: roomId,
      body: body,
      userId: userId,
      name: name,
      date: date,
    );
  }
}
