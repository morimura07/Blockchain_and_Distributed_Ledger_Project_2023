import 'package:dart_web3/dart_web3.dart';
import 'package:gym_app/view_model_smart_contracts/smart_contract_link.dart';

import 'dart:developer' as devtools;

class SmartContractNFT extends SmartContractLink {
  // List of the classic functions that we need as NFT
  late ContractFunction _getName;
  late ContractFunction _balanceOf;
  late ContractFunction _safeMint;
  late ContractFunction _getOwner;

  SmartContractNFT(contractName) : super(contractName);

  @override
  void extractFunctions() {
    // Extracting the functions, declared in contract.
    // _fullName = _contract.function("FullName");
    _getName = super.contract.function("name");
    _balanceOf = super.contract.function("balanceOf");
    _safeMint = super.contract.function("safeMint");
    _getOwner = super.contract.function("owner");
  }

  // ______________GETTERS______________

  Future<String> get owner async {
    var res = await super.client.call(
      contract: super.contract,
      function: _getOwner,
      params: [],
    );
    return res[0].toString();
  }

  Future<String> getBalanceOf(EthereumAddress address) async {
    devtools.log(
      "Getting balance of the smart contract",
      name: runtimeType.toString(),
    );

    // Getting the current balance declared in the smart contract.
    var currentBalance = await super.client.call(
      contract: super.contract,
      function: _balanceOf,
      params: [address],
    );

    devtools.log(
      "Result of the getBlanceOF method ${currentBalance[0]}",
      name: runtimeType.toString(),
    );

    isLoading = false;
    notifyListeners();
    return currentBalance[0].toString();
  }

  // ______________SETTERS______________

  @override
  Future<void> setDeployedName() async {
    devtools.log(
      "Getting name of the deployed smart contract",
      name: runtimeType.toString(),
    );
    var currentName = await super.client.call(
      contract: super.contract,
      function: _getName,
      params: [],
    );

    super.deployedName = currentName[0];
    isLoading = false;
    notifyListeners();
  }

  Future<String?> safeMint(EthereumAddress to) async {
    devtools.log(
      "Minting $deployedName",
      name: runtimeType.toString(),
    );

    // Create a transaction to call the safeMint function,
    // because to do something that changes the blockchain
    // we need to use a transaction
    final transaction = Transaction.callContract(
      contract: super.contract,
      function: _safeMint,
      maxGas: 200000, // Adjust the gas limit accordingly
      // gasPrice: EtherAmount.inWei(BigInt.from(1000000000)), // Adjust the gas price accordingly
      parameters: [to],
    );
    try {
      // Send the transaction
      final res = await super.client.sendTransaction(
            super.credentials,
            transaction,
            chainId: 1337,
            fetchChainIdFromNetworkId: false,
          );

      devtools.log(
        "Called transaction to safeMint.\nThe result is $res.",
        name: runtimeType.toString(),
      );

      return "Balance updated";
    } catch (e) {
      devtools.log(
        "An exception occurred: ${e.toString()}",
        name: runtimeType.toString(),
      );
      notifyListeners();
      return "Exception occurred";
    }
  }
}
