import 'package:flutter/material.dart';
import 'package:flutter_ddd/common/exception.dart';

@immutable
class NoteBody {
  NoteBody(this.value) {
    if (value.isEmpty) {
      throw NullEmptyException(code: ExceptionCode.note);
    }
  }
  final String value;
  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is NoteBody && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
