part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class Load extends MainEvent {}

class Add extends MainEvent {
  final Note note;
  Add(this.note);
}

class Change extends MainEvent {
  final Note note;
  Change(this.note);
}
