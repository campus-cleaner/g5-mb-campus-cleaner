import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/screens/login.dart';
import 'package:g5_mb_campus_cleaner/utils/text_util.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;

  const CustomAppBarWidget(
      {super.key,
      required this.title,
      required this.automaticallyImplyLeading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: TextUtil.buildBoldText(title, color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 31, 172, 90),
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: automaticallyImplyLeading,
        actions: [
          PopupMenuButton<String>(
            icon: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/user.jpg"),
            ),
            onSelected: (value) {
              if (value == 'logout') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      const Icon(Icons.logout, color: Colors.black),
                      const SizedBox(width: 10),
                      TextUtil.buildBoldText("Cerrar sesión")
                    ],
                  ),
                ),
              ];
            },
          ),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
