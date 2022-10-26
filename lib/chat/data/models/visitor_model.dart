import 'package:darchat/chat/domain/entities/method.dart';
import 'package:darchat/chat/domain/entities/visitor.dart';
import 'package:darchat/core/consts/consts.dart';
import 'package:uuid/uuid.dart';

class VisitorModel extends Visitor {
  const VisitorModel({
    required super.id,
    required super.token,
    required super.name,
    required super.userName,
    required super.email,
    required super.departmentId,
  });

  factory VisitorModel.fromJson(Map<String, dynamic> json) {
    return VisitorModel(
      id: json['result']['userId'],
      token: json['result']['visitor']['token'],
      name: json['result']['visitor']['name'],
      userName: json['result']['visitor']['username'],
      email: json['result']['visitor']['visitorEmails'].first["address"],
      departmentId: json['result']['visitor']['department'],
    );
  }
  toJson() {
    return {
      "msg": "method",
      "method": Method.livechatRegisterGuest.value,
      "id": const Uuid().v4(),
      "params": [
        {
          "token": SokcetData.myToken,
          "name": 'Saeed',
          "email": 's.gh4286@gmail.com',
          "department": 'NbSRLPw8vDLiGhmvA'
        }
      ]
    };
  }

  Visitor toEntity() {
    return Visitor(
      id: id,
      token: token,
      name: name,
      userName: userName,
      email: email,
      departmentId: departmentId,
    );
  }
}
