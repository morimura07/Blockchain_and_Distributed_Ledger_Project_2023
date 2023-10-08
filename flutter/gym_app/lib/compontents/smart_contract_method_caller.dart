import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/view_model_smart_contracts/smart_contract_nft.dart';

import 'dart:developer' as devtools;

class SmartContractMethodCaller extends StatefulWidget {
  const SmartContractMethodCaller({Key? key, required this.contractNFT}) : super(key: key);

  final SmartContractNFT contractNFT;

  @override
  State<SmartContractMethodCaller> createState() =>
      _SmartContractMethodCallerState();
}

class _SmartContractMethodCallerState extends State<SmartContractMethodCaller> {
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
    

    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 0.9,
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
        ElevatedButton.icon(
          onPressed: () async {
            String res;
            try {
              res = await widget.contractNFT.getBalanceOf(
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
        balanceOf.isEmpty
            ? const Text("")
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("The Balance of this address is: $balanceOf"),
              ),
        ElevatedButton.icon(
          onPressed: () {
            devtools.log("Button 'safeMint' pressed");
            widget.contractNFT.safeMint(EthereumAddress.fromHex(ethAddress));
          },
          icon: const Icon(Icons.attach_money_rounded),
          label: Text("Mint a ${widget.contractNFT.deployedName} token"),
        )
      ],
    );
  }
}
