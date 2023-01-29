import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'db_service.dart';
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
  void initState() {
    super.initState();
    getEvents(widget.eventList);
  }

  Future<void> getEvents(List<Event> eventList) async {
    DatabaseService service = DatabaseService.instance;
    Database db = await service.database;
    final List<Map<String, dynamic>> maps = await db.query('list');

    eventList.clear();
    for (var record in maps) {
      Event event = await service.eventFromMap(record);
      eventList.add(event);
    }
    setState(() {});
  }

  Future<void> _pullRefresh() async {
    getEvents(widget.eventList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-do List"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: ListView.builder(
            itemCount: widget.eventList.length,
            itemBuilder: (context, index) {
              return ListCard(
                event: widget.eventList[index],
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () async {
            await Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => NewEvent(eventList: widget.eventList),
            ))
                .then((context) {
              getEvents(widget.eventList);
            });
            setState(() {});
          },
          child: const Icon(Icons.add)),
    );
  }
}
