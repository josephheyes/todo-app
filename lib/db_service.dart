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
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE list(id INTEGER PRIMARY KEY, name TEXT, categoryID INTEGER)",
        );
        await db.execute(
          "CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT type UNIQUE, icon INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<int> getCategoryID(String name) async {
    Database db = await instance.database;

    List<Map> result =
        await db.rawQuery("SELECT id FROM categories WHERE name='$name'");

    return result[0]["id"];
  }

  Future<Category> getCategoryFromID(int id) async {
    Database db = await instance.database;

    List<Map<String, dynamic>> result =
        await db.rawQuery("SELECT * FROM categories WHERE id=$id");

    print(result[0]);
    return categoryFromMap(result[0]);
  }

  Future<void> insertEvent(Event event) async {
    Database db = await instance.database;

    await db.insert(
      'list',
      await event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateEvent(int id, String name, Category category) async {
    Database db = await instance.database;

    Event updatedEvent = Event(name: name, category: category);
    Map<String, dynamic> updatedRow = await updatedEvent.toMap();

    db.update('list', updatedRow, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateCategories() async {
    Database db = await instance.database;
    for (Category category in _categories) {
      await db.insert('categories', category.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  Future<Event> eventFromMap(Map<String, dynamic> map) async {
    return Event(
      id: map['id'],
      name: map['name'],
      category: await getCategoryFromID(map['categoryID']),
    );
  }

  Category categoryFromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      icon: IconData(map['icon'], fontFamily: "MaterialIcons"),
    );
  }
}
