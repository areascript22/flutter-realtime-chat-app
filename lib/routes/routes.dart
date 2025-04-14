import 'package:flutter/material.dart';
import 'package:realtime_chat_app/pages/chat_page.dart';
import 'package:realtime_chat_app/pages/loading_page.dart';
import 'package:realtime_chat_app/pages/login_page.dart';
import 'package:realtime_chat_app/pages/register_page.dart';
import 'package:realtime_chat_app/pages/users_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'usuarios': (_) => UserPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
};
