import 'package:flutter/material.dart';
import 'package:flutter_ddd/common/exception.dart';

@immutable
class NoteId {
  NoteId(this.value) {
    if (value.isEmpty) {
      throw NullEmptyException(code: ExceptionCode.noteId);
    }
  }
  final String value;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is NoteId && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
