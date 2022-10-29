import 'package:darchat/chat/presentation/bloc/chat_bloc.dart';
import 'package:darchat/chat/presentation/pages/chat_screen.dart';
import 'package:darchat/core/consts/consts.dart';
import 'package:darchat/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChatBloc>(),
      child: Scaffold(
        body: BlocConsumer<ChatBloc, ChatState>(
          listener: (context, state) {
            if (state is WebSocketConnectSuccessState) {
              Navigator.pushReplacementNamed(context, '/chats',
                  arguments: ChatScreen(ws: state.webSocket));
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
            }
            return Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                margin: const EdgeInsets.symmetric(vertical: 80),
                child: Column(
                  children: [
                    Icon(
                      Icons.support_agent_rounded,
                      color: Constants.supportChatBackground,
                      size: 70,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'How can we help you?',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<ChatBloc>(context).add(ConnectEvent());
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 213, 248, 236),
                            border: Border.all(
                                color: Constants.supportChatBackground),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.support_agent_rounded,
                              color: Constants.supportChatBackground,
                              size: 40,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            const Text(
                              'Contact Live Chat',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                              color: Constants.supportChatBackground,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 213, 248, 236),
                      ),
                      child: Icon(
                        Icons.email_outlined,
                        size: 30,
                        color: Constants.supportChatBackground,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Send us an e-mail:',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const Text(
                      'info@daramad.me',
                      style: TextStyle(),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
