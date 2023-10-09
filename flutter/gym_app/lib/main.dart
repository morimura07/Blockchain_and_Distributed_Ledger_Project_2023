import 'package:flutter/material.dart';
import 'package:gym_app/pages/home_page.dart';
import 'package:gym_app/view_model_smart_contracts/admin_nft_contract_vm.dart';
import 'package:gym_app/view_model_smart_contracts/boss_nft_contract_vm.dart';
import 'package:gym_app/view_model_smart_contracts/customer_nft_contract_vm.dart';
import 'package:provider/provider.dart';

import 'dart:developer' as devtools;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<BossNFTcontractVM>(
          create: (_) {
            devtools.log("Creating the BossNFT Provider", name: "Main");
            return BossNFTcontractVM();
          },
        ),
        ChangeNotifierProvider<AdminNFTcontractVM>(
          create: (_) {
            devtools.log(
              "Creatin the AdminNFT Provider",
              name: "Main",
            );
            return AdminNFTcontractVM();
          },
        ),
        ChangeNotifierProvider<CustomerNFTcontractVM>(
          create: (_) {
            devtools.log(
              "Creatin the CustomerNFT Provider",
              name: "Main",
            );
            return CustomerNFTcontractVM();
          },
        ),
      ],
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
      debugShowCheckedModeBanner: false, // ! debug banner
      title: 'Gym on blockchain',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}
