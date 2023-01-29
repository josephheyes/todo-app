import 'package:bordered_text/bordered_text.dart';
import 'package:dristle/list.dart';
import 'package:flutter/material.dart';
import 'package:dristle/db_service.dart';
import 'package:dristle/manage_categories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseService db = DatabaseService.instance;

  db.updateCategories();
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
              height: (MediaQuery.of(context).size.height) * 0.9,
              child: Card(
                color: Theme.of(context).colorScheme.primary,
                elevation: 15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BorderedText(
                      strokeColor: Colors.black,
                      child: Text(
                        "planito",
                        style: TextStyle(
                            fontSize: 100,
                            color: Theme.of(context).colorScheme.surface,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto Serif'),
                      ),
                    ),
                    Text(
                      "Start small!",
                      style: TextStyle(
                        fontSize: 40,
                        color: Theme.of(context).colorScheme.surface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0)),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.inversePrimary),
                        foregroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.inverseSurface),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(20, 0, 20, 0)),
                      ),
                      onPressed: () {
                        Navigator.restorablePush(
                          context,
                          _listRoute,
                        );
                      },
                      child: const Text(
                        "View my tasks",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.inversePrimary),
                        foregroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.inverseSurface),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(20, 0, 20, 0)),
                      ),
                      onPressed: () {
                        Navigator.restorablePush(
                          context,
                          _newCategoryRoute,
                        );
                      },
                      child: const Text(
                        "Add categories",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Route _listRoute(BuildContext context, Object? params) {
    return MaterialPageRoute(
      builder: (context) => TodoList(),
    );
  }

  static Route _newCategoryRoute(BuildContext context, Object? params) {
    return MaterialPageRoute(
      builder: (context) => const CategoryManager(),
    );
  }
}
