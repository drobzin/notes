import 'package:flutter/material.dart';

import 'models/note.dart';

class NotePage extends StatefulWidget {
  late final TextEditingController _textController;
  late final TextEditingController _titleController;
  final int id;

  NotePage({this.id = 0, String title = '', String? text = '', super.key}) {
    _textController = TextEditingController(text: text);
    _titleController = TextEditingController(text: title);
  }

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  String title = '';
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: widget._titleController,
              onChanged: (String value) {
                title = value;
              },
              maxLines: 1,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                isCollapsed: true,
                hintText: 'Заголовок',
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 25,
                height: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            child: TextField(
              controller: widget._textController,
              onChanged: (String value) {
                text = value;
              },
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Текст заметки',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          title = widget._titleController.text;
          text = widget._textController.text;
          if (widget.id == 0) {
            Navigator.pop(context, Note.generateId(title, text));
          } else {
            Navigator.pop(context, Note(widget.id, title, text));
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
