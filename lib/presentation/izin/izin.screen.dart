import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../jurnal/component/popup_dialog.dart';
import 'controllers/izin.controller.dart';
import '../../infrastructure/theme/theme.dart';
import '../login_page/component/custom_TextFormField.dart';

class IzinScreen extends GetView<IzinController> {
  const IzinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd MMMM yyyy', 'id').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: Primary.blue500,
        ),
        title: Text(
          'Buat Izin Sakit',
          style: AppTextStyle.tsTitleBold(Primary.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section for title and date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Buat Izin Sakit",
                    style: AppTextStyle.tsBodyBold(Primary.black),
                  ),
                  Text(
                    formattedDate,
                    style: AppTextStyle.tsBodyRegular(Primary.black),
                  ),
                ],
              ),
              spaceHeightNormal,

              Text(
                "Sakit",
                style: AppTextStyle.tsBodyBold(Primary.black),
              ),
              spaceHeightSmall,
              CustomTextFormField(
                labelText: 'Masukkan Judul Sakit',
                controller: controller.titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong isi judul sakit';
                  }
                  return null;
                },
              ),

              spaceHeightNormal,
              Text(
                "Gejala Penyakit",
                style: AppTextStyle.tsBodyBold(Primary.black),
              ),
              spaceHeightSmall,
              CustomTextFormField(
                labelText: "Gejala yang dialami?",
                controller: controller.symptomsController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong isi gejala penyakit';
                  }
                  return null;
                },
              ),
              spaceHeightNormal,

              // Image picker section
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.file_upload_rounded),
                    color: Primary.blue600,
                    onPressed: () => controller.pickImage(),
                  ),
                  Text(
                    'Upload Foto Bukti (Opsional)',
                    style: AppTextStyle.tsBodyBold(Primary.black),
                  ),
                ],
              ),
              spaceHeightSmall,

              // Display selected images
              Obx(() {
                return controller.selectedImage.value == null
                    ? Text(
                        'Belum ada foto yang diunggah',
                        style: AppTextStyle.tsBodyRegular(Primary.black),
                      )
                    : Stack(
                        children: [
                          GestureDetector(
                            onTap: () => showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierLabel: MaterialLocalizations.of(context)
                                  .modalBarrierDismissLabel,
                              barrierColor: Primary.black,
                              pageBuilder: (BuildContext context,
                                  Animation first, Animation second) {
                                return Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.close,
                                            color: Colors.white),
                                        onPressed: () => Get.back(),
                                      ),
                                      SizedBox(height: 16.0),
                                      InteractiveViewer(
                                        child: Image.file(File(controller
                                            .selectedImage.value!.path)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(controller.selectedImage.value!.path),
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 4,
                            top: 4,
                            child: GestureDetector(
                              onTap: () {
                                showCustomPopupDialog(
                                  'Hapus?',
                                  'Yakin untuk menghapus foto ini?',
                                  [
                                    TextButton(
                                      onPressed: () {
                                        controller.removeImage();
                                        Get.back();
                                      },
                                      child: Text(
                                        'Yes',
                                        style: AppTextStyle.tsBodyBold(
                                            Primary.black),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text(
                                        'No',
                                        style: AppTextStyle.tsBodyBold(
                                            Primary.black),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
              }),
              spaceHeightNormal,

              // Submit button
              SizedBox(
                height: 70,
                width: double.infinity,
                child: Obx(() {
                  return ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            await controller.postSakitData();
                            Get.back();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Primary.blue800,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Primary.blue800),
                          )
                        : Text(
                            'Kirim Laporan Sakit',
                            style: AppTextStyle.tsBodyBold(Primary.white),
                          ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
