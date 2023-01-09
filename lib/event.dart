import 'package:flutter/material.dart';

class Event {
  Category category;
  String name;

  Event({required this.name, required this.category});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category.name,
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
}
