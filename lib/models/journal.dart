import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// https://flutter.dev/docs/cookbook/persistence/sqlite
class Journal {
  static const tableName = "journal_entries";
  late final Future<Database> database;

  Journal() {
    initializeDatabase();
  }

  void initializeDatabase() async {
    database = openDatabase(
        join(await getDatabasesPath(), 'journal.sqlite3.db'),
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE IF NOT EXISTS$tableName(id INTEGER PRIMARY KEY '
                  'AUTOINCREMENT, title TEXT NOT NULL, body TEXT NOT NULL, '
                  'rating INT NOT NULL, date TEXT NOT NULL'
          );
        },
        version: 1
    );
  }

  Future<List<JournalEntry>> journalEntries() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (index) {
      return JournalEntry(
          maps[index]['id'],
          maps[index]['title'],
          maps[index]['body'],
          maps[index]['rating'],
          maps[index]['date']
      );
    });
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
  int id;
  String title;
  String body;
  int rating;
  DateTime date;

  JournalEntry (this.id, this.title, this.body, this.rating, this.date);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'rating': rating,
      'date': date,
    };
  }

  @override
  String toString() {
    return 'JournalEntry{id: $id, title: $title, rating: $rating, date: $date,'
        'body:\n$body}';
  }
}