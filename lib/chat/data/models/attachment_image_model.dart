import 'package:darchat/chat/domain/entities/attachment_image.dart';

class AttachmentImageModel extends AttachmentImage {
  const AttachmentImageModel({
    required super.id,
    required super.title,
    required super.link,
    required super.url,
    required super.size,
    required super.height,
    required super.width,
    required super.preview,
  });

  factory AttachmentImageModel.fromJson(Map<String, dynamic> json) {
    final data = json['fields']['args'];
    final attachments = json['fields']['args']['attachments'];
    return AttachmentImageModel(
      id: data['file']['_id'],
      title: attachments['title'],
      link: attachments['title_link'],
      url: attachments['image_url'],
      size: attachments['image_size'],
      width: attachments['image_dimensions']['width'],
      height: attachments['image_dimensions']['height'],
      preview: attachments['image_preview'],
    );
  }
}
