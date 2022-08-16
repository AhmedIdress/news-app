import 'package:news/article_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  late Database database;
  DataBaseHelper._() {
    openDataBase();
  }
  static DataBaseHelper instance = DataBaseHelper._();
  Future<void> openDataBase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'news_db.db');
    print('open');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE News ('
          'sourceId TEXT,sourceName TEXT,'
          'author TEXT,title TEXT,'
          'description TEXT,url TEXT,urlToImage TEXT,'
          'publishedAt TEXT,content TEXT)');
      print('created');
    });
    //database = db;
  }

  Future<void> insert(ArticleModel model) async {
    print('here insert');
    await database.transaction((txn) async {
      int id2 = await txn.rawInsert(
        'INSERT OR REPLACE INTO News(sourceId, sourceName, author,title,description,url,urlToImage,publishedAt,content) '
        'VALUES(?, ?, ?,?, ?, ?,?, ?, ?)',
        [
          model.source?.id,
          model.source?.name,
          model.author,
          model.title,
          model.description,
          model.url,
          model.urlToImage,
          model.publishedAt,
          model.content,
        ],
      );
      print('inserted2: $id2');
    });
  }

  Future<List<ArticleModel>> get() async {
    //print('last here');
    List<Map<String, dynamic>> list =
        await database.rawQuery('SELECT * FROM News');
    //print(list);
    if(list.isNotEmpty) {
      List<ArticleModel> news =
      list.map((e) => ArticleModel.fromJson(e)).toList();
      return news;
    }
    return [];
  }
}
