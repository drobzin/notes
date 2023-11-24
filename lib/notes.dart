import 'package:flutter/material.dart';

class Note {
  String header;
  String text;

  Note(this.header, this.text);
}

class CreateNote extends StatelessWidget {
  CreateNote({super.key}) {
    _textController = TextEditingController();
    _headerController = TextEditingController();
  }
  CreateNote.withValue(this.header, this.text, {super.key}) {
    _textController = TextEditingController(text: text);
    _headerController = TextEditingController(text: header);
  }

  String header = '';
  String text = '';

  late TextEditingController _textController;
  late TextEditingController _headerController;

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
              controller: _headerController,
              onChanged: (String value) {
                header = value;
              },
              maxLines: null,
              keyboardType: TextInputType.multiline,
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
          header = _headerController.text; // TODO: delete
          text = _textController.text; // TODO: delete
          Navigator.pop(context, Note(header, text));
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
