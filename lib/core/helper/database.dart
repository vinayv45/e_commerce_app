import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/models/order_item_model.dart';
import 'package:e_commerce_app/models/order_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "e_commerce.db";
  static const _databaseVersion = 1;

  // Cart table constants
  static const cartTable = 'cart';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnPrice = 'price';
  static const columnImage = 'image';
  static const columnQuantity = 'quantity';

  // Order table constants
  static const orderTable = 'orders';
  static const orderItemTable = 'order_items';
  static const orderNumber = 'orderNumber';
  static const totalAmount = 'totalAmount';
  static const paymentType = 'paymentType';
  static const shippingAddress = 'shippingAddress';
  static const orderDate = 'orderDate';
  static const customerName = 'customerName';

  // OrderItem table constants
  static const orderId = 'orderId';
  static const productName = 'productName';
  static const productPrice = 'productPrice';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $cartTable (
        $columnId INTEGER PRIMARY KEY,
        $columnTitle TEXT NOT NULL,
        $columnPrice REAL NOT NULL,
        $columnImage TEXT, 
        $columnQuantity INTEGER NOT NULL
      )
    ''');

    // Create orders table
    await db.execute('''
    CREATE TABLE $orderTable (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $orderNumber TEXT NOT NULL,
      $totalAmount REAL NOT NULL,
      $paymentType TEXT NOT NULL,
      $shippingAddress TEXT NOT NULL,
      $orderDate TEXT NOT NULL,
      $customerName TEXT NOT NULL
    )
  ''');

    // Create order items table
    await db.execute('''
    CREATE TABLE $orderItemTable (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $orderId INTEGER NOT NULL,
      $productName TEXT NOT NULL,
      $productPrice REAL NOT NULL,
      $columnQuantity INTEGER NOT NULL,
      FOREIGN KEY ($orderId) REFERENCES $orderTable($columnId)
    )
  
    ''');
  }

  // Insert a cart item
  Future<int> insertCartItem(CartItemModel item) async {
    Database db = await instance.database;
    return await db.insert(cartTable, item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Update a cart item
  Future<int> updateCartItem(CartItemModel item) async {
    Database db = await instance.database;
    return await db.update(
      cartTable,
      item.toMap(),
      where: '$columnId = ?',
      whereArgs: [item.id],
    );
  }

  // Delete a cart item
  Future<int> deleteCartItem(int id) async {
    Database db = await instance.database;
    return await db.delete(
      cartTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Query all cart items
  Future<List<CartItemModel>> queryAllCartItems() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(cartTable);
    return List.generate(maps.length, (i) {
      return CartItemModel.fromMap(maps[i]);
    });
  }

  // Insert an order
  Future<int> insertOrder(OrderModel order) async {
    Database db = await instance.database;
    return await db.insert(
      orderTable,
      order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Insert an order item
  Future<int> insertOrderItem(OrderItemModel item) async {
    Database db = await instance.database;
    return await db.insert(
      orderItemTable,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Query all orders
  Future<List<OrderModel>> queryAllOrders() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(orderTable);
    return List.generate(maps.length, (i) {
      return OrderModel.fromMap(maps[i]);
    });
  }

  // Query all order items for a specific order
  Future<List<OrderItemModel>> queryOrderItems(int orderId) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      orderItemTable,
      where: '$orderId = ?',
      whereArgs: [orderId],
    );
    return List.generate(maps.length, (i) {
      return OrderItemModel.fromMap(maps[i]);
    });
  }

  Future<void> deleteAllTables() async {
    final db = await database;
    await db.delete(cartTable);
    await db.delete(orderItemTable);
    await db.delete(orderTable);
  }
}
