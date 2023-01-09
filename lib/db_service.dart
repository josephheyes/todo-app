import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'event.dart';

// TODO: find out why categories aren't being added to table
Future<Database>? database;

final List<Category> _categories = [
  Category("Chore", Icons.check),
  Category("Work", Icons.work),
  Category("Assignment", Icons.school),
  Category("Health", Icons.health_and_safety),
  Category("Exercise", Icons.fitness_center),
  Category("Social", Icons.group)
];

void open() async {
  database = openDatabase(
    join(await getDatabasesPath(), 'list.db'),
    onCreate: (db, version) {
      db.execute(
        'CREATE TABLE list(id INTEGER PRIMARY KEY, name TEXT, categoryID INTEGER)',
      );
      db.execute(
        'CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, icon INTEGER)',
      );
    },
    version: 1,
  );
}

Future<int> getCategoryID(String name) async {
  final db = await database;

  if (db != null) {
    List<Map> result =
        await db.rawQuery('SELECT id FROM categories WHERE name=$name');

    return result[0]["id"];
  } else {
    throw Exception("Couldn't get category ID");
  }
}

Future<Category> getCategoryFromID(int id) async {
  final db = await database;

  if (db != null) {
    List<Map> result =
        await db.rawQuery('SELECT * FROM categories WHERE id=$id');

    return Category(result[0]['name'], IconData(result[0]['icon']));
  } else {
    throw Exception("Couldn't get category from ID");
  }
}

Future<void> insertEvent(Event event) async {
  final db = await database;

  if (db != null) {
    await db.insert(
      'list',
      await event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // print(await getEvents());
  } else {
    throw Exception("No DB found");
  }
}

Future<void> updateCategories() async {
  final db = await database;

  if (db != null) {
    for (var category in _categories) {
      await db.insert(
        'categories',
        category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}

Future<void> getEvents() async {
  final db = await database;
  if (db != null) {
    final List<Map<String, dynamic>> maps = await db.query('list');

    for (var event in maps) {
      print(event[0]['name']);
    }

    // return Future.wait(List.generate(maps.length, (i) async {
    //   Category category = await getCategoryFromID(maps[i]['categoryID']);
    //   return Event(
    //     name: maps[i]['name'],
    //     category: category,
    //   );
    // }));

  }
  // else {
  //   return [];
  // }
}
