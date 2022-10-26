import 'package:darchat/chat/domain/entities/department.dart';
import 'package:equatable/equatable.dart';

class ChatData extends Equatable {
  const ChatData({
    required this.id,
    required this.enabled,
    required this.title,
    required this.color,
    required this.registrationForm,
    required this.departments,
    required this.allowSwitchingDepartments,
    required this.online,
    required this.offlineMessage,
    required this.offlineColor,
    required this.offlineSuccessMessage,
    required this.offlineUnavailableMessage,
    required this.displayOfflineForm,
    required this.videoCall,
    required this.fileUpload,
    required this.conversationFinishedMessage,
    required this.conversationFinishedText,
    required this.nameFieldRegistrationForm,
    required this.emailFieldRegistrationForm,
    required this.registrationFormMessage,
    required this.showConnecting,
    required this.offlineTitle,
    required this.language,
    required this.transcript,
    required this.transcriptMessage,
  });

  final String id;
  final bool enabled;
  final String title;
  final String color;
  final bool registrationForm;
  //final List? room;
  //final List triggers;
  final List<Department> departments;
  final bool allowSwitchingDepartments;
  final bool online;
  final String offlineMessage;
  final String offlineColor;
  final String offlineSuccessMessage;
  final String offlineUnavailableMessage;
  final bool displayOfflineForm;
  final bool videoCall;
  final bool fileUpload;
  final String conversationFinishedMessage;
  final String conversationFinishedText;
  final bool nameFieldRegistrationForm;
  final bool emailFieldRegistrationForm;
  final String registrationFormMessage;
  final bool showConnecting;
  final String offlineTitle;
  final String language;
  final bool transcript;
  final String transcriptMessage;

  @override
  List<Object> get props => [id];
}
