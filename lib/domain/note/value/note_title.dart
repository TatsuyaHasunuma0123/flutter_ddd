import 'package:flutter/material.dart';
import 'package:flutter_ddd/common/exception.dart';

@immutable
class NoteTitle {
  NoteTitle(this.value) {
    if (value.isEmpty) {
      throw NullEmptyException(code: ExceptionCode.noteTitle);
    }
  }
  final String value;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is NoteTitle && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
