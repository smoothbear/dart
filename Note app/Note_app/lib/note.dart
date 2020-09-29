import 'package:flutter/cupertino.dart';

class Note {
  final String id;
  String title;
  String content;
  Color color;
  NoteState state;
  final DateTime createdAt;
  DateTime modifiedAt;

  Note({
    this.id,
    this.title,
    this.color,
    this.state,
    DateTime createdAt,
    DateTime modifiedAt,
}): this.createdAt = createdAt ?? DateTime.now(),
    this.modifiedAt = modifiedAt ?? DateTime.now();
}

enum NoteState {
  unspecified,
  pinned,
  archived,
  deleted,
}