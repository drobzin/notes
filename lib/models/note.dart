import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  late final int id;
  String title;
  String text;

  Note(this.id, this.title, this.text);
  Note.generateId(this.title, this.text) {
    id = UniqueKey().hashCode;
  }

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
