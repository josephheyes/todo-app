import 'package:dristle/db_service.dart';
import 'package:flutter/material.dart';

class Event {
  Category category;
  String name;

  Event({required this.name, required this.category});

  Future<Map<String, dynamic>> toMap() async {

    return {
      'name': name,
      'category': await getCategoryID(category.name),
    };
  }

  @override
  String toString() {
    return 'Event{name: $name, category: $category.name';
  }
}

class Category {
  String name;
  IconData icon;

  Category(this.name, this.icon);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon.codePoint,
    };
  }
}
