import 'package:flutter_ddd/domain/category/category_factory_base.dart';
import 'package:flutter_ddd/domain/note/note.dart';
import 'package:flutter_ddd/domain/note/value/note_body.dart';
import 'package:flutter_ddd/domain/note/value/note_title.dart';

abstract class NoteFactoryBase {
  Note create({
    required NoteTitle title,
    required NoteBody body,
    required CategoryId categoryId,
  });
}
