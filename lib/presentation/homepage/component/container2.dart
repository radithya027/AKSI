import 'package:aksi/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class Container2 extends StatelessWidget {
  final Color warna;
  final String judul;
  final String gambar; // Image as a String (asset path)
  final double height; // Adding height as a parameter
  final double imageHeight; // Adding image height as a parameter
  final VoidCallback? onTap; // onTap as a parameter

  const Container2({
    super.key,
    required this.warna,
    required this.judul,
    required this.gambar,
    this.height = 0.1, // Default value for container height (fraction of screen)
    this.imageHeight = 40, // Default value for image height
    this.onTap, // onTap can be null, so it's optional
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Using the onTap callback
      child: Container(
        height: heightScreen * height, // Dynamically setting container height
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: warna,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceHeightSmall,
            Center(
              child: Image.asset(
                gambar,
                height: imageHeight, 
              ),
            ),
            Center(
              child: Text(
                judul,
                style: AppTextStyle.tsSmallBold(Primary.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
