import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat_app/global/environments.dart';
import 'package:realtime_chat_app/models/login_response.dart';
import 'package:realtime_chat_app/models/usuario.dart';

class AuthService with ChangeNotifier {
  Usuario? usuario;
  bool _autenticando = false;
  final _storage = FlutterSecureStorage();

  //getters
  bool get autenticando => _autenticando;

  //setters
  set autenticando(bool value) {
    _autenticando = value;
    notifyListeners();
  }

  //get token
  static Future<String?> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  //Login
  Future<bool> login(String email, String password) async {
    autenticando = true;
    print("SENDING 1: $email  $password");
    try {
      final data = {'email': email, 'password': password};
      //En IOS se peude localhost, en Android no
      final resp = await http.post(
        Uri.parse("${Environments.apiUrl}/login"),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      autenticando = false;
      if (resp.statusCode == 200) {
        final loginResp = loginResponseFromJson(resp.body);
        usuario = loginResp.usuario;
        //TODO guardar token en lugar seguro
        await _saveToken(loginResp.token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("An error has ocurred: $e");
      autenticando = false;
      return false;
    }
  }

  //register
  Future<Object> register(String name, String email, String password) async {
    autenticando = true;
    try {
      final data = {'name': name, 'email': email, 'password': password};
      //En IOS se peude localhost, en Android no
      final resp = await http.post(
        Uri.parse("${Environments.apiUrl}/login/new"),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      print("Registe response: ${resp.body}");
      autenticando = false;
      if (resp.statusCode == 200) {
        final loginResp = loginResponseFromJson(resp.body);
        usuario = loginResp.usuario;
        //TODO guardar token en lugar seguro
        await _saveToken(loginResp.token);
        return true;
      } else {
        final respBody = jsonDecode(resp.body);
        return respBody['msg'];
      }
    } catch (e) {
      print("An error has ocurred: $e");
      autenticando = false;
      return 'Ha ocurrido un error';
    }
  }

  //
  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    print("SAVED TOKEN : $token");
    final response = await http.get(
      Uri.parse('${Environments.apiUrl}/login/renew'),
      headers: {'Content-Type': 'application/json', 'x-token': token ?? 'n/a'},
    );
    print("Is logged in response: ${response.body}  ${response.statusCode}");
    if (response.statusCode == 200) {
      print('response 200');

      final loginResponse = loginResponseFromJson(response.body);
      print('response 200 2');
      usuario = loginResponse.usuario;
      print('response 200 3');
      await _saveToken(loginResponse.token);
      print('token saved succesfully');
      return true;
    } else {
      logOut();
      return false;
    }
  }

  //save token
  Future<void> _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  //LogOut
  Future<void> logOut() async {
    // Delete value
    await _storage.delete(key: 'token');
  }
}
