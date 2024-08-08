import 'package:flutter_ddd/domain/category/category_factory_base.dart';
import 'package:uuid/uuid.dart';

class CategoryFactory implements CategoryFactoryBase {
  const CategoryFactory();

  @override
  Category create({required String name}) {
    return Category(
      id: CategoryId(const Uuid().v4()),
      name: CategoryName(name),
    );
  }
}
