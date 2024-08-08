import 'package:flutter_ddd/domain/category/category.dart';

export 'package:flutter_ddd/domain/category/category.dart';

// ignore: one_member_abstracts
abstract class CategoryFactoryBase {
  Category create({required String name});
}
