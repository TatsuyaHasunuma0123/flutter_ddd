import 'package:flutter_ddd/domain/category/category_factory_base.dart';
import 'package:flutter_ddd/domain/note/note.dart';
import 'package:flutter_ddd/domain/note/value/note_id.dart';
import 'package:flutter_ddd/domain/note/value/note_title.dart';

abstract class NoteRepositoryBase {
  Future<T> transaction<T>(Future<T> Function() f);
  Future<Note?> find(NoteId id);
  Future<Note?> findByTitle(NoteTitle title);
  Future<List<Note?>> findByCategory(CategoryId categoryId);
  Future<int> countByCategory(CategoryId categoryId);
  Future<void> save(Note note);
  Future<void> remove(Note note);
}
