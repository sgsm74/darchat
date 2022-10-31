import 'package:equatable/equatable.dart';

class AttachmentImage extends Equatable {
  const AttachmentImage({
    required this.id,
    required this.title,
    required this.link,
    this.width,
    this.height,
    this.preview,
    this.url,
    this.size,
  });
  final String id;
  final String title;
  final String link;
  final int? width;
  final int? height;
  final String? preview;
  final String? url;
  final int? size;

  @override
  List<Object> get props => [id, title, link];
}
