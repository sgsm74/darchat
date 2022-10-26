import 'package:darchat/chat/domain/entities/department.dart';

class DepartmentModel extends Department {
  const DepartmentModel({
    required super.id,
    required super.enabled,
    required super.name,
    required super.description,
    required super.showOnRegistration,
    required super.showOnOfflineForm,
    required super.requestTagBeforeClosingChat,
    required super.email,
    required super.offlineMessageChannelName,
    required super.abandonedRoomsCloseCustomMessage,
    required super.waitingQueueMessage,
    required super.departmentsAllowedToForward,
    required super.updatedAt,
    required super.numAgents,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['_id'],
      enabled: json['enabled'],
      name: json['name'],
      description: json['description'],
      showOnRegistration: json['showOnRegistration'],
      showOnOfflineForm: json['showOnOfflineForm'],
      requestTagBeforeClosingChat: json['requestTagBeforeClosingChat'],
      email: json['email'],
      offlineMessageChannelName: json['offlineMessageChannelName'],
      abandonedRoomsCloseCustomMessage:
          json['abandonedRoomsCloseCustomMessage'],
      waitingQueueMessage: json['waitingQueueMessage'],
      departmentsAllowedToForward: json['departmentsAllowedToForward'],
      updatedAt: json['_updatedAt']['\$date'],
      numAgents: json['numAgents'],
    );
  }
}
