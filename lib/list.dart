import 'package:flutter/material.dart';
import 'event.dart';
import 'list_card.dart';
import 'manage_event.dart';

class TodoList extends StatefulWidget {
  TodoList({super.key});
  final List<Event> eventList = [];

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  Column listColumn = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: const [],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-do List"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: ListView.builder(
        itemCount: widget.eventList.length,
        itemBuilder: (context, index) {
          return ListCard(
            event: widget.eventList[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewEvent(eventList: widget.eventList),
              ),
            );
            setState(() {});
          },
          child: const Icon(Icons.add)),
    );
  }
}
