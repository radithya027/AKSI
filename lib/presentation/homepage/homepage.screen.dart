import 'package:aksi/infrastructure/navigation/routes.dart';
import 'package:aksi/infrastructure/theme/theme.dart';

import 'package:aksi/presentation/homepage/component/card.dart';
import 'package:aksi/presentation/homepage/component/card2.dart';
import 'package:aksi/presentation/homepage/component/container1.dart';
import 'package:aksi/presentation/homepage/component/container2.dart';
import 'package:aksi/presentation/izin/izin.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'component/default_appbar.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'controllers/homepage.controller.dart';

class HomepageScreen extends GetView<HomepageController> {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dapatkan tanggal saat ini
    DateTime now = DateTime.now();
    int totalDays = daysInMonth(now);

    return Scaffold(
      backgroundColor: Primary.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: DefaultAppbar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: totalDays,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Card1(dayNumber: index + 1),
                    );
                  },
                ),
              ),
            ),
            spaceHeightLarge,
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Primary.bg,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today Attendance",
                      style: AppTextStyle.tsBodyBold(Primary.black),
                    ),
                    spaceHeightNormal,
                    Row(
                      children: [
                        Card2(
                          judul: 'Masuk',
                          jam: '08.00',
                          desc: 'On Time',
                          icon: IconsaxPlusBold.login,
                        ),
                        SizedBox(width: 10),
                        Card2(
                          judul: 'Pulang',
                          jam: '17.00',
                          desc: 'Go Home',
                          icon: IconsaxPlusBold.logout_1,
                        ),
                      ],
                    ),
                    spaceHeightExtraSmall,
                    Row(
                      children: [
                        Card2(
                          judul: 'Istirahat',
                          desc: 'Waktu Istirahat',
                          jam: '12.00 - 01.00',
                          icon: IconsaxPlusBold.calendar,
                        ),
                        SizedBox(width: 10),
                        Card2(
                          judul: 'Hari Kerja',
                          desc: 'Working Days',
                          jam: '28',
                          icon: IconsaxPlusBold.calendar,
                        ),
                      ],
                    ),
                    spaceHeightLarge,
                    Text(
                      "Per Izinan",
                      style: AppTextStyle.tsBodyBold(Primary.black),
                    ),
                    spaceHeightNormal,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container2(
                          onTap: () {
                            Get.toNamed(Routes.IZIN_SAKIT);
                          },
                          warna: Primary.blue900,
                          judul: 'Izin',
                          gambar:
                              'lib/infrastructure/assets/icons8-man-raising-hand-skin-type-3-48.png',
                          height: 0.1, // 20% of the screen height
                          imageHeight: 40, // Image height 60
                        ),
                        SizedBox(width: 5),
                        Container2(
                          onTap: () {
                            Get.toNamed(Routes.IZIN);
                          },
                          warna: Primary.blue800,
                          judul: 'Sakit',
                          gambar:
                              'lib/infrastructure/assets/icons8-fever-100.png',
                          height: 0.1, // 20% of the screen height
                          imageHeight: 40, // Image height 60
                        ),
                      ],
                    ),
                    spaceHeightExtraSmall,
                    Row(
                      children: [
                        Container2(
                          onTap: () {
                            Get.toNamed(Routes.JURNAL);
                          },
                          warna: Primary.blue800,
                          judul: 'Isi Jurnal',
                          gambar:
                              'lib/infrastructure/assets/icons8-journal-100-2.png',
                          height: 0.1, // 20% of the screen height
                          imageHeight: 40, // Image height 60
                        ),
                        SizedBox(width: 5),
                        Container2(
                          warna: Primary.blue900,
                          judul: '',
                          gambar:
                              'lib/infrastructure/assets/icons8-journal-100-2.png',
                          height: 0.1, // 20% of the screen height
                          imageHeight: 40, // Image height 60
                        ),
                      ],
                    ),
                    spaceHeightLarge,
                    Text(
                      "Your Activity",
                      style: AppTextStyle.tsBodyBold(Primary.black),
                    ),
                    spaceHeightLarge,
                    Container(
                      height: 500,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: CustomContainer(
                              icon: Icons.login,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int daysInMonth(DateTime date) {
    var nextMonth = (date.month < 12)
        ? DateTime(date.year, date.month + 1, 1)
        : DateTime(date.year + 1, 1, 1);
    return nextMonth.subtract(Duration(days: 1)).day;
  }
}
