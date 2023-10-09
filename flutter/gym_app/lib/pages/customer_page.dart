import 'package:flutter/material.dart';
import 'package:gym_app/compontents/form_edit_eth_address.dart';
import 'package:gym_app/compontents/mirror_nft.dart';
import 'package:gym_app/compontents/smart_contract_method_caller.dart';
import 'package:gym_app/view_model_smart_contracts/customer_nft_contract_vm.dart';
import 'package:provider/provider.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<CustomerNFTcontractVM>(context);

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
                  MirrorNFT(contractNFT: contractLink),
                  SmartContractMethodCaller(contractNFT: contractLink),
                ],
              ),
            ),
    );
  }
}
