import 'dart:io';

import 'package:aksi/infrastructure/theme/theme.dart';
import 'package:aksi/presentation/jurnal/component/popup_dialog.dart';
import 'package:aksi/presentation/login_page/component/custom_TextFormField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controllers/jurnal.controller.dart';

class JurnalScreen extends GetView<JurnalController> {
  const JurnalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the current date in Indonesian locale
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
          'Buat Jurnal',
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
                    "Buat Laporan",
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
                "Judul",
                style: AppTextStyle.tsBodyBold(Primary.black),
              ),
              spaceHeightSmall,
              CustomTextFormField(
                labelText: 'Masukkan Judul',
                controller: controller.judulTextController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong Isi Judul';
                  }
                  return null;
                },
              ),

              spaceHeightNormal,
              Text(
                "Masukkan Kegiatan",
                style: AppTextStyle.tsBodyBold(Primary.black),
              ),
              spaceHeightSmall,
              CustomTextFormField(
                labelText:
                    "Apa saja kegiatan yang telah Anda selesaikan pada hari ini?",
                controller: controller.kegiatanTextController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong isi Kegiatan';
                  }
                  return null;
                },
                // maxLines: 3,
              ),
              spaceHeightNormal,
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.file_upload_rounded),
                    color: Primary.blue600,
                    onPressed: () => controller.pickImage(),
                  ),
                  Text(
                    'Upload Foto',
                    style: AppTextStyle.tsBodyBold(Primary.black),
                  ),
                ],
              ),
              spaceHeightSmall,

              // Display selected images
              Obx(() {
                return controller.selectedImages.isEmpty
                    ? Text(
                        'Belum ada foto yang diunggah',
                        style: AppTextStyle.tsBodyRegular(Primary.black),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 2 / 1.5,
                        ),
                        itemCount: controller.selectedImages.length,
                        itemBuilder: (context, index) {
                          final file = controller.selectedImages[index];
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () => showGeneralDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  barrierLabel:
                                      MaterialLocalizations.of(context)
                                          .modalBarrierDismissLabel,
                                  barrierColor: Primary.black,
                                  pageBuilder: (BuildContext context,
                                      Animation first, Animation second) {
                                    return Scaffold(
                                      backgroundColor: Colors.transparent,
                                      body: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.close,
                                                color: Colors.white),
                                            onPressed: () => Get.back(),
                                          ),
                                          SizedBox(height: 16.0),
                                          InteractiveViewer(
                                            child: Image.file(File(file.path)),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(file.path),
                                    width: double.infinity,
                                    height: double.infinity,
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
                                            controller.removeImage(file);
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
                        },
                      );
              }),
              spaceHeightNormal,
              SizedBox(
                height: 70,
                width: double.infinity,
                child: Obx(() {
                  return ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            await controller.postJurnalData();
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
                            'Kirim Jurnal',
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
