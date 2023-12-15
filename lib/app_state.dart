import 'package:flutter/material.dart';

import 'models/note.dart';

class MyAppState extends ChangeNotifier {
  List<Note> notes = <Note>[];

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
  }

  void removeNote(Note note) {
    notes.remove(note);
    notifyListeners();
  }

  void changeNote(Note note) {
    addNote(note);
    notifyListeners();
  }
}
