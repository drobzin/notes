import 'package:flutter/material.dart';

import 'note.dart';

class NotePage extends StatelessWidget {
  NotePage({super.key}) {
    _textController = TextEditingController();
    _titleController = TextEditingController();
  }
  NotePage.withValue(this.title, this.text, {super.key}) {
    _textController = TextEditingController(text: text);
    _titleController = TextEditingController(text: title);
  }

  String title = '';
  String text = '';

  late final TextEditingController _textController;
  late final TextEditingController _titleController;

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
              controller: _titleController,
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
              controller: _textController,
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
          title = _titleController.text;
          text = _textController.text;
          Navigator.pop(context, Note(title, text));
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
