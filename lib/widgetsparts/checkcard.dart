import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  final IconData iconData;
  final String text;
  final bool checked;
  final ValueChanged<bool?> onChanged;
  final DateTime deadline; // Add the deadline parameter

  CustomCard({
    required this.iconData,
    required this.text,
    required this.checked,
    required this.onChanged,
    required this.deadline, // Add the deadline parameter to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: checked,
          onChanged: onChanged,
        ),
        title: Text(
          text,
          style: TextStyle(
            decoration: checked ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(DateFormat.yMMMd().add_jm().format(deadline)), // Display the deadline
        trailing: Icon(iconData),
      ),
    );
  }
}

