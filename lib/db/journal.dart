import 'package:flutter/services.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// https://flutter.dev/docs/cookbook/persistence/sqlite
class Journal {
  static const tableName = "journal_entries";
  late final Future<Database> database;

  //https://stackoverflow.com/questions/12649573/how-do-you-build-a-singleton-in-dart
  static final Journal _singleton = Journal._internal();

  Journal._internal();

  factory Journal() {
    return _singleton;
  }

  Future<void> initializeDatabase() async {
    String path = await getDatabasesPath();
    String build = await rootBundle.loadString('assets/create_table.txt');
    database = openDatabase(
      join(path, 'journal.sqlite3.db'),
      onCreate: (db, version) {
        return db.execute(build);
      },
      version: 1
    );
  }

  Future<List<JournalEntry>> journalEntries() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return maps.map<JournalEntry>((entry) {
      return JournalEntry.fromMap(entry);
    }).toList();
  }

  Future<JournalEntry> getJournalEntry(int id) async {
    final db = await database;

    return JournalEntry.fromMap((await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id]
    ))[0]);
  }

  Future<void> insertJournalEntry(JournalEntry entry) async {
    final db = await database;

    await db.insert(
      tableName,
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateJournalEntry(JournalEntry entry) async {
    final db = await database;

    await db.update(
      tableName,
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  Future<void> deleteJournalEntry(JournalEntry entry) async {
    final db = await database;

    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }
  
  Future<void> dropTable() async {
    final db = await database;
    String drop = await rootBundle.loadString('assets/drop_table.txt');
    print(drop);
    await db.execute(drop);
  }
}