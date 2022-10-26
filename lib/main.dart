import 'dart:io';

import 'package:flutter/material.dart';
import 'package:darchat/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat/presentation/bloc/chat_bloc.dart';
import 'chat/presentation/pages/chat_screen.dart';
import 'core/consts/consts.dart';
import 'injection.dart';

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffFCEDEA),
          fontFamily: 'Dana',
          appBarTheme: AppBarTheme(
            backgroundColor: Constants.kBackgroundColor,
            elevation: 0,
          )),
      home: BlocProvider(
        create: (context) => sl<ChatBloc>()..add(ConnectEvent()),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebSocket? ws;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is WebSocketConnectSuccessState) {
            ws = state.webSocket;
          }
        },
        builder: (context, state) {
          if (state is ChatLoadingState) {
            return const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is WebSocketConnectSuccessState) {
            return ChatScreen(
              ws: ws!,
            );
          }
          return const SizedBox();
        },
      ),
      // floatingActionButton: Row(
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () {
      //         BlocProvider.of<ChatBloc>(context).add(ConnectEvent());
      //       },
      //       tooltip: 'Increment',
      //       child: const Icon(Icons.add),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () async {
      //         await ws!.close();
      //       },
      //       tooltip: 'dec',
      //       child: const Icon(Icons.minor_crash),
      //     ),
      //   ],
      // ),
    );
  }
}
