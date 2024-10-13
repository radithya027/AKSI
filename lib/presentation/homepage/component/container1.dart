import 'package:aksi/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final IconData icon;
  const CustomContainer({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
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
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Primary.blue100),
                  child: Center(
                    child: Icon(
                      icon,
                      color: Primary.blue400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 27),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Check in",
                      style: AppTextStyle.tsSmallBold(Primary.black),
                    ),
                    Text(
                      "April 17 2924",
                      style: AppTextStyle.tsSmallRegular(Primary.black),
                    )
                  ],
                ),
              ),
              SizedBox(width: 70),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 27),
                child: Column(
                  children: [
                    Text(
                      "08.00",
                      style: AppTextStyle.tsSmallBold(Primary.black),
                    ),
                    Text(
                      "On Time",
                      style: AppTextStyle.tsSmallRegular(Primary.black),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
