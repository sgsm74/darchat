part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {
  const ChatEvent();
}

class ConnectEvent extends ChatEvent {}

class DisconnectEvent extends ChatEvent {
  const DisconnectEvent({
    required this.ws,
  });

  final WebSocket ws;
}

class SendMessageEvent extends ChatEvent {
  const SendMessageEvent({
    required this.message,
  });
  final String message;
}
