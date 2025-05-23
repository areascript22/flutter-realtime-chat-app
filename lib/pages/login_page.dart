import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat_app/helpers/mostrar_alerta.dart';
import 'package:realtime_chat_app/services/auth_service.dart';
import 'package:realtime_chat_app/widgets/btn_blue.dart';
import 'package:realtime_chat_app/widgets/custom_input.dart';
import 'package:realtime_chat_app/widgets/labels.dart';
import 'package:realtime_chat_app/widgets/logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(title: "Messenger"),
                //
                CustomForm(),
                //
                Labels(route: 'register'),
                //
                Text(
                  "Terminos y ocnidciones de uso",
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final emailCtrl = TextEditingController();
  final passlCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: true);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.email_outlined,
            placeHolder: "Email",
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeHolder: "Password",
            isPassword: true,
            textController: passlCtrl,
          ),

          //TODO crear boton
          BlueButton(
            onPressed:
                !authService.autenticando
                    ? () async {
                      FocusScope.of(context).unfocus();
                      final response = await authService.login(
                        emailCtrl.text.trim(),
                        passlCtrl.text.trim(),
                      );
                      if (response) {
                        //Connect to our socket server
                        //Navigato to another page
                        if (context.mounted) {
                          Navigator.pushReplacementNamed(context, 'usuarios');  
                        }
                      } else {
                        //Show alert
                        if (context.mounted) {
                          mostrarAlerta(
                            context,
                            "Login incorrecto",
                            "Revise sus credenciales",
                          );
                        }
                      }
                    }
                    : null,
          ),
        ],
      ),
    );
  }
}
