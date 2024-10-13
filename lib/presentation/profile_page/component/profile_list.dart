import 'package:aksi/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';

class ProfileList extends StatelessWidget {
  final String title;
  final String? description;

  const ProfileList({
    super.key,
    required this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 8),
      width: 330,
      decoration: BoxDecoration(
        color: Primary.white,
        boxShadow: [
          BoxShadow(
            color: Primary.black.withOpacity(0.1),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
        borderRadius: defaultBorderRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Text
          Flexible(
            child: Text(
              title,
              style: AppTextStyle.tsSmallRegular(Primary.black),
            ),
          ),
          SizedBox(height: 4), // Added spacing between title and description
          // Description Text
          Flexible(
            child: Text(
              description ?? '-',
              style: AppTextStyle.tsBodyBold(Primary.black),
              maxLines: null,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
