import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../infrastructure/theme/theme.dart';

class DefaultAppbar extends StatelessWidget {
  const DefaultAppbar({super.key});

  Future<Map<String, String>> _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? 'User'; // Default username
    String userImage = prefs.getString('userImage') ??
        ''; // Default to empty string if not found
    return {'username': username, 'userImage': userImage};
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Primary.background,
      title: FutureBuilder<Map<String, String>>(
        future: _getUserInfo(),
        builder: (context, snapshot) {
          String username = 'User'; // Default username
          String userImage = ''; // Default image

          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            username = snapshot.data!['username']!;
            userImage = snapshot.data!['userImage']!;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Primary.blue100,
                  radius: 24,
                  backgroundImage: userImage.isNotEmpty
                      ? NetworkImage(userImage)
                      : null, // Use network image if available
                  child: userImage.isEmpty
                      ? Icon(Icons.person,
                          color: Primary.grey) // Default icon if no image
                      : null,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: AppTextStyle.tsTitleBold(Primary.black),
                      ),
                      Text(
                        'Mimpi besar butuh usaha besar',
                        style: AppTextStyle.tsSmallRegular(Primary.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
