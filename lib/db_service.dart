import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'event.dart';

class DatabaseService {

  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  static Database? _database;

  final List<Category> _categories = [
    Category(name: "Chore", icon: Icons.check),
    Category(name: "Work", icon: Icons.work),
    Category(name: "Assignment", icon: Icons.school),
    Category(name: "Health", icon: Icons.health_and_safety),
    Category(name: "Exercise", icon: Icons.fitness_center),
    Category(name: "Social", icon: Icons.group)
  ];

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await open();
    return _database!;
  }


  open() async {
    return await openDatabase(
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

      return Category(name: result[0]['name'], icon: IconData(result[0]['icon']));
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
      for (Category category in _categories) {
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
}
