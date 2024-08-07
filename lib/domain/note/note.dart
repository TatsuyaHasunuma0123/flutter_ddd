import 'package:flutter_ddd/domain/category/value/category_id.dart';
import 'package:flutter_ddd/domain/note/value/note_body.dart';
import 'package:flutter_ddd/domain/note/value/note_id.dart';
import 'package:flutter_ddd/domain/note/value/note_title.dart';

class Note {
  Note({
    required this.id,
    required NoteTitle title,
    required NoteBody body,
    required CategoryId categoryId,
  })  : _title = title,
        _body = body,
        _categoryId = categoryId;
  final NoteId id;
  NoteTitle _title;
  NoteBody _body;
  CategoryId _categoryId;

  NoteTitle get title => _title;
  NoteBody get body => _body;
  CategoryId get categoryId => _categoryId;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is Note && other.id == id);

  @override
  int get hashCode => runtimeType.hashCode ^ id.hashCode;

  // ignore: use_setters_to_change_properties
  void changeTitle(NoteTitle title) {
    _title = title;
  }

  // ignore: use_setters_to_change_properties
  void changeBody(NoteBody body) {
    _body = body;
  }

  // ignore: use_setters_to_change_properties
  void changeCategory(CategoryId categoryId) {
    _categoryId = categoryId;
  }
}
