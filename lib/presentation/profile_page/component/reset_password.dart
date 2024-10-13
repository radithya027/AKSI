import 'package:aksi/infrastructure/theme/theme.dart';
import 'package:aksi/presentation/profile_page/controllers/profile_page.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePassword extends GetView<ProfilePageController> {
  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Scaffold(
      backgroundColor: Primary.background,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.05,
            ),
            decoration: BoxDecoration(
              color: Primary.white,
              borderRadius: defaultBorderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Update Password",
                  style: AppTextStyle.tsTitleBold(Primary.black),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                buildPasswordField(
                    controller: currentPasswordController,
                    label: "Sandi sekarang"),
                SizedBox(height: 16),
                buildPasswordField(
                    controller: newPasswordController, label: "Sandi baru"),
                SizedBox(height: 16),
                buildPasswordField(
                    controller: confirmPasswordController,
                    label: "Konfirmasi sandi baru"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      final currentPassword =
                          currentPasswordController.text.trim();
                      final newPassword = newPasswordController.text.trim();
                      final confirmPassword =
                          confirmPasswordController.text.trim();

                      if (newPassword != confirmPassword) {
                        dialogError('Password baru tidak sesuai');
                        return;
                      }

                      try {
                        await controller.changePassword(
                          currentPassword,
                          newPassword,
                          confirmPassword,
                        );
                        dialogSuccess('Password berhasil diperbarui');
                      } catch (e) {
                        dialogError('Gagal memperbarui password');
                        print('Error: $e');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Primary.blue400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                    ),
                    child: Text(
                      "Ubah Kata Sandi",
                      style: AppTextStyle.tsSmallBold(Primary.bg),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to build password input fields
  Widget buildPasswordField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Primary.grey),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Primary.blue500),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Primary.blue500),
        ),
      ),
    );
  }

  // Dialogs for success and error messages
  void dialogSuccess(String message) {
    Get.snackbar(
      'Berhasil',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Primary.blue100,
      colorText: Primary.black,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
    );
  }

  void dialogError(String message) {
    Get.snackbar(
      'Gagal',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red[600],
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
    );
  }
}
