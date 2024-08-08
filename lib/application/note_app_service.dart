import 'package:flutter_ddd/application/dto/note_dto.dart';
import 'package:flutter_ddd/common/exception.dart';
import 'package:flutter_ddd/domain/category/category_factory_base.dart';
import 'package:flutter_ddd/domain/note/note_factory_base.dart';
import 'package:flutter_ddd/domain/note/note_repository_base.dart';
import 'package:flutter_ddd/domain/note/note_service.dart';
import 'package:flutter_ddd/domain/note/value/note_body.dart';
import 'package:flutter_ddd/domain/note/value/note_id.dart';
import 'package:flutter_ddd/domain/note/value/note_title.dart';

class NoteAppService {
  NoteAppService({
    required NoteFactoryBase factory,
    required NoteRepositoryBase repository,
  })  : _factory = factory,
        _repository = repository,
        _service = NoteService(repository: repository);

  final NoteFactoryBase _factory;
  final NoteRepositoryBase _repository;
  final NoteService _service;

  Future<void> saveNote({
    required String title,
    required String body,
    required String categoryId,
  }) async {
    final note = _factory.create(
      title: NoteTitle(title),
      body: NoteBody(body),
      categoryId: CategoryId(categoryId),
    );

    await _repository.transaction(() async {
      if (await _service.isDuplicated(note.title)) {
        throw NotUniqueException(
          code: ExceptionCode.noteTitle,
          value: note.title.value,
        );
      } else {
        await _repository.save(note);
      }
    });
  }

  Future<void> updateNote({
    required String id,
    required String title,
    required String body,
    required String categoryId,
  }) async {
    final targetId = NoteId(id);

    await _repository.transaction<void>(() async {
      final target = await _repository.find(targetId);
      if (target == null) {
        throw NotFoundException(
          code: ExceptionCode.noteId,
          target: targetId.value,
        );
      }

      final newTitle = NoteTitle(title);
      if (newTitle != target.title && await _service.isDuplicated(newTitle)) {
        throw NotUniqueException(
          code: ExceptionCode.noteTitle,
          value: targetId.value,
        );
      }
      target.changeTitle(newTitle);

      final newBody = NoteBody(body);
      target.changeBody(newBody);

      final newCategoryId = CategoryId(categoryId);
      target.changeCategory(newCategoryId);

      await _repository.save(target);
    });
  }

  Future<void> removeNote({required String id}) {
    final targetId = NoteId(id);

    return _repository.transaction<void>(() async {
      final target = await _repository.find(targetId);
      if (target == null) {
        throw NotFoundException(
          code: ExceptionCode.noteId,
          target: targetId.value,
        );
      }
      await _repository.remove(target);
    });
  }

  Future<NoteDto?> getNote({required String id}) async {
    final targetId = NoteId(id);
    final target = await _repository.find(targetId);

    return target == null ? null : NoteDto(target);
  }

  Future<List<NoteDto?>> getNoteList({required String categoryId}) async {
    final targetId = CategoryId(categoryId);
    final notes = await _repository.findByCategory(targetId);

    return notes.map((x) => NoteDto(x!)).toList();
  }
}
