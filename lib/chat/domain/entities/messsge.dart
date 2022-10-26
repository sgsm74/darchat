import 'package:equatable/equatable.dart';

class Message extends Equatable {
  const Message({
    required this.id,
    required this.roomId,
    required this.body,
    required this.userId,
    required this.name,
    required this.date,
  });
  final String id;
  final String roomId;
  final String body;
  final String userId;
  final String name;
  final int date;

  @override
  List<Object> get props => [id];
}
