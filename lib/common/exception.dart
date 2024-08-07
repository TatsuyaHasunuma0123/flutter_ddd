class GenericException implements Exception {
  GenericException({this.code = ExceptionCode.unknown, this.info});
  final ExceptionCode code;
  final dynamic info;

  @override
  String toString() {
    return '$runtimeType: ${code.hashCode}';
  }

  String get message {
    switch (runtimeType) {
      case NotFoundException _:
        return '${code.name}: $info¥nis not found.';
      case NotUniqueException _:
        return '${code.name}: $info¥n already exists.';
      case NullEmptyException _:
        return '${code.name}¥n must not be null or empty.';
      case LengthException _:
        return '${code.name}: length of $info letters or shorter.';
      case RemovalException _:
        return code == ExceptionCode.category
            ? 'Cannot be removed; ¥n this category contains notes.'
            : 'Cannot be removed';
      default:
        return 'Unknown error occurred.';
    }
  }
}

class NotFoundException extends GenericException {
  NotFoundException({required super.code, required String target})
      : assert(target.isNotEmpty),
        super(info: target);
}

class NotUniqueException extends GenericException {
  NotUniqueException({required super.code, required String value})
      : assert(value.isNotEmpty),
        super(info: value);
}

class NullEmptyException extends GenericException {
  NullEmptyException({required super.code});
}

class LengthException extends GenericException {
  LengthException({required super.code, required int max})
      : assert(max > 0),
        super(info: max);
}

class RemovalException extends GenericException {
  RemovalException({required super.code});
}

enum ExceptionCode {
  unknown,
  category,
  categoryId,
  categoryName,
  note,
  noteId,
  noteTitle,
}

extension ExceptionCodeValue on ExceptionCode {
  String get value {
    switch (this) {
      case ExceptionCode.category:
        return 'Category';
      case ExceptionCode.categoryId:
        return 'Category ID';
      case ExceptionCode.categoryName:
        return 'Category Name';
      case ExceptionCode.note:
        return 'Note';
      case ExceptionCode.noteId:
        return 'Note ID';
      case ExceptionCode.noteTitle:
        return 'Note Title';
      case ExceptionCode.unknown:
        return 'Unknown';
    }
  }
}
