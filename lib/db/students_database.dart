import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_sqlite_app/models/program.dart';
import 'package:student_sqlite_app/models/student.dart';

class StudentsDatabase {
  static final StudentsDatabase instance = StudentsDatabase._init();

  static Database? _database;

  StudentsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('students.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const intType = 'INT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableStudents (
      ${StudentsFields.id} $idType,
      ${StudentsFields.code} $textType,
      ${StudentsFields.name} $textType,
      ${StudentsFields.program} $textType,
      ${StudentsFields.status} $boolType
    )
    ''');

    await db.execute('''
    CREATE TABLE $tableProgram (
      ${ProgramsFields.id} $idType,
      ${ProgramsFields.code} $textType,
      ${ProgramsFields.name} $textType,
      ${ProgramsFields.status} $boolType
    )
    ''');
  }

  Future<void> close() async {
    final db = await instance.database;

    db.close();
  }

  Future<Student> createStudent(Student student) async {
    final db = await instance.database;

    final id = await db.insert(tableStudents, student.toJson());

    return student.copy(id: id);
  }

  Future<Student?> findBydIdStudent(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableStudents,
        columns: StudentsFields.values,
        where: '${StudentsFields.id} = ?',
        whereArgs: [id]);

    if (maps.isEmpty) return null;

    return Student.fromJson(maps.first);
  }

  Future<List<Student>> findAllStudent() async {
    final db = await instance.database;

    final result = await db.query(tableStudents);

    return result.map((json) => Student.fromJson(json)).toList();
  }

  Future<int> updateStudent(Student student) async {
    final db = await instance.database;

    return db.update(tableStudents, student.toJson(),
        where: '${StudentsFields.id} = ?', whereArgs: [student.id]);
  }

  Future<int> deleteStudent(int id) async {
    final db = await instance.database;

    return await db.delete(tableStudents,
        where: '${StudentsFields.id} = ?', whereArgs: [id]);
  }

  Future<Program> createProgram(Program program) async {
    final db = await instance.database;

    final id = await db.insert(tableProgram, program.toJson());

    return program.copy(id: id);
  }

  Future<Program?> findBydIdProgram(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableProgram,
        columns: ProgramsFields.values,
        where: '${ProgramsFields.id} = ?',
        whereArgs: [id]);

    if (maps.isEmpty) return null;

    return Program.fromJson(maps.first);
  }

  Future<List<Program>> findAllProgram() async {
    final db = await instance.database;

    final result = await db.query(tableProgram);

    return result.map((json) => Program.fromJson(json)).toList();
  }

  Future<int> updateProgram(Program program) async {
    final db = await instance.database;

    return db.update(tableProgram, program.toJson(),
        where: '${ProgramsFields.id} = ?', whereArgs: [program.id]);
  }

  Future<int> deleteProgram(int id) async {
    final db = await instance.database;

    return await db.delete(tableProgram,
        where: '${ProgramsFields.id} = ?', whereArgs: [id]);
  }
}
