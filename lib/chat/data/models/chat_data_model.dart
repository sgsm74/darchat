import 'package:darchat/chat/data/models/department_model.dart';
import 'package:darchat/chat/domain/entities/chat_data.dart';

class ChatDataModel extends ChatData {
  const ChatDataModel({
    required super.id,
    required super.enabled,
    required super.title,
    required super.color,
    required super.registrationForm,
    required super.departments,
    required super.allowSwitchingDepartments,
    required super.online,
    required super.offlineMessage,
    required super.offlineColor,
    required super.offlineSuccessMessage,
    required super.offlineUnavailableMessage,
    required super.displayOfflineForm,
    required super.videoCall,
    required super.fileUpload,
    required super.conversationFinishedMessage,
    required super.conversationFinishedText,
    required super.nameFieldRegistrationForm,
    required super.emailFieldRegistrationForm,
    required super.registrationFormMessage,
    required super.showConnecting,
    required super.offlineTitle,
    required super.language,
    required super.transcript,
    required super.transcriptMessage,
  });

  factory ChatDataModel.fromJson(Map<String, dynamic> json) {
    List<DepartmentModel> departments = [];
    json['result']['departments']
        .forEach((json) => departments.add(DepartmentModel.fromJson(json)));
    return ChatDataModel(
      id: json['id'],
      enabled: json['result']['enabled'],
      title: json['result']['title'],
      color: json['result']['color'],
      registrationForm: json['result']['registrationForm'],
      departments: departments,
      allowSwitchingDepartments: json['result']['allowSwitchingDepartments'],
      online: json['result']['online'],
      offlineMessage: json['result']['offlineMessage'],
      offlineColor: json['result']['offlineColor'],
      offlineSuccessMessage: json['result']['offlineSuccessMessage'],
      offlineUnavailableMessage: json['result']['offlineUnavailableMessage'],
      displayOfflineForm: json['result']['displayOfflineForm'],
      videoCall: json['result']['videoCall'],
      fileUpload: json['result']['fileUpload'],
      conversationFinishedMessage: json['result']
          ['conversationFinishedMessage'],
      conversationFinishedText: json['result']['conversationFinishedText'],
      nameFieldRegistrationForm: json['result']['nameFieldRegistrationForm'],
      emailFieldRegistrationForm: json['result']['emailFieldRegistrationForm'],
      registrationFormMessage: json['result']['registrationFormMessage'],
      showConnecting: json['result']['showConnecting'],
      offlineTitle: json['result']['offlineTitle'],
      language: json['result']['language'],
      transcript: json['result']['transcript'],
      transcriptMessage: json['result']['transcriptMessage'],
    );
  }
  ChatData toEntity() {
    return ChatData(
      id: id,
      enabled: enabled,
      title: title,
      color: color,
      registrationForm: registrationForm,
      departments: departments,
      allowSwitchingDepartments: allowSwitchingDepartments,
      online: online,
      offlineMessage: offlineMessage,
      offlineColor: offlineColor,
      offlineSuccessMessage: offlineSuccessMessage,
      offlineUnavailableMessage: offlineUnavailableMessage,
      displayOfflineForm: displayOfflineForm,
      videoCall: videoCall,
      fileUpload: fileUpload,
      conversationFinishedMessage: conversationFinishedMessage,
      conversationFinishedText: conversationFinishedText,
      nameFieldRegistrationForm: nameFieldRegistrationForm,
      emailFieldRegistrationForm: emailFieldRegistrationForm,
      registrationFormMessage: registrationFormMessage,
      showConnecting: showConnecting,
      offlineTitle: offlineTitle,
      language: language,
      transcript: transcript,
      transcriptMessage: transcriptMessage,
    );
  }
}
