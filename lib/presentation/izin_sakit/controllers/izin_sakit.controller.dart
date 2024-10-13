import 'package:get/get.dart';

import 'package:aksi/infrastructure/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class IzinSakitController extends GetxController {
  final titleController = TextEditingController();
  final reasonController = TextEditingController();
  var selectedImage = Rxn<File>();
  var isLoading = false.obs;

  final String apiUrl =
      'https://warmindoanggrekmuria.my.id/api/user/input-izin';
  var headers = {'Accept': 'application/json'};

  @override
  void onInit() {
    super.onInit();
    _getToken();
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
  }

  void pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  void removeImage() {
    selectedImage.value = null;
  }

  void resetFormData() {
    titleController.clear();
    reasonController.clear();
    selectedImage.value = null;
  }

  Future<void> postIzinData() async {
    isLoading.value = true;
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers.addAll(headers);

    request.fields['title'] = titleController.text;
    request.fields['reason'] = reasonController.text;

    if (selectedImage.value != null) {
      var stream = http.ByteStream(selectedImage.value!.openRead());
      var length = await selectedImage.value!.length();
      var multipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: basename(selectedImage.value!.path),
      );
      request.files.add(multipartFile);
    }

    var response = await request.send();
    if (response.statusCode == 201) {
      Get.snackbar(
        'Success',
        'Jurnal berhasil dikirim',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Primary.blue100,
        colorText: Colors.white,
      );
      await Future.delayed(Duration(seconds: 1));
      Get.back();
      resetFormData();
    } else {
      print(response.statusCode);
      Get.snackbar(
        'Gagal',
        'Jurnal gagal terkirim',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Primary.red,
        colorText: Colors.white,
      );
      await Future.delayed(Duration(seconds: 1));
      Get.back();
      // resetFormData();
    }

    isLoading.value = false;
  }
}
