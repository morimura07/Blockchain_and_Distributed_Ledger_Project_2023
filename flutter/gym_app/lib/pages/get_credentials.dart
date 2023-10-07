import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/material.dart';

import 'package:gym_app/compontents/simple_form.dart';

import 'package:gym_app/model/credential_builder.dart';

class GetCredentials extends StatefulWidget {
  const GetCredentials({Key? key}) : super(key: key);

  @override
  State<GetCredentials> createState() => _GetCredentialsState();
}

class _GetCredentialsState extends State<GetCredentials> {
  Credentials? _credentials;

  void onSubmit(String strPrivateKey) {
    var cb = CredentialBuilder(strPrivateKey);
    setState(() {
      _credentials = cb.credentials;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var contractLink = Provider.of<BossNFTcontractVM>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SimpleForm(
            onSubmit: onSubmit,
            label: "Retrieve credentials from PK",
            hint: 'Enter an Etherium address in Hex',
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: FutureBuilder(
              future: _credentials?.extractAddress(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == null) {
                    return const Text("Address not retrieved");
                  }
                  return Text(snapshot.data!.hex);
                }
                return const CircularProgressIndicator();
              },
            ),
          )
        ],
      ),
    );
  }
}
