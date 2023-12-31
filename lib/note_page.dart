import 'package:flutter/material.dart';
import 'package:notes/api/notifications_api.dart';

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
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setNotification();
              },
              icon: Icon(Icons.notification_add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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

  void setNotification() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 5));
    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedDate != null && pickedTime != null) {
      DateTime setTime = DateTime(pickedDate.year, pickedDate.month,
          pickedDate.day, pickedTime.hour, pickedTime.minute);
      NotificationApi.setNotification(widget.id, "Пришло время этой заметки",
          widget._titleController.text, 'payload', setTime);
    }
  }
}
