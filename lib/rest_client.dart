import 'package:dio/dio.dart';
import 'package:notes/models/note.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET('/data')
  Future<List<Note>> getNotes();

  @POST('/data')
  Future<void> addNote(@Body() Note note);

  @PUT('/data/{id}')
  Future<void> changeNote(@Path('id') int id, @Body() Note note);

  @DELETE('/data/{id}')
  Future<void> deleteNote(@Path('id') int id);
}
