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
    on<Change>(_onChange);
  }
  Future<void> _onLoad(Load event, Emitter<MainState> emit) async {
    final notes = await networkRepository.getNotes();
    emit(MainState(notes: notes));
  }

  Future<void> _onAdd(Add event, Emitter<MainState> emit) async {
    await networkRepository.addNote(event.note);
    emit(MainState(notes: [...state.notes, event.note]));
  }

  Future<void> _onChange(Change event, Emitter<MainState> emit) async {
    final notes = await networkRepository.changeNote(event.note);

    emit(MainState(notes: notes));
  }
}
