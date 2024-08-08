import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const _dbFile = 'ddd.db';
const _dbVersion = 1;

class DbHelper {
  late Database _db;
  late Transaction _txn;

  Future<Database> open() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _dbFile);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (Database db, int version) async {
        await db.execute('''
            CREATE TABLE notes (
            id TEXT NOT NULL,
            title TEXT NOT NULL,
            body TEXT NOT NULL,
            category_id TEXT NOT NULL,
            PRIMARY KEY (id))
        ''');

        await db.execute('''
          CREATE INDEX idx_category_id
          ON notes(category_id)
        ''');

        await db.execute('''
          CREATE TABLE categories (
            id TEXT NOT NULL,
            name TEXT NOT NULL,
            PRIMARY KEY (id)
          )
        ''');
      },
    );
  }

  Future<void> dispose() async {
    await _db.close();
  }

  Future<T> transaction<T>(Future<T> Function() f) async {
    return _db.transaction<T>((txn) async {
      _txn = txn;
      return f();
    }).then((v) {
      return v;
    });
  }

  Future<List<Map<String, dynamic>>> rawQuery(
    String sql, [
    List<dynamic>? arguments,
  ]) async {
    return _txn.rawQuery(sql, arguments);
  }

  Future<int> rawInsert(
    String sql, [
    List<dynamic>? arguments,
  ]) async {
    return _txn.rawInsert(sql, arguments);
  }

  Future<int> rawDelete(
    String sql, [
    List<dynamic>? arguments,
  ]) async {
    return _txn.rawDelete(sql, arguments);
  }
}
