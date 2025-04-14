import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  const Labels({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    String title = '';
    String subtitle = '';
    switch (route) {
      case 'login':
        title = "No tienes cuenta?";
        subtitle = "Crea una ahora!";
        break;
      case 'register':
        title = "Ya tienes una cuenta?";
        subtitle = "Inicia sesion";
        break;
      default:
    }

    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, route);
            },
            child: Text(
              subtitle,
              style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
