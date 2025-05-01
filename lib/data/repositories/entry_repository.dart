
import 'package:fpa/core/db/database_helper.dart';
import 'package:fpa/data/models/entry_model.dart';
import 'package:sqflite/sqflite.dart';

class EntryRepository {
  final dbHelper = DatabaseHelper();

  // Insert Entry (Create)
  Future<int> insertEntry(Entry entry) async {
    try {
      final db = await dbHelper.database;
      return await db.insert(
        DatabaseHelper.tableEntries,
        entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting entry: $e');
      return -1;
    }
  }

  // Get All Entries (Read)
  Future<List<Entry>> getAllEntries() async {
    try {
      final db = await dbHelper.database;
      final result = await db.query(DatabaseHelper.tableEntries, orderBy: 'id DESC');
      return result.map((e) => Entry.fromMap(e)).toList();
    } catch (e) {
      print('Error fetching entries: $e');
      return [];
    }
  }

  // Get Entries with Pagination
  Future<List<Entry>> getEntriesPaged({required int offset, required int limit}) async {
    print('EntryRepository: Fetching entries from local DB...');
    try {
      final db = await dbHelper.database;
      final result = await db.query(
        DatabaseHelper.tableEntries,
        orderBy: 'id DESC',
        limit: limit,
        offset: offset,
      );
      return result.map((e) => Entry.fromMap(e)).toList();
    } catch (e) {
      print('Error fetching paged entries: $e');
      return [];
    }
  }


  // Get Entry by ID (Read)
  Future<Entry?> getEntryById(int id) async {
    try {
      final db = await dbHelper.database;
      final result = await db.query(
        DatabaseHelper.tableEntries,
        where: '${DatabaseHelper.columnId} = ?',
        whereArgs: [id],
      );
      return result.isNotEmpty ? Entry.fromMap(result.first) : null;
    } catch (e) {
      print('Error fetching entry by ID: $e');
      return null;
    }
  }

  // Update Entry (Update)
  Future<int> updateEntry(Entry entry) async {
    try {
      final db = await dbHelper.database;
      return await db.update(
        DatabaseHelper.tableEntries,
        entry.toMap(),
        where: '${DatabaseHelper.columnId} = ?',
        whereArgs: [entry.id],
      );
    } catch (e) {
      print('Error updating entry: $e');
      return -1;
    }
  }

  // Delete Entry (Delete)
  Future<int> deleteEntry(int id) async {
    try {
      final db = await dbHelper.database;
      return await db.delete(
        DatabaseHelper.tableEntries,
        where: '${DatabaseHelper.columnId} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting entry: $e');
      return -1;
    }
  }

  // Clear All Entries (Optional)
  Future<void> clearAllEntries() async {
    try {
      final db = await dbHelper.database;
      await db.delete(DatabaseHelper.tableEntries);
      print('All entries cleared');
    } catch (e) {
      print('Error clearing entries: $e');
    }
  }
}
