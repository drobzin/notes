part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class Load extends MainEvent {}

class Add extends MainEvent {
  final Note note;
  Add(this.note);
}

class ChangeNote extends MainEvent {
  final Note changedNote;
  final Note initialNote;
  ChangeNote(this.changedNote, this.initialNote);
}

class Delete extends MainEvent {
  final Note note;

  Delete(this.note);
}
