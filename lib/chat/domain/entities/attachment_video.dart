import 'package:equatable/equatable.dart';

class AttachmentVideo extends Equatable {
  const AttachmentVideo({
    required this.id,
    required this.title,
    required this.link,
    required this.url,
    required this.size,
  });
  final String id;
  final String title;
  final String link;
  final String url;
  final int size;

  @override
  List<Object> get props => [id];
}
