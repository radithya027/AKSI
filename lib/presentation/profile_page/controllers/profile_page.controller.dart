import 'dart:io';

import 'package:aksi/infrastructure/theme/theme.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePageController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  var name = ''.obs;
  var email = ''.obs;
  var role = ''.obs;
  var jobTittle = ''.obs;
  var image = ''.obs;

  // Fetch user details from API
  Future<void> fetchUserDetails() async {
    final url =
        Uri.parse('https://warmindoanggrekmuria.my.id/api/user/details');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          name.value = data['user']['name'];
          email.value = data['user']['email'];
          role.value = data['user']['role'];
          jobTittle.value = data['user']['job_tittle'];
          image.value = data['user']['image'];
        } else {
          Get.snackbar("Error", "Failed to fetch user details");
        }
      } else {
        Get.snackbar("Error", "Unable to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  // Logout the user
  Future<void> logout() async {
    final url = Uri.parse('https://warmindoanggrekmuria.my.id/api/user/logout');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await prefs.remove('token');
        Get.snackbar(
          'Success',
          'You have been logged out',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Primary.blue800,
          colorText: Primary.white,
        );
        Get.offAllNamed('/login');
      } else {
        Get.snackbar("Error", "Failed to logout: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  // Change user password
  Future<void> changePassword(String currentPassword, String newPassword,
      String newPasswordConfirmation) async {
    final url = Uri.parse(
        'https://warmindoanggrekmuria.my.id/api/user/change-password');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPasswordConfirmation,
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['success'] == true) {
          Get.snackbar("Success", "Password changed successfully");
          await logout(); // Log the user out after changing password
        } else {
          Get.snackbar("Error", data['message'] ?? "Failed to change password");
        }
      } else {
        Get.snackbar(
            "Error", "Unable to change password: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  Future<void> pickImageAndUpload() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);

      await uploadImage(imageFile!);
    } else {
      print("No image selected");
    }
  }

  Future<void> uploadImage(File imageFile) async {
    var uri =
        Uri.parse('https://warmindoanggrekmuria.my.id/api/user/update-image');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      print('Error: No token found.');
      return;
    }
    var request = http.MultipartRequest('POST', uri);

    // Adding headers
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));
    request.fields['_method'] = 'put';

    try {
      var response = await request.send();

      var responseData = await http.Response.fromStream(response);
      print('Response data: ${responseData.body}');
      if (response.statusCode == 200) {
        Get.back();
        fetchUserDetails();
        print('Image uploaded successfully: ${responseData.body}');
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        print('Error details: ${responseData.body}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }
}
