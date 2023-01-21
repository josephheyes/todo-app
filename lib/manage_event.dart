import 'package:dristle/db_service.dart';
import 'package:flutter/material.dart';
import 'event.dart';

class NewEvent extends StatefulWidget {
  final List<Event>? eventList;
  final Event? event;
  late final String title;

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
    DatabaseService db = DatabaseService.instance;

    setState(() {
      Event event = Event(name: text, category: category);

      widget.eventList!.add(
        event,
      );

      db.insertEvent(event);

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
    Category(name: "Chore", icon: Icons.check),
    Category(name: "Work", icon: Icons.work),
    Category(name: "Assignment", icon: Icons.school),
    Category(name: "Health", icon: Icons.health_and_safety),
    Category(name: "Exercise", icon: Icons.fitness_center),
    Category(name: "Social", icon: Icons.group)
  ];

  Category? _category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.surface,
        ),
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
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.inversePrimary),
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.inverseSurface),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.fromLTRB(42, 0, 42, 0)),
                      elevation: MaterialStateProperty.all(5),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.eventList == null && widget.event != null) {
                          editEvent(textController.text, _category!);
                        } else {
                          addEvent(textController.text, _category!);
                        }
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 20),
                    )),
              ],
            )));
  }
}
