import 'package:flutter_ddd/domain/category/category_factory_base.dart';
import 'package:meta/meta.dart';

@immutable
class CategoryDto {
  CategoryDto(Category source)
      : id = source.id.value,
        name = source.name.value;

  final String id;
  final String name;
}
