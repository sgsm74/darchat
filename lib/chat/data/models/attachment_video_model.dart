import 'package:darchat/chat/domain/entities/attachment_video.dart';

class AttachmentVideoModel extends AttachmentVideo {
  const AttachmentVideoModel({
    required super.id,
    required super.title,
    required super.link,
    required super.url,
    required super.size,
  });

  factory AttachmentVideoModel.fromJson(Map<String, dynamic> json) {
    final data = json['fields']['args'];
    final attachments = json['fields']['args']['attachments'];
    return AttachmentVideoModel(
      id: data['files']['_id'],
      title: attachments['title'],
      link: attachments['title_link'],
      url: attachments['video_url'],
      size: attachments['video_size'],
    );
  }
}
