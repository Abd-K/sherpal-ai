import 'package:sherpal/models/goal_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'goals_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE goals(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        deadline TEXT,
        lastUpdated TEXT,
        category TEXT
      )
    ''');
    print("Goals table created");
  }

  // Insert a goal
  Future<int> insertGoal(Goal goal) async {
    final db = await database;
    return await db.insert('goals', goal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get all goals (with optional category filter)
  Future<List<Goal>> getGoals({String? category}) async {
    final db = await database;

    List<Map<String, dynamic>> maps;
    if (category != null) {
      // Fetch goals by category
      maps = await db.query(
        'goals',
        where: 'category = ?',
        whereArgs: [category],
      );
    } else {
      // Fetch all goals
      maps = await db.query('goals');
    }

    // Convert List<Map> to List<Goal>
    return List.generate(maps.length, (i) {
      return Goal.fromMap(maps[i]);
    });
  }

  // Update a goal
  Future<int> updateGoal(Goal goal) async {
    final db = await database;
    return await db.update(
      'goals',
      goal.toMap(),
      where: 'id = ?',
      whereArgs: [goal.id],
    );
  }

  // Delete a goal
  Future<int> deleteGoal(int id) async {
    final db = await database;
    return await db.delete(
      'goals',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
