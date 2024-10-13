import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  EnvironmentsBadge({required this.child});
  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOMEPAGE,
      page: () => const HomepageScreen(),
      binding: HomepageControllerBinding(),
    ),
    GetPage(
      name: Routes.LOGIN_PAGE,
      page: () => const LoginPageScreen(),
      binding: LoginPageControllerBinding(),
    ),
    GetPage(name: Routes.NAVBAR, page: () => NavbarScreen(), bindings: [
      HomepageControllerBinding(),
      JurnalControllerBinding(),
      ProfilePageControllerBinding(),
    ]),
    GetPage(
      name: Routes.PROFILE_PAGE,
      page: () => const ProfilePageScreen(),
      binding: ProfilePageControllerBinding(),
    ),
    GetPage(
      name: Routes.JURNAL,
      page: () => const JurnalScreen(),
      binding: JurnalControllerBinding(),
    ),
    GetPage(
      name: Routes.IZIN,
      page: () => const IzinScreen(),
      binding: IzinControllerBinding(),
    ),
    GetPage(
      name: Routes.IZIN_SAKIT,
      page: () => const IzinSakitScreen(),
      binding: IzinSakitControllerBinding(),
    ),
    GetPage(
      name: Routes.MASUK,
      page: () => const MasukScreen(),
      binding: MasukControllerBinding(),
    ),
  ];
}
