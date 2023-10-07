import 'package:dart_web3/dart_web3.dart';

import 'dart:developer' as devtools;

class CredentialBuilder {
  CredentialBuilder(this._privateKey) {
    credentials = EthPrivateKey.fromHex(_privateKey);
  }

  final String _privateKey;
  late Credentials credentials;

  Future<String> get address async {
    devtools.log(
      "Extracting the address form the credentials",
      name: runtimeType.toString(),
    );
    var ethAddress = await credentials.extractAddress();
    return ethAddress.hex;
  }
}
