import 'package:darchat/chat/domain/entities/attachment_image.dart';

class AttachmentImageModel extends AttachmentImage {
  const AttachmentImageModel({
    required super.id,
    required super.title,
    required super.link,
    super.url,
    super.size,
    super.height,
    super.width,
    super.preview,
  });

  factory AttachmentImageModel.fromJson(Map<String, dynamic> json) {
    final data = json['fields']['args'].first;
    final attachments = json['fields']['args'].first['attachments'].first;
    return AttachmentImageModel(
      id: data['file']['_id'],
      title: attachments['title'],
      link: attachments['title_link'],
      url: attachments['image_url'],
      size: attachments['image_size'],
      width: attachments['image_dimensions']?['width'],
      height: attachments['image_dimensions']?['height'],
      preview: attachments['image_preview'],
    );
  }
  AttachmentImage toEntity() {
    return AttachmentImage(
      id: id,
      title: title,
      link: link,
      width: width,
      height: height,
      preview: preview,
      url: url,
      size: size,
    );
  }
}
