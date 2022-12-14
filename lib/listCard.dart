import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final IconData typeIcon;
  final String event;

  const ListCard({super.key, required this.typeIcon, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: ListTile(
        leading: Icon(typeIcon, color: Colors.green),
        title: Text(event),
        trailing: const Icon(Icons.arrow_forward_rounded),
      ),
    ));
  }
}
