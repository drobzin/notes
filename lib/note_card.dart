import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/bloc/main_bloc.dart';
import 'package:notes/note_page.dart';

import 'models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  NotePage(id: note.id, title: note.title, text: note.text),
            )).then((changedNote) {
          context.read<MainBloc>().add(ChangeNote(changedNote, note));
        });
      },
      onLongPress: () => showDeleteDialog(context),
      child: Card(
        child: ListTile(
          title: Text(
            note.title,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            note.text,
            maxLines: 4,
            overflow: TextOverflow.fade,
          ),
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Удаление'),
            content: Text('Вы действительно хотите удалить эту заметку'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Нет'),
              ),
              TextButton(
                onPressed: () {
                  context.read<MainBloc>().add(Delete(note));
                  Navigator.pop(context);
                },
                child: Text('Да'),
              ),
            ],
          );
        });
  }
}
