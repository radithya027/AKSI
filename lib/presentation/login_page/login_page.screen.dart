import 'package:aksi/infrastructure/navigation/routes.dart';
import 'package:aksi/infrastructure/theme/theme.dart';
import 'package:aksi/presentation/login_page/component/custom_TextFormField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/login_page.controller.dart';

class LoginPageScreen extends GetView<LoginPageController> {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add SVG Image below the AppBar
              Image.asset(
                'lib/infrastructure/assets/logo2.png',
                height: 100,
                width: 100, // Adjust width as needed
              ),
              SizedBox(height: 30),
              Text(
                "Welcome Back",
                style: AppTextStyle.tsBigTitleBold(Primary.black),
              ),
              SizedBox(height: 5),
              Text(
                "To Aksi",
                style: AppTextStyle.tsBigTitleBold(Primary.blue400),
              ),
              SizedBox(height: 5),
              Text(
                "Hello there, login to continue",
                style: AppTextStyle.tsSmallRegular(Primary.grey),
              ),
              SizedBox(height: 30),
              CustomTextFormField(
                labelText: "Email Address Or Username",
                controller: controller.usernameController, // Updated
                onChanged: (value) =>
                    controller.usernameController.text = value,
              ),
              SizedBox(height: 15),
              CustomTextFormField(
                labelText: "Password",
                isPassword: true,
                controller: controller.passwordController, // Updated
                onChanged: (value) =>
                    controller.passwordController.text = value,
              ),
              SizedBox(height: 50),
              Obx(() {
                return InkWell(
                  onTap: controller.isLoading.value
                      ? null
                      : () => controller.login(),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Primary.blue500,
                    ),
                    child: Center(
                      child: controller.isLoading.value
                          ? CircularProgressIndicator(color: Primary.white)
                          : Text(
                              "Login",
                              style: AppTextStyle.tsBodyRegular(Primary.white),
                            ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
