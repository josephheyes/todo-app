import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'event.dart';

class NewEvent extends StatefulWidget {
  const NewEvent({super.key});

  @override
  NewEventState createState() {
    return NewEventState();
  }
}

class NewEventState extends State<NewEvent> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  var categories = [
    "Chore",
    "Work",
    "Assignment",
    "Health",
    "Exercise",
    "Social"
  ];
  String? _category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Create New Event")),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: textController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      border: UnderlineInputBorder(),
                      labelText: "Event name",
                      labelStyle: TextStyle(color: Colors.black)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  items: categories.map((String category) {
                    // ignore: unnecessary_new
                    return new DropdownMenuItem(
                        value: category,
                        child: Row(
                          children: [
                            const Icon(Icons.star),
                            Text(category),
                          ],
                        ));
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() => _category = newValue);
                  },
                  value: _category,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      border: UnderlineInputBorder(),
                      labelText: "Event type",
                      labelStyle: TextStyle(color: Colors.black)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Event event =
                            Event(name: textController.text, type: _category!);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  content: Column(
                                children: [
                                  Text(event.name),
                                  Text(event.type),
                                ],
                              ));
                            });
                      }
                    },
                    child: const Text("Submit")),
              ],
            )));
  }
}
