import 'package:flutter/material.dart';
import 'package:notes/notes.dart';

class EditNote extends StatelessWidget {
  const EditNote({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateNote note =
        ModalRoute.of(context)?.settings.arguments as CreateNote;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(note.header),
          ],
        ),
      ),
    );
  }
}
