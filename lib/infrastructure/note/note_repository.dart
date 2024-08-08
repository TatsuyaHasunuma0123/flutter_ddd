import 'package:flutter_ddd/domain/category/value/category_id.dart';
import 'package:flutter_ddd/domain/note/note.dart';
import 'package:flutter_ddd/domain/note/note_repository_base.dart';
import 'package:flutter_ddd/domain/note/value/note_body.dart';
import 'package:flutter_ddd/domain/note/value/note_id.dart';
import 'package:flutter_ddd/domain/note/value/note_title.dart';
import 'package:flutter_ddd/infrastructure/db_helper.dart';

class NoteRepository implements NoteRepositoryBase {
  const NoteRepository({required DbHelper dbHelper}) : _dbHelper = dbHelper;
  final DbHelper _dbHelper;

  Note toNote(Map<String, dynamic> data) {
    final id = data['id'].toString();
    final title = data['title'].toString();
    final body = data['body'].toString();
    final categoryId = data['category_id'].toString();

    return Note(
      id: NoteId(id),
      title: NoteTitle(title),
      body: NoteBody(body),
      categoryId: CategoryId(categoryId),
    );
  }

  @override
  Future<T> transaction<T>(Future<T> Function() f) {
    return _dbHelper.transaction<T>(() async => f());
  }

  @override
  Future<Note?> find(NoteId id) async {
    final list = await _dbHelper.rawQuery(
      'SELECT * FROM notes WHERE id = ?',
      <String>[id.value],
    );
    return list.isEmpty ? null : toNote(list[0]);
  }

  @override
  Future<Note?> findByTitle(NoteTitle title) async {
    final list = await _dbHelper.rawQuery(
      'SELECT * FROM notes WHERE title = ?',
      <String>[title.value],
    );
    return list.isEmpty ? null : toNote(list[0]);
  }

  @override
  Future<List<Note?>> findByCategory(CategoryId categoryId) async {
    final list = await _dbHelper.rawQuery(
      'SELECT * FROM notes WHERE category_id = ?',
      <String>[categoryId.value],
    );

    if (list.isEmpty) {
      return <Note>[];
    }

    return list.map(toNote).toList();
  }

  @override
  Future<int> countByCategory(CategoryId categoryId) async {
    final list = await _dbHelper.rawQuery(
      'SELECT COUNT(*) AS cnt FROM notes WHERE category_id = ?',
      <String>[categoryId.value],
    );

    final row = Map<String, int>.from(list[0]);
    return row['cnt'] ?? 0;
  }

  @override
  Future<void> save(Note note) async {
    await _dbHelper.rawInsert(
      '''
        INSERT OR REPLACE INTO notes
        (id, title, body, category_id) VALUES (?, ?, ?, ?)
      ''',
      <String>[
        note.id.value,
        note.title.value,
        note.body.value,
        note.categoryId.value,
      ],
    );
  }

  @override
  Future<void> remove(Note note) async {
    await _dbHelper.rawDelete(
      'DELETE FROM notes WHERE id = ?',
      <String>[note.id.value],
    );
  }
}
