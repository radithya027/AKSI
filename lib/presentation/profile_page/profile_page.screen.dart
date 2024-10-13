import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../infrastructure/theme/theme.dart';
import '../homepage/component/default_appbar.dart';
import '../jurnal/component/popup_dialog.dart';
import 'component/custom_button.dart';
import 'component/profile_list.dart';
import 'component/reset_password.dart';
import 'controllers/profile_page.controller.dart';

class ProfilePageScreen extends GetView<ProfilePageController> {
  const ProfilePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Primary.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(heightScreen * 0.075),
        child: DefaultAppbar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              // Profile Picture
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Obx(() {
                      final imageUrl = controller.image.value;
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: InteractiveViewer(
                                    child: Center(
                                      child: imageUrl.isNotEmpty
                                          ? Image.network(
                                              imageUrl,
                                              scale: 4,
                                            )
                                          : Image.asset(
                                              'lib/infrastructure/assets/icons8-login-100.png',
                                            ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          backgroundImage: imageUrl.isNotEmpty
                              ? NetworkImage(imageUrl) as ImageProvider
                              : AssetImage(
                                      'lib/infrastructure/assets/icons8-login-100.png')
                                  as ImageProvider,
                          backgroundColor: Primary.grey,
                          radius: 60,
                        ),
                      );
                    }),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 99,
                    child: GestureDetector(
                      onTap: () async {
                        await controller.pickImageAndUpload();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Primary.blue600,
                          border: Border.all(color: Primary.white, width: 1),
                        ),
                        child: Icon(
                          IconsaxPlusBold.camera,
                          size: 20,
                          color: Primary.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Obx(() => Text(
                        controller.name.value,
                        style: AppTextStyle.tsTitleBold(Primary.black),
                      )),
                  Obx(() => Text(
                        controller.jobTittle.value,
                        style: AppTextStyle.tsBodyBold(Primary.blue500),
                      )),
                ],
              ),
              spaceHeightNormal,
              Obx(() => ProfileList(
                    title: "Nama Lengkap",
                    description: controller.name.value,
                  )),
              Obx(() => ProfileList(
                    title: "Email",
                    description: controller.email.value,
                  )),
              Obx(() => ProfileList(
                    title: "Role",
                    description: controller.role.value,
                  )),
              Obx(() => ProfileList(
                    title: "Job Title",
                    description: controller.jobTittle.value,
                  )),
              SizedBox(height: 10),
              CustomButton(
                text: "Reset akun password",
                colorButton: Primary.white,
                colorText: Primary.black,
                onPressed: () {
                  Get.to(UpdatePassword());
                },
              ),
              SizedBox(height: 10),
              CustomButton(
                text: "Logout",
                colorButton: Primary.red,
                colorText: Primary.white,
                onPressed: () {
                  showCustomPopupDialog(
                    "Keluar Akun",
                    "Apakah Anda yakin ingin keluar akun?",
                    [
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          "Tidak",
                          style: AppTextStyle.tsBodyRegular(Primary.black),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Primary.blue500)),
                        onPressed: () => controller.logout(),
                        child: Text(
                          "Iya, Keluar",
                          style: AppTextStyle.tsBodyRegular(Primary.white),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
