import 'package:flutter/services.dart';
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
      return JournalEntry(
          entry['id'],
          entry['title'],
          entry['body'],
          entry['rating'],
          DateTime.parse(entry['date'])
      );
    }).toList();
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
}

class JournalEntry {
  int? id;
  String title;
  String body;
  int rating;
  DateTime date;

  JournalEntry (this.id, this.title, this.body, this.rating, this.date);

  JournalEntry.empty () :
    title = '',
    body = '',
    rating = 0,
    date = DateTime.fromMicrosecondsSinceEpoch(0);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'title': title,
      'body': body,
      'rating': rating,
      'date': date.toString(),
    };
    if(id != null) map['id'] = id;
    return map;
  }

  @override
  String toString() {
    return 'JournalEntry{id: $id, title: $title, rating: $rating, date: $date,'
        'body:\n$body}';
  }
}