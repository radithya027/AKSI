import 'package:aksi/infrastructure/theme/theme.dart';
import 'package:aksi/presentation/homepage/homepage.screen.dart';
import 'package:aksi/presentation/screens.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class NavbarScreen extends StatelessWidget {
  const NavbarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          backgroundColor: Primary.background,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(IconsaxPlusBold.home),
              selectedIcon: Icon(
                IconsaxPlusBold.home,
                color: Primary.blue500,
              ),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(IconsaxPlusBold.category),
              selectedIcon: Icon(
                IconsaxPlusBold.category,
                color: Primary.blue500,
              ),
              label: "Journal",
            ),
            NavigationDestination(
              icon: Icon(IconsaxPlusBold.profile),
              selectedIcon: Icon(
                IconsaxPlusBold.profile,
                color: Primary.blue500,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [HomepageScreen(), JurnalScreen(), ProfilePageScreen()];
}
