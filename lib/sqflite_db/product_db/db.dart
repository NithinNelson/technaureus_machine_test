import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:technaureus_test/sqflite_db/product_db/model.dart';


class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._init();

  static Database? _database;

  ProductDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('product.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $productTable (
    ${ProductFields.id} $idType,
    ${ProductFields.name} $textType,
    ${ProductFields.image} $textType,
    ${ProductFields.price} $integerType,
    ${ProductFields.inCartCount} $integerType
    )
    ''');
  }

  Future<Product> create(Product product) async {
    final db = await instance.database;

    final id = await db.insert(productTable, product.toJson());
    return product.copy(id: id);
  }

  Future<Product?> readData(int id) async {
    final db = await instance.database;

    final maps = await db.query(productTable,
        columns: ProductFields.values,
        where: '${ProductFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Product.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Product>?> readAllProductData() async {
    final db = await instance.database;

    final result = await db.query(productTable);

    return result.map((json) => Product.fromJson(json)).toList();
  }

  Future<int> update(Product product) async {
    final db = await instance.database;

    return db.update(
      productTable,
      product.toJson(),
      where: '${ProductFields.id} = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      productTable,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTable() async {
    final db = await instance.database;

    return await db.delete(productTable);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
