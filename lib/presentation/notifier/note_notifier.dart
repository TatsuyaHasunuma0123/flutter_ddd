import 'package:flutter/material.dart';
import 'package:flutter_ddd/application/dto/note_dto.dart';
import 'package:flutter_ddd/application/note_app_service.dart';

class NoteNotifier with ChangeNotifier {
  NoteNotifier({required NoteAppService app, required String categoryId})
      : _app = app,
        _categoryId = categoryId {
    _updateList();
  }
  final NoteAppService _app;
  final String _categoryId;
  late List<NoteDto> _list;
  List<NoteDto> get list => List.unmodifiable(_list);

  Future<void> saveNote({
    required String title,
    required String body,
    required String categoryId,
  }) async {
    await _app.saveNote(title: title, body: body, categoryId: categoryId);
    _updateList();
  }

  Future<void> updateNote({
    required String id,
    required String title,
    required String body,
    required String categoryId,
  }) async {
    await _app.updateNote(
        id: id, title: title, body: body, categoryId: categoryId);
    _updateList();
  }

  Future<void> removeNote(String id) async {
    return _app.removeNote(id: id);
  }

  void _updateList() {
    _app.getNoteList(categoryId: _categoryId).then((list) {
      _list = list;
      notifyListeners();
    });
  }
}
