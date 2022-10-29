import 'package:darchat/chat/presentation/pages/chat_screen.dart';
import 'package:darchat/chat/presentation/pages/home.dart';
import 'package:darchat/chat/presentation/pages/signup.dart';
import 'package:flutter/material.dart';

const String home = '/';
const String signup = '/signup';
const String chatScreen = '/chats';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        //final instance = settings.arguments as SignUpPage;
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case signup:
        //final instance = settings.arguments as SignUpPage;
        return MaterialPageRoute(
          builder: (_) => const SignUpPage(),
        );
      case chatScreen:
        final instance = settings.arguments as ChatScreen;
        return MaterialPageRoute(
          builder: (_) => ChatScreen(
            ws: instance.ws,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
