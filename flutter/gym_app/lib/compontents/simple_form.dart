import 'package:flutter/material.dart';

import 'dart:developer' as devtools;

/// It's just a [TextField] with a button to submit.
class SimpleForm extends StatefulWidget {

  SimpleForm({Key? key, required this.onSubmit, required this.label, this.hint = 'Enter an Etherium address in Hex'}) : super(key: key);
 
  final Function onSubmit;
  final String label;
  String hint;

  @override
  State<SimpleForm> createState() => _SimpleFormState();
}

class _SimpleFormState extends State<SimpleForm> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          maxLines: null,
          controller: myController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: widget.hint,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => widget.onSubmit(myController.text),
          icon: const Icon(Icons.menu_book_outlined),
          label: Text(widget.label),
        )
      ],
    );
  }
}
