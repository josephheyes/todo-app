import 'package:dristle/new_event.dart';
import 'package:flutter/material.dart';
import 'event.dart';

class ListCard extends StatefulWidget {
  final Event event;

  const ListCard({super.key, required this.event});

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: ListTile(
        leading: IconButton(
          icon: Icon(widget.event.category.icon, color: Colors.green),
          onPressed: (() async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewEvent(event: widget.event),
              ),
            );
            setState(() {});
          }),
        ),
        title: Text(widget.event.name),
        trailing: const Icon(Icons.arrow_forward_rounded),
      ),
    ));
  }
}
