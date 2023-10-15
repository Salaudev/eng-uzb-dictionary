import 'package:eng_uzb_dictionary/api/db-helper.dart';
import 'package:eng_uzb_dictionary/models/word.dart';

class WordsDao {
  Future<List<Word>> getAllWords() async {
    final db = await DatabaseHelper.databaseAccess();

    final List<Map<String, dynamic>> maps = await db.query('dictionary');

    return List.generate(maps.length, (i) {
      return Word(
        id: maps[i]['id'],
        english: maps[i]['english'],
        type: maps[i]['type'],
        transcript: maps[i]['transcript'],
        uzbek: maps[i]['uzbek'],
        countable: maps[i]['countable'],
        is_favourite: maps[i]['is_favourite'],
        is_favourite_uzb: maps[i]['is_favourite_uzb'],
      );
    });
  }

  Future<List<Word>> searchWord(String searchWord) async {
    final db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM dictionary WHERE english like '%$searchWord%' or uzbek like '%$searchWord%'");

    return List.generate(maps.length, (i) {
      return Word(
        id: maps[i]['id'],
        english: maps[i]['english'],
        type: maps[i]['type'],
        transcript: maps[i]['transcript'],
        uzbek: maps[i]['uzbek'],
        countable: maps[i]['countable'],
        is_favourite: maps[i]['is_favourite'],
        is_favourite_uzb: maps[i]['is_favourite_uzb'],
      );
    });
  }

  Future<List<Word>> getSavedWords() async {
    final db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM dictionary WHERE is_favourite==1");

    return List.generate(maps.length, (i) {
      return Word(
        id: maps[i]['id'],
        english: maps[i]['english'],
        type: maps[i]['type'],
        transcript: maps[i]['transcript'],
        uzbek: maps[i]['uzbek'],
        countable: maps[i]['countable'],
        is_favourite: maps[i]['is_favourite'],
        is_favourite_uzb: maps[i]['is_favourite_uzb'],
      );
    });
  }

  Future<void> updateWord(Word word) async {
    // Get a reference to the database.
    final db = await DatabaseHelper.databaseAccess();

    // Update the given Dog.
    await db.update(
      'dictionary',
      word.toMap(),
      where: 'id = ?',
      whereArgs: [word.id],
    );
  }
}
