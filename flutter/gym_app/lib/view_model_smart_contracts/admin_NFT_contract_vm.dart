import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:dart_web3/dart_web3.dart';
import 'package:web_socket_channel/io.dart';

import 'dart:developer' as devtools;

/// It represent the ViewModel of a contract, in particular, BossNFT contract. \
/// It's implemented as a ChangeNotifier, it means we can use it as a **state** for
/// our application.
class AdminNFTcontractVM extends ChangeNotifier {
  final String nameSmartContract = "AdminNFT";

  final String _rpcURl = "http://127.0.0.1:7545";
  final String _wsURl = "ws://127.0.0.1:7545/";

  // Private key for the address that is doing the transaction (to sign the transaction)
  final String _privateKey =
      "0x57f5a7d63580a45fc965b5524d5b3ea48be91bd7abb315dd62b2fc944fb93607";

  //it's used to establish a connection to the Ethereum RPC node with the help of WebSocket
  late Web3Client _client;
  //it's used to read the contract ABI
  late String _abiCode;
  //it's the contract address of the deployed smart contract
  late EthereumAddress _contractAddress;
  //it's the credentials of the smart contract deployer
  late Credentials _credentials;
  //it's used to tell Web3dart where the contract is declared
  late DeployedContract _contract;

  //it's the function that is declared in our SmartContract
  late ContractFunction _getName;
  late ContractFunction _balanceOf;
  late ContractFunction _safeMint;
  late ContractFunction _getOwner;

  //it's used to check the contract state
  bool isLoading = true;

  //it's the name from the smart contract
  String? deployedName;

  Future<String?> get address async {
    var ethAddress = await _credentials.extractAddress();
    return ethAddress.hex;
  }

  AdminNFTcontractVM() {
    initialize();
  }

  /// Establish a connection to the Ethereum RPC node. The socketConnector
  /// property allows more efficient event streams over websocket instead of
  /// http-polls. However, the socketConnector property is experimental.
  initialize() async {
    devtools.log(
      "Establishing a connection to the Ethereum RPC node",
      name: runtimeType.toString(),
    );

    _client = Web3Client(_rpcURl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsURl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();

    devtools.log(
      "End of the inizialization",
      name: runtimeType.toString(),
    );
  }

  Future<void> getAbi() async {
    // Reading the contract abi
    String abiStringFile =
        await rootBundle.loadString("assets/artifacts/contracts/AdminNFT.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    // Telling Web3dart where our contract is declared.
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "AdminNFT"), _contractAddress);

    // Extracting the functions, declared in contract.
    // _fullName = _contract.function("FullName");
    _getName = _contract.function("name");

    _balanceOf = _contract.function("balanceOf");
    _safeMint = _contract.function("safeMint");
    _getOwner = _contract.function("owner");

    getName();
  }

  // ______________ Functions get ______________

  Future<void> getName() async {
    devtools.log(
      "Getting name of the deployed smart contract",
      name: runtimeType.toString(),
    );
    var currentName = await _client.call(
      contract: _contract,
      function: _getName,
      params: [],
    );

    deployedName = currentName[0];
    isLoading = false;
    notifyListeners();
  }

  Future<String> getBalanceOf(EthereumAddress address) async {
    devtools.log(
      "Getting balance of the smart contract",
      name: runtimeType.toString(),
    );

    // Getting the current balance declared in the smart contract.
    var currentBalance = await _client.call(
      contract: _contract,
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

  Future<String> get owner async {
    var res = await _client.call(
      contract: _contract,
      function: _getOwner,
      params: [],
    );
    // notifyListeners();
    return res[0].toString();
  }

  // ______________ Functions set or mint ______________

  Future<String?> safeMint(EthereumAddress to) async {
    devtools.log(
      "Minting $deployedName",
      name: runtimeType.toString(),
    );

    // if (await owner != await address) {
    //   devtools.log(message)
    //   return;
    // }

    // Create a transaction to call the safeMint function,
    // because to do something that changes the blockchain
    // we need to use a transaction
    final transaction = Transaction.callContract(
      contract: _contract,
      function: _safeMint,
      maxGas: 200000, // Adjust the gas limit accordingly
      // gasPrice: EtherAmount.inWei(BigInt.from(1000000000)), // Adjust the gas price accordingly
      parameters: [to],
    );
    try {
      // Send the transaction
      final res = await _client.sendTransaction(
        _credentials,
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
