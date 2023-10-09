import 'dart:convert';

import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:developer' as devtools;

import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';

/// This is the class that set the connection with the blockchain
/// and allows it to be used as a [ChangeNotifier], and therefore as a [Provider].
abstract class SmartContractLink extends ChangeNotifier {
  final String _rpcURl = "http://127.0.0.1:7545";
  final String _wsURl = "ws://127.0.0.1:7545/";

  // Private key for the address that is doing the transaction (to sign the transaction)
  String _privateKey =
      "0xd7d4f5fad5d583ea959a7cf76919ea47b9827e45acfa764a22a019e5c0efbb4b";

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

  get contract => _contract;
  get client => _client;
  Credentials get credentials => _credentials;

  //it's used to check the contract state
  bool isLoading = true;

  //it's the name from the smart contract
  String? deployedName;

  Future<String?> get address async {
    var ethAddress = await _credentials.extractAddress();
    return ethAddress.hex;
  }

  set primaryKey(String newPk) {
    devtools.log(
      "Setting credentials with proper setter",
      name: runtimeType.toString(),
    );
    _privateKey = newPk;
    _setCredentials();
  }

  Future<void> _setCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
    notifyListeners();
  }

  SmartContractLink(String contractName) {
    initialize(contractName);
  }

  /// Establish a connection to the Ethereum RPC node. The socketConnector
  /// property allows more efficient event streams over websocket instead of
  /// http-polls. However, the socketConnector property is experimental.
  initialize(String contractName) async {
    devtools.log(
      "Establishing a connection to the Ethereum RPC node",
      name: runtimeType.toString(),
    );

    _client = Web3Client(_rpcURl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsURl).cast<String>();
    });

    await getAbi(contractName);
    await _setCredentials();
    getDeployedContract(contractName);
    extractFunctions();
    await setDeployedName();

    isLoading = false;

    devtools.log(
      "End of the inizialization SmartContractLink",
      name: runtimeType.toString(),
    );
    notifyListeners();
  }

  Future<void> getAbi(String contractName) async {
    // Reading the contract abi
    String abiStringFile = await rootBundle
        .loadString("assets/artifacts/contracts/$contractName.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  void getDeployedContract(String contractName) {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, contractName), _contractAddress);
  }

  // ___________ UNIMPLEMENTED METHODS ___________

  /// This function needs to be called in order to force the declaration of all the functions
  /// in the contract.
  ///
  /// Example
  /// -------
  /// ```
  /// _getName = _contract.function("name");
  /// _balanceOf = _contract.function("balanceOf");
  /// _safeMint = _contract.function("safeMint");
  /// _getOwner = _contract.function("owner");
  /// ```
  void extractFunctions();
  Future<void> setDeployedName();
}
