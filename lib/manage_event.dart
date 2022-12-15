import 'package:flutter/material.dart';
import 'event.dart';

class NewEvent extends StatefulWidget {
  final List<Event>? eventList;
  Event? event;
  late String title;

  @override
  NewEventState createState() {
    return NewEventState();
  }

  NewEvent({super.key, this.eventList, this.event}) {
    if (eventList == null) {
      title = "Edit Event";
    } else {
      title = "Create New Event";
    }
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

  Future<void> addEvent(String text, Category category) async {
    setState(() {
      widget.eventList!.add(
        Event(name: text, category: category),
      );

      Navigator.pop(context);
    });
  }

  Future<void> editEvent(String text, Category category) async {
    setState(() {
      widget.event!.name = text;
      widget.event!.category = category;

      Navigator.pop(context);
    });
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
        appBar: AppBar(title: Text(widget.title)),
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
                      if (_formKey.currentState!.validate()) {
                        if (widget.eventList == null && widget.event != null) {
                          editEvent(textController.text, _category!);
                        } else {
                          addEvent(textController.text, _category!);
                        }
                      }
                    },
                    child: const Text("Submit")),
              ],
            )));
  }
}
