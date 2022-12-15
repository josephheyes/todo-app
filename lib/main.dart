import 'package:dristle/event.dart';
import 'package:dristle/list_card.dart';
import 'package:dristle/new_event.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Dristle'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;
  final List<Event> eventList = [];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Column listColumn = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
