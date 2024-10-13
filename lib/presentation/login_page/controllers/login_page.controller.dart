import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../infrastructure/navigation/routes.dart';

class LoginPageController extends GetxController {
  static const String baseUrl = 'https://warmindoanggrekmuria.my.id/api/';

  @override
  void onInit() {
    usernameController.text = 'fatih';
    passwordController.text = 'fatih3';
    super.onInit();
  }

  // Controllers for form inputs
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Observables for UI states
  var isLoading = false.obs;
  var isAuth = false.obs;

  // Method to handle login process
  Future<void> login() async {
    isLoading.value = true;

    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      dialogError('Username dan Password tidak boleh kosong');
      isLoading.value = false;
      return;
    }

    try {
      final url = Uri.parse('${baseUrl}user/login');
      final response = await http.post(
        url,
        body: {
          'login': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        print(username);
        final responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          final data = responseData['user'];
          final token = responseData['access_token'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          await prefs.setString('username', username);

          await prefs.setString(
              'dataUser',
              json.encode({
                'username': username,
                'password': password,
                'name': data['name'],
                'id': data['id'],
                'role': data['role'],
              }));
          isAuth.value = true;
          Get.offAllNamed(Routes.NAVBAR);
        } else {
          String message = responseData['message'] ?? 'Login failed';
          dialogError(message);
        }
      } else {
        dialogError('Login failed');
      }
    } catch (e) {
      dialogError('Pastikan akun anda telah terdaftar');
    } finally {
      isLoading.value = false;
    }
  }
  void dialogError(String message) {
    Get.snackbar("Error", message, snackPosition: SnackPosition.BOTTOM);
  }
}
