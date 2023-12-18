import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:technaureus_test/sqflite_db/customer_db/model.dart';
import 'package:technaureus_test/sqflite_db/product_db/model.dart';


class CustomerDatabase {
  static final CustomerDatabase instance = CustomerDatabase._init();

  static Database? _database;

  CustomerDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('customer.db');
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
    CREATE TABLE $customerTable (
    ${CustomerFields.id} $idType,
    ${CustomerFields.name} $textType,
    ${CustomerFields.profilePic} $textType,
    ${CustomerFields.mobileNum} $textType,
    ${CustomerFields.email} $textType,
    ${CustomerFields.street} $textType,
    ${CustomerFields.streetTwo} $textType,
    ${CustomerFields.city} $textType,
    ${CustomerFields.pincode} $integerType,
    ${CustomerFields.country} $textType,
    ${CustomerFields.state} $textType,
    ${CustomerFields.createdDate} $textType,
    ${CustomerFields.createdTime} $textType,
    ${CustomerFields.modifiedDate} $textType,
    ${CustomerFields.modifiedTime} $textType
    )
    ''');
  }

  Future<Customer> create(Customer customer) async {
    final db = await instance.database;

    final id = await db.insert(customerTable, customer.toJson());
    return customer.copy(id: id);
  }

  Future<Customer?> readData(int id) async {
    final db = await instance.database;

    final maps = await db.query(customerTable,
        columns: CustomerFields.values,
        where: '${CustomerFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Customer.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Customer>?> readAllProductData() async {
    final db = await instance.database;

    final result = await db.query(customerTable);

    return result.map((json) => Customer.fromJson(json)).toList();
  }

  Future<int> update(Customer customer) async {
    final db = await instance.database;

    return db.update(
      customerTable,
      customer.toJson(),
      where: '${CustomerFields.id} = ?',
      whereArgs: [customer.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      customerTable,
      where: '${CustomerFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTable() async {
    final db = await instance.database;

    return await db.delete(customerTable);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
