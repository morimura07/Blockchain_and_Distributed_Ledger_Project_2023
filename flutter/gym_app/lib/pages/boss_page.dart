import 'package:flutter/material.dart';
import 'package:gym_app/compontents/smart_contract_method_caller.dart';
import 'package:gym_app/compontents/form_edit_eth_address.dart';
import 'package:gym_app/compontents/mirror_nft.dart';
import 'package:gym_app/view_model_smart_contracts/boss_nft_contract_vm.dart';
import 'package:provider/provider.dart';

// import 'dart:developer' as devtools;

class BossPage extends StatefulWidget {
  const BossPage({Key? key}) : super(key: key);

  @override
  State<BossPage> createState() => _BossPageState();
}

class _BossPageState extends State<BossPage> {
  

  @override
  Widget build(BuildContext context) {
    // devtools.log("Refresh widget", name: runtimeType.toString());
    var contractLink = Provider.of<BossNFTcontractVM>(context);

    return Center(
      child: contractLink.isLoading
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(19.0),
              child: ListView(
                children: [
                  FormEditEthAddress(
                    setAddress: (newPrimaryKey) {
                      contractLink.primaryKey = newPrimaryKey;
                    },
                  ),
                  const MirrorNFT(),
                  const SmartContractMethodCaller(),
                ],
              ),
            ),
    );
  }


}
