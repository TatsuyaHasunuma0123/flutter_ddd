import 'package:flutter_ddd/domain/category/category.dart';
import 'package:flutter_ddd/domain/category/category_repository_base.dart';

class CategoryService {
  const CategoryService({required CategoryRepositoryBase repository})
      : _repository = repository;
  final CategoryRepositoryBase _repository;

  Future<bool> isDuplicated(CategoryName name) async {
    final searched = await _repository.findByName(name);
    return searched != null;
  }
}
