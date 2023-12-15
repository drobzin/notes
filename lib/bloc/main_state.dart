part of 'main_bloc.dart';

@immutable
class MainState {
  final List<Note> notes;
  const MainState({this.notes = const []});
}
