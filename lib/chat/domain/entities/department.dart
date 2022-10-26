import 'package:equatable/equatable.dart';

class Department extends Equatable {
  const Department({
    required this.id,
    required this.enabled,
    required this.name,
    required this.description,
    required this.showOnRegistration,
    required this.showOnOfflineForm,
    required this.requestTagBeforeClosingChat,
    required this.email,
    required this.offlineMessageChannelName,
    required this.abandonedRoomsCloseCustomMessage,
    required this.waitingQueueMessage,
    required this.departmentsAllowedToForward,
    required this.updatedAt,
    required this.numAgents,
  });

  final String id;
  final bool enabled;
  final String name;
  final String description;
  final bool showOnRegistration;
  final bool showOnOfflineForm;
  final bool requestTagBeforeClosingChat;
  final String email;
  final String offlineMessageChannelName;
  final String abandonedRoomsCloseCustomMessage;
  final String waitingQueueMessage;
  final String departmentsAllowedToForward;
  final int updatedAt;
  final int numAgents;

  @override
  List<Object> get props => [id];
}
