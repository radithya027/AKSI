import 'package:aksi/infrastructure/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class JurnalController extends GetxController {
  final kegiatanTextController = TextEditingController();
  final judulTextController = TextEditingController();
  var selectedImages = <File>[].obs;
  var isLoading = false.obs; // Observable for loading state

  final String apiUrl = 'https://warmindoanggrekmuria.my.id/api/jurnal/input';
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
      selectedImages.add(File(pickedFile.path));
    }
  }

  void removeImage(File file) {
    selectedImages.removeWhere((element) => element.path == file.path);
  }

  void resetFormData() {
    judulTextController.clear();
    kegiatanTextController.clear();
    selectedImages.clear();
  }

  Future<void> postJurnalData() async {
    isLoading.value = true;
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers.addAll(headers);

    request.fields['name_title'] = judulTextController.text;
    request.fields['activity'] = kegiatanTextController.text;

    for (var imageFile in selectedImages) {
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: basename(imageFile.path),
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
      Get.snackbar(
        'Gagal',
        'Jurnal gagal terkirim',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Primary.red,
        colorText: Colors.white,
      );
      await Future.delayed(Duration(seconds: 1));
      Get.back();
      resetFormData();
    }

    isLoading.value = false;
  }
}
