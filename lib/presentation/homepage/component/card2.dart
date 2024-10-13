import 'package:aksi/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';

class Card2 extends StatelessWidget {
  final String judul;
  final String jam;
  final String desc;
  final IconData icon; 

  const Card2({
    super.key,
    required this.judul,
    required this.jam,
    required this.desc,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      width: 155,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Primary.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Primary.blue100,
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: Primary.blue400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  judul, 
                  style: AppTextStyle.tsBodyRegular(Primary.black),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Text(
              jam,
              style: AppTextStyle.tsBodyBold(Primary.black),
            ),
          ),
          spaceHeightExtraSmall,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Text(
              desc, 
              style: AppTextStyle.tsBodyRegular(Primary.black),
            ),
          )
        ],
      ),
    );
  }
}
