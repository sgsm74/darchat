part of 'chat_bloc.dart';

@immutable
abstract class ChatState {
  const ChatState();
}

class ChatInitial extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatErrorState extends ChatState {
  const ChatErrorState({
    required this.message,
  });
  final String message;
}

class WebSocketConnectSuccessState extends ChatState {
  const WebSocketConnectSuccessState({
    required this.webSocket,
  });
  final WebSocket webSocket;
}

class WebSocketDisonnectSuccessState extends ChatState {
  const WebSocketDisonnectSuccessState();
}

class AddEventSuccessState extends ChatState {}

class UploadSuccessState extends ChatState {}
