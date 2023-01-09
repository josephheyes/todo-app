import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'event.dart';

// TODO: modify code so IconData.codePoint is added to categories table (maybe not necessary
// if storing category list like below, can just add an ID value to category class)
// when adding an event to list table, ensure correct category id is linked to it
// when creating list of events, assign category using id to pull category from category list

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

Future<void> insertEvent(Event event) async {
  final db = await database;

  if (db != null) {
    await db.insert(
      'list',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(await getEvents());
  }
}

Future<List<Event>> getEvents() async {
  final db = await database;
  if (db != null) {
    final List<Map<String, dynamic>> maps = await db.query('list');

    return List.generate(maps.length, (i) {
      return Event(
        name: maps[i]['name'],
        category: maps[i]['categoryID'],
      );
    });
  } else {
    return [];
  }
}
