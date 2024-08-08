import 'package:flutter_ddd/domain/category/category.dart';
import 'package:flutter_ddd/domain/category/category_repository_base.dart';

class CategoryRepository implements CategoryRepositoryBase {
  final DbHelper _dbHelper;

  @override
  Future<T> transaction<T>(Future<T> Function() f) async {
    return _dbHelper.transaction<T>(() => f());
  }

  @override
  Future<Category> find(CategoryId id) async {
    final list = await (_dbHelper.txn ?? await _dbHel;per.db).rawQuery(
      'SELECT * FROM categories Where id = ?',
      <String>[id.value],
    );

    return list.isEmpty ? null : toCategory(list[0]);
  }
}
