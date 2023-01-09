import 'package:bordered_text/bordered_text.dart';
import 'package:dristle/list.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  final listDatabase = openDatabase(
    join(await getDatabasesPath(), 'list.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE list(id INTEGER PRIMARY KEY, name TEXT, category TEXT)',
      );
    },
    version: 1,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      restorationScopeId: "root",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height) * 0.8,
              child: Card(
                color: Theme.of(context).colorScheme.primary,
                elevation: 15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BorderedText(
                      strokeColor: Colors.black,
                      child: Text(
                        "Dristle",
                        style: TextStyle(
                            fontSize: 100,
                            color: Theme.of(context).colorScheme.surface,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto Serif'),
                      ),
                    ),
                    Text(
                      "A To-Do List App",
                      style: TextStyle(
                        fontSize: 40,
                        color: Theme.of(context).colorScheme.surface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.inversePrimary),
              foregroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.inverseSurface),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.fromLTRB(20, 0, 20, 0)),
              elevation: MaterialStateProperty.all(15),
            ),
            onPressed: () {
              Navigator.restorablePush(
                context,
                _buildRoute,
              );
            },
            child: const Text(
              "Start planning!",
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Route _buildRoute(BuildContext context, Object? params) {
    return MaterialPageRoute(
      builder: (context) => TodoList(),
    );
  }
}
