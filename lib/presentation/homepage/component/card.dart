import 'package:aksi/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Package to format dates

class Card1 extends StatelessWidget {
  // Tambahkan parameter untuk menerima tanggal yang akan ditampilkan
  final int dayNumber;
  const Card1({super.key, required this.dayNumber});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan tanggal dan hari sekarang
    DateTime now = DateTime.now();
    String currentDay = DateFormat('EEE').format(DateTime(now.year, now.month,
        dayNumber)); // Ambil 3 huruf pertama dari hari berdasarkan dayNumber
    bool isToday = now.day ==
        dayNumber; // Cek apakah tanggal sekarang sama dengan dayNumber
    bool isPast =
        now.day > dayNumber; // Cek apakah tanggal yang diberikan sudah lewat

    return Container(
      height: 50,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isToday
            ? Colors.blue
            : Primary
                .white, // Jika hari ini, warnanya biru, jika sudah lewat tetap putih
        border: Border.all(
            color: isPast
                ? Primary.grey
                : Colors.blue), // Border biru jika belum lewat
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Column(
              children: [
                Center(
                  child: Text(
                    dayNumber.toString(), // Tampilkan tanggal sesuai dayNumber
                    style: AppTextStyle.tsSmallBold(
                      isToday
                          ? Primary.white
                          : Primary.black, // Warna teks putih jika hari ini
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    currentDay, // Tampilkan nama hari (3 huruf pertama)
                    style: AppTextStyle.tsSmallBold(
                      isToday
                          ? Primary.white
                          : Primary.black, // Warna teks putih jika hari ini
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
