import 'package:flutter/material.dart';
import 'package:realtime_chat_app/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat app',
      initialRoute: 'login',
      routes: appRoutes,
    ); 
  }
}
