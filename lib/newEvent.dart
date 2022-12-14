import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewEvent extends StatefulWidget {
  const NewEvent({super.key});

  @override
  NewEventState createState() {
    return NewEventState();
  }
}

class NewEventState extends State<NewEvent> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            )
          ],
        ));
  }
}
