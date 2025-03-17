//This file will handle:
//1. Initializing the database
//2. Creating tables
//3. Database version management
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class DatabaseHelper {
  static Database? _database;

  // Database name and version
  static const String _dbName = 'fpa_track.db';
  static const int _dbVersion = 1;

  // Table name and columns
  static const String tableEntries = 'entries';
  static const String columnId = 'id';
  static const String columnCategory = 'category';
  static const String columnItem = 'item';
  static const String columnDate = 'date';
  static const String columnLocation = 'location';
  static const String columnPrice = 'price';

  // Singleton pattern to get the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    // If the database doesn't exist, open it
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, _dbName);
      return await openDatabase(
        path,
        version: _dbVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
    } catch (e) {
      print('Error initializing database: $e');
      rethrow;
    }
  }

  // Create Tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableEntries (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnCategory TEXT NOT NULL,
        $columnItem TEXT NOT NULL,
        $columnDate TEXT NOT NULL,
        $columnLocation TEXT,
        $columnPrice REAL NOT NULL
      )
    ''');
    print('Table $tableEntries created');
  }

  // Handle Database Version Upgrade
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Add migration queries here (for future updates)
      print('Database upgraded from $oldVersion to $newVersion');
    }
  }

  // Close Database
  Future<void> close() async {
    final db = await database;
    await db.close();
    print('Database closed');
  }
}