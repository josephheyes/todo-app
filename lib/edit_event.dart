import 'package:flutter/material.dart';
import 'event.dart';

class EditEvent extends StatefulWidget {
  final Event event;

  @override
  EditEventState createState() {
    return EditEventState();
  }

  const EditEvent({super.key, required this.event});
}

class EditEventState extends State<EditEvent> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  final List<Category> _categories = [
    Category("Chore", Icons.check),
    Category("Work", Icons.work),
    Category("Assignment", Icons.school),
    Category("Health", Icons.health_and_safety),
    Category("Exercise", Icons.fitness_center),
    Category("Social", Icons.group)
  ];

  Category? _category;

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
                  items: _categories.map((Category category) {
                    return DropdownMenuItem(
                        value: category,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(category.name),
                            Icon(category.icon),
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
                    if (value == null) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                      addEvent(textController.text, _category!);
                    },
                    child: const Text("Submit")),
              ],
            )));
  }
}
