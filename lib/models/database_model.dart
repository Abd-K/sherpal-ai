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
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
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
        category TEXT,
        goalType TEXT,
        measurementType TEXT,
        targetValue TEXT,
        currentValue TEXT,
        parentId INTEGER,
        isCompleted INTEGER DEFAULT 0,
        bestValue TEXT
      )
    ''');
    print("Goals table created");
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add new columns for goal types, measurements, and objectives
      await db.execute('ALTER TABLE goals ADD COLUMN goalType TEXT');
      await db.execute('ALTER TABLE goals ADD COLUMN measurementType TEXT');
      await db.execute('ALTER TABLE goals ADD COLUMN targetValue TEXT');
      await db.execute('ALTER TABLE goals ADD COLUMN currentValue TEXT');
      await db.execute('ALTER TABLE goals ADD COLUMN parentId INTEGER');
      await db.execute('ALTER TABLE goals ADD COLUMN isCompleted INTEGER DEFAULT 0');
      await db.execute('ALTER TABLE goals ADD COLUMN bestValue TEXT');
      print("Goals table upgraded to version 2");
    }
  }

  // Goal types constants
  static const String goalTypeWork = 'work';
  static const String goalTypeFitness = 'fitness';
  static const String goalTypeGeneral = 'general';

  // Measurement types constants
  static const String measurementTypeTime = 'time';
  static const String measurementTypeCheckbox = 'checkbox';
  static const String measurementTypeReps = 'reps';
  static const String measurementTypeWeight = 'weight';
  static const String measurementTypeDistance = 'distance';

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
        where: 'category = ? AND parentId IS NULL',
        whereArgs: [category],
      );
    } else {
      // Fetch all top-level goals (not objectives)
      maps = await db.query(
        'goals',
        where: 'parentId IS NULL',
      );
    }
    // Convert List<Map> to List<Goal>
    return List.generate(maps.length, (i) {
      return Goal.fromMap(maps[i]);
    });
  }

  // Get objectives for a specific goal
  Future<List<Goal>> getObjectives(int parentId) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'goals',
      where: 'parentId = ?',
      whereArgs: [parentId],
    );
    // Convert List<Map> to List<Goal>
    return List.generate(maps.length, (i) {
      return Goal.fromMap(maps[i]);
    });
  }

  // Get a specific goal by ID
  Future<Goal?> getGoal(int id) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'goals',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return Goal.fromMap(maps.first);
    }
    return null;
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
    // First delete all objectives of this goal
    await db.delete(
      'goals',
      where: 'parentId = ?',
      whereArgs: [id],
    );
    // Then delete the goal itself
    return await db.delete(
      'goals',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Get goals for this week
  Future<List<Goal>> getThisWeekGoals() async {
    final db = await database;
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    
    final startDate = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day).toIso8601String();
    final endDate = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59).toIso8601String();
    
    List<Map<String, dynamic>> maps = await db.query(
      'goals',
      where: 'deadline BETWEEN ? AND ? AND parentId IS NULL',
      whereArgs: [startDate, endDate],
    );
    
    return List.generate(maps.length, (i) {
      return Goal.fromMap(maps[i]);
    });
  }

  // Get Sherpal goals (predefined goals)
  Future<List<Goal>> getSherpalGoals() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'goals',
      where: 'category = ? AND parentId IS NULL',
      whereArgs: ['sherpal'],
    );
    
    return List.generate(maps.length, (i) {
      return Goal.fromMap(maps[i]);
    });
  }

  // Update goal progress
  Future<int> updateGoalProgress(int id, String currentValue) async {
    final db = await database;
    return await db.update(
      'goals',
      {'currentValue': currentValue, 'lastUpdated': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Update best value
  Future<int> updateBestValue(int id, String bestValue) async {
    final db = await database;
    return await db.update(
      'goals',
      {'bestValue': bestValue},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Mark goal as completed
  Future<int> markGoalCompleted(int id, bool isCompleted) async {
    final db = await database;
    return await db.update(
      'goals',
      {'isCompleted': isCompleted ? 1 : 0, 'lastUpdated': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
