import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/models/note.dart';
import 'package:notes/network_repository.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final NetworkRepository networkRepository;
  MainBloc(this.networkRepository) : super(const MainState()) {
    on<Load>(_onLoad);
    on<Add>(_onAdd);
    on<ChangeNote>(_onChangeNote);
    on<Delete>(_onDelete);
  }
  Future<void> _onLoad(Load event, Emitter<MainState> emit) async {
    final notes = await networkRepository.getNotes();
    emit(MainState(notes: notes));
  }

  Future<void> _onAdd(Add event, Emitter<MainState> emit) async {
    await networkRepository.addNote(event.note);
    emit(MainState(notes: [...state.notes, event.note]));
  }

  Future<void> _onChangeNote(ChangeNote event, Emitter<MainState> emit) async {
    await networkRepository.changeNote(event.changedNote);
    final noteIndex = state.notes.indexOf(event.initialNote);
    final notes = List<Note>.from(state.notes);
    notes[noteIndex] = event.changedNote;

    emit(MainState(notes: notes));
  }

  Future<void> _onDelete(Delete event, Emitter<MainState> emit) async {
    await networkRepository.deleteNote(event.note);
    state.notes.remove(event.note);
    emit(MainState(notes: state.notes));
  }
}
