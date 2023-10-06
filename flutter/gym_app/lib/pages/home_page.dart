import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/view_model_smart_contracts/boss_NFT_contract_vm.dart';
import 'package:provider/provider.dart';

import 'dart:developer' as devtools;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  String ethAddress = "Missing address";
  String balanceOf = "";

  void _updateEthAddress(String newString) {
    setState(() {
      ethAddress = newString.isEmpty ? "Missing address" : newString;
    });
  }

  void _updateBalanceOf(String newString) {
    setState(() {
      balanceOf = newString;
    });
  }

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<BossNFTcontractVM>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: contractLink.isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Here the name of the deployed contract',
                  ),
                  Text(
                    '${contractLink.deployedName}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 30),
                  FractionallySizedBox(
                    widthFactor: 0.7,
                    child: TextField(
                      maxLines: null,
                      controller: myController,
                      onChanged: (inputString) => _updateEthAddress(inputString),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter an Etherium address in Hex',
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () async {
                      String res;
                      try {
                        res = await contractLink.getBalanceOf(
                          EthereumAddress.fromHex(ethAddress),
                        );
                      } catch (e) {
                        devtools.log(
                          "An exception occureed\n${e.toString()}",
                          name: runtimeType.toString(),
                        );
                        res = "";  
                      }
                      _updateBalanceOf(res);
                    },
                    icon: const Icon(Icons.account_balance_sharp),
                    label: const Text("Balance of BossNFT"),
                  ),
                  const SizedBox(height: 30),
                  balanceOf.isEmpty
                      ? const Text("")
                      : Text("The Balance of this address is: $balanceOf"),
                ],
              ),
      ),
    );
  }
}
