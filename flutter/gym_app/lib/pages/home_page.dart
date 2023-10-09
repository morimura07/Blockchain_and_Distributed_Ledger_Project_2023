import 'package:flutter/material.dart';
import 'package:gym_app/pages/admin_page.dart';
import 'package:gym_app/pages/boss_page.dart';
import 'package:gym_app/pages/credentials_page.dart';

import 'dart:developer' as devtools;

import 'package:gym_app/pages/customer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = "Get Credentials";

  int currentIndex = 0;

  List<Widget> pages = [
    const CredentialsPage(),
    const BossPage(),
    const AdminPage(),
    const CustomerPage(),
  ];

  void setPage({required String title, required int newIndex}) {
    setState(() {
      currentIndex = newIndex;
      this.title = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Text(
                "The gym of the future",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            ListTile(
              title: const Text("Get credentials"),
              onTap: () {
                devtools.log(
                  "Go to get credentials",
                  name: runtimeType.toString(),
                );
                setPage(title: "Credentials", newIndex: 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("BossNFT contract"),
              onTap: () {
                setPage(title: "BossNFT", newIndex: 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("AdminNFT contract"),
              onTap: () {
                setPage(newIndex: 2, title: "AdminNFT");
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("CustomerNFT contract"),
              onTap: () {
                setPage(newIndex: 3, title: "CustomerNFT");
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: pages[currentIndex],
    );
  }
}
