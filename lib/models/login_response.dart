// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:realtime_chat_app/models/usuario.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool ok;
  Usuario usuario;
  String token;

  LoginResponse({required this.ok, required this.usuario, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    ok: json["ok"],
    usuario: Usuario.fromJson(json['usuario'] ?? json["msg"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "msg": usuario.toJson(),
    "token": token,
  };
}
