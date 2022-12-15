import 'package:flutter/material.dart';

class Event {
  Category category;
  String name;

  Event({required this.name, required this.category});
}

class Category {
  String name;
  IconData icon;

  Category(this.name, this.icon);
}
