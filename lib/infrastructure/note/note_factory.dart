import 'package:flutter_ddd/domain/category/category_factory_base.dart';
import 'package:flutter_ddd/domain/note/note.dart';
import 'package:flutter_ddd/domain/note/note_factory_base.dart';
import 'package:flutter_ddd/domain/note/value/note_body.dart';
import 'package:flutter_ddd/domain/note/value/note_id.dart';
import 'package:flutter_ddd/domain/note/value/note_title.dart';
import 'package:uuid/uuid.dart';

class NoteFactory implements NoteFactoryBase {
  const NoteFactory();

  @override
  Note create({
    required NoteTitle title,
    required NoteBody body,
    required CategoryId categoryId,
  }) {
    return Note(
      id: NoteId(const Uuid().v4()),
      title: title,
      body: body,
      categoryId: categoryId,
    );
  }
}
