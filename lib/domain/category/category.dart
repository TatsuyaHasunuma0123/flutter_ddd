import 'package:flutter_ddd/domain/category/value/category_id.dart';
import 'package:flutter_ddd/domain/category/value/category_name.dart';

export 'package:flutter_ddd/domain/category/value/category_id.dart';
export 'package:flutter_ddd/domain/category/value/category_name.dart';

class Category {
  Category({required this.id, required CategoryName name}) : _name = name;
  final CategoryId id;
  CategoryName _name;

  CategoryName get name => _name;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is Category && other.id == id);

  @override
  int get hashCode => runtimeType.hashCode ^ id.hashCode;

  void changeName(CategoryName newName) {
    _name = newName;
  }
}
