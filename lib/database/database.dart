import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/baby.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('babies.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE babies ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT,
        birthdate TEXT,
        gender TEXT,
        weight TEXT,
        height TEXT,
        headCircumference TEXT,
        chestCircumference TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE moms ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        bottlemilk INTEGER,
        startdate TEXT,
        expdate TEXT,
        typefreze TEXT
      )
    ''');
  }

  Future<Mom> insertMom(Mom mom) async {
    final db = await instance.database;
    final id = await db.insert('moms', mom.toMap());
    return mom.copy(id: id);
  }

  //update
  Future<int> updateMom(Mom mom) async {
    final db = await instance.database;

    return db.update(
      'moms',
      mom.toMap(),
      where: 'id = ?',
      whereArgs: [mom.id],
    );
  }
  //getAllMoms

  Future<List<Mom>> getAllMoms() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('moms');

    if (maps.isNotEmpty) {
      return maps.map((map) => Mom.fromMap(map)).toList();
    } else {
      return [];
    }
  }

  Future<Baby> insertBaby(Baby baby) async {
    final db = await instance.database;
    final id = await db.insert('babies', baby.toMap());
    return baby.copy(id: id);
  }

  Future<List<Baby>> getAllBabies() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('babies');

    if (maps.isNotEmpty) {
      return maps.map((map) => Baby.fromMap(map)).toList();
    } else {
      return [];
    }
  }

  Future<List<Baby>> getAllBabies2() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT id,name,birthdate FROM babies WHERE id IN (SELECT MIN(id) FROM babies GROUP BY name)');

    if (maps.isNotEmpty) {
      return maps.map((map) => Baby.fromMap(map)).toList();
    } else {
      return [];
    }
  }

  Future<List<Baby>> getAllBabies3() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT id,weight,height FROM babies WHERE id IN (SELECT MAX(id) FROM babies GROUP BY name)');

    if (maps.isNotEmpty) {
      return maps.map((map) => Baby.fromMap(map)).toList();
    } else {
      return [];
    }
  }

  //get data babies by same name and order by id to make graph weight and height
  Future<List<Baby>> getAllBabies5(String name) async {
    final db = await instance.database;
    //แสดงข้อมลตามชื่อเด็กที่เรียก และเรียงตาม id จากมากไปน้อย
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM babies WHERE name = ? ORDER BY id DESC', [name]);

    if (maps.isNotEmpty) {
      return maps.map((map) => Baby.fromMap(map)).toList();
    } else {
      return [];
    }
  }

  //get data babies by same name and order by id
  Future<List<Baby>> getAllBabies4(String name) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM babies WHERE name = ? ORDER BY id DESC', [name]);

    if (maps.isNotEmpty) {
      return maps.map((map) => Baby.fromMap(map)).toList();
    } else {
      return [];
    }
  }

  //add delete baby
  Future<int> deleteBaby(String name) async {
    final db = await instance.database;

    return await db.delete(
      'babies',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  //add  namebaby weight and height and date
  Future<Baby> insertBabywh(Baby baby) async {
    final db = await instance.database;
    final id = await db.insert('babieswh', baby.toMap());
    return baby.copy(id: id);
  }

  //for get all babieswh
  Future<List<Baby>> getAllBabieswh() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('babieswh');

    if (maps.isNotEmpty) {
      return maps.map((map) => Baby.fromMap(map)).toList();
    } else {
      return [];
    }
  }
}
