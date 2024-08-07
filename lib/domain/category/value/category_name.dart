import 'package:flutter/material.dart';
import 'package:flutter_ddd/common/exception.dart';

@immutable
class CategoryName {
  CategoryName(this.value) {
    if (value.isEmpty) {
      throw NullEmptyException(code: ExceptionCode.categoryName);
    }
  }
  final String value;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is CategoryName && other.value == value);

  @override
  int get hashCode => value.hashCode ^ runtimeType.hashCode;
}
