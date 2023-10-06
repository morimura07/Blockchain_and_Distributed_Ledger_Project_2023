import 'package:flutter/material.dart';
import 'package:gym_app/pages/home_page.dart';
import 'package:gym_app/view_model_smart_contracts/boss_NFT_contract_vm.dart';
import 'package:provider/provider.dart';

import 'dart:developer' as devtools;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider<BossNFTcontractVM>(
      create: (_) {
        devtools.log("Creating the LinkSmartContract Provider", name: "Main");
        return BossNFTcontractVM();
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym on blockchain',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(title: 'Admin Interface'),
    );
  }
}
