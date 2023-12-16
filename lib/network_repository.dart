import 'package:dio/dio.dart';
import 'package:notes/models/note.dart';
import 'package:notes/rest_client.dart';

class NetworkRepository {
  late final RestClient _client;
  final Dio _dio = Dio();

  NetworkRepository() {
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    _dio.options.baseUrl = 'http://192.168.1.35:3000';
    _client = RestClient(_dio);
  }

  Future<List<Note>> getNotes() async => _client.getNotes();
  Future<void> addNote(Note note) async => _client.addNote(note);
  Future<void> changeNote(Note note) async => _client.changeNote(note.id, note);
  Future<void> deleteNote(Note note) async => _client.deleteNote(note.id);
}
