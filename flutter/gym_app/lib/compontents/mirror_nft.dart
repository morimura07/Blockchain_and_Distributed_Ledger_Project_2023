import 'package:flutter/material.dart';
import 'package:gym_app/view_model_smart_contracts/smart_contract_nft.dart';

class MirrorNFT extends StatelessWidget {
  const MirrorNFT({super.key, required this.contractNFT});
  final SmartContractNFT contractNFT;

  @override
  Widget build(BuildContext context) {
    // var contractNFT = Provider.of<BossNFTcontractVM>(context);

    return Column(
      children: [
        const Text(
          'Here the name of the contract we are trying to execute the methods',
          textAlign: TextAlign.center,
        ),
        Text(
          '${contractNFT.deployedName}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Text("and the address we are connected as:"),
        FutureBuilder(
          future: contractNFT.address,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text(
                '${snapshot.data}',
                style: Theme.of(context).textTheme.bodyLarge,
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        const Text("and the address owner of the contract is:"),
        FutureBuilder(
          future: contractNFT.owner,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text(
                '${snapshot.data}',
                style: Theme.of(context).textTheme.bodyLarge,
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
