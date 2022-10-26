import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:darchat/chat/domain/usecases/connect.dart';
import 'package:darchat/core/utils/usecase.dart';
import 'package:flutter/material.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ConnectUseCase connectUseCase;
  ChatBloc({required this.connectUseCase}) : super(ChatInitial()) {
    on<ChatEvent>((event, emit) async {
      if (event is ConnectEvent) {
        await _onConnectEvent(event, emit);
      } else if (event is DisconnectEvent) {
        await _onDisconnectEvent(event, emit);
      }
    });
  }

  FutureOr<void> _onConnectEvent(
    ConnectEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoadingState());
    final result = await connectUseCase(NoParams());
    emit(result.fold((error) => ChatErrorState(message: error.message),
        (socket) => WebSocketConnectSuccessState(webSocket: socket)));
  }

  FutureOr<void> _onDisconnectEvent(
    DisconnectEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoadingState());
    final result = await connectUseCase(NoParams());
    emit(result.fold((error) => ChatErrorState(message: error.message),
        (socket) => WebSocketConnectSuccessState(webSocket: socket)));
  }
}
