import 'package:flutter_ddd/domain/note/note_repository_base.dart';
import 'package:flutter_ddd/domain/note/value/note_title.dart';

class NoteService {
  const NoteService({required NoteRepositoryBase repository})
      : _repository = repository;

  final NoteRepositoryBase _repository;

  Future<bool> isDuplicated(NoteTitle title) async {
    final searched = await _repository.findByTitle(title);
    return searched != null;
  }
}
