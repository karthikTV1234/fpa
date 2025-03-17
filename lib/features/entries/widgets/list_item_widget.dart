import 'package:flutter/material.dart';
import 'package:fpa/data/models/entry_model.dart';

class EntryListItem extends StatelessWidget {
  final Entry entry;

  const EntryListItem({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          entry.item,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Category: ${entry.category}\nDate: ${entry.date}\nLocation: ${entry.location}",
        ),
        trailing: Text(
          "₹${entry.price.toStringAsFixed(2)}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
