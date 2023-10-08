import 'package:flutter/material.dart';
import 'package:gym_app/compontents/simple_form.dart';

class FormEditEthAddress extends StatelessWidget {
  const FormEditEthAddress({super.key, required this.setAddress});

  final Function(String newPrimaryKey) setAddress;

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.amber[100],
        ),
        constraints: const BoxConstraints(minHeight: 300),
        child: Column(
          children: [
            Text("Set here your credentials",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center),
            SimpleForm(
              onSubmit: (prova) => setAddress(prova),
                
                label: "Set address",
                hint: "Private key of an Etherium address"),
          ],
        ),
      ),
    );
  }
}
