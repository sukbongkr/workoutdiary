import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'package:workoutdiary/model/model.dart'; // jsonEncode, jsonDecode 사용을 위해

class DatabaseHelper {
  static const _databaseName = "db.db";
  static const _databaseVersion = 1;

  static const tableExercise = 'exercise';
  static const tableRoutine = 'routine';
  static const tableWorkout = 'workout';
  static const tableWorkoutDetail = 'workout_detail';

  // Singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableRoutine (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      exerciseIds TEXT NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE $tableWorkout (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      startDate TEXT NOT NULL,
      endDate TEXT NOT NULL,
      detailIds TEXT NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE $tableWorkoutDetail (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      exerciseId INTEGER NOT NULL,
      timestamp TEXT NOT NULL,
      reps INTEGER NOT NULL,
      weight REAL NOT NULL,
      duration INTEGER NOT NULL
    )
  ''');
  }

// CRUD methods for Routine
  Future<int> insertRoutine(Routine routine) async {
    Database db = await database;
    try {
      return await db.insert(tableRoutine, routine.toMap());
    } catch (e) {
      print("Error inserting routine: $e");
      return -1;
    }
  }

  Future<Routine?> getRoutine(int id) async {
    Database db = await database;
    try {
      List<Map> maps =
          await db.query(tableRoutine, where: 'id = ?', whereArgs: [id]);
      if (maps.isNotEmpty) {
        Map<String, dynamic> map = Map<String, dynamic>.from(maps.first);
        return Routine.fromMap(map);
      }
    } catch (e) {
      print("Error getting routine: $e");
    }
    return null;
  }

  Future<int> updateRoutine(Routine routine) async {
    Database db = await database;
    try {
      return await db.update(
        tableRoutine,
        routine.toMap(),
        where: 'id = ?',
        whereArgs: [routine.id],
      );
    } catch (e) {
      print("Error updating routine: $e");
      return -1;
    }
  }

  Future<void> deleteRoutine(int id) async {
    Database db = await database;
    try {
      await db.delete(
        tableRoutine,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print("Error deleting routine: $e");
    }
  }

  // CRUD methods for Workout
  Future<int> insertWorkout(Workout workout) async {
    Database db = await database;
    try {
      return await db.insert(tableWorkout, workout.toMap());
    } catch (e) {
      print("Error inserting workout: $e");
      return -1;
    }
  }

  Future<Workout?> getWorkout(int id) async {
    Database db = await database;
    try {
      List<Map> maps =
          await db.query(tableWorkout, where: 'id = ?', whereArgs: [id]);
      if (maps.isNotEmpty) {
        Map<String, dynamic> map = Map<String, dynamic>.from(maps.first);
        return Workout.fromMap(map);
      }
    } catch (e) {
      print("Error getting workout: $e");
    }
    return null;
  }

  Future<int> updateWorkout(Workout workout) async {
    Database db = await database;
    try {
      return await db.update(
        tableWorkout,
        workout.toMap(),
        where: 'id = ?',
        whereArgs: [workout.id],
      );
    } catch (e) {
      print("Error updating workout: $e");
      return -1;
    }
  }

  Future<void> deleteWorkout(int id) async {
    Database db = await database;
    try {
      await db.delete(
        tableWorkout,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print("Error deleting workout: $e");
    }
  }

  // CRUD methods for WorkoutDetail
  Future<int> insertWorkoutDetail(WorkoutDetail workoutDetail) async {
    Database db = await database;
    try {
      return await db.insert(tableWorkoutDetail, workoutDetail.toMap());
    } catch (e) {
      print("Error inserting workout detail: $e");
      return -1;
    }
  }

  Future<WorkoutDetail?> getWorkoutDetail(int id) async {
    Database db = await database;
    try {
      List<Map> maps =
          await db.query(tableWorkoutDetail, where: 'id = ?', whereArgs: [id]);
      if (maps.isNotEmpty) {
        Map<String, dynamic> map = Map<String, dynamic>.from(maps.first);
        return WorkoutDetail.fromMap(map);
      }
    } catch (e) {
      print("Error getting workout detail: $e");
    }
    return null;
  }

  Future<int> updateWorkoutDetail(WorkoutDetail workoutDetail) async {
    Database db = await database;
    try {
      return await db.update(
        tableWorkoutDetail,
        workoutDetail.toMap(),
        where: 'id = ?',
        whereArgs: [workoutDetail.id],
      );
    } catch (e) {
      print("Error updating workout detail: $e");
      return -1;
    }
  }

  Future<void> deleteWorkoutDetail(int id) async {
    Database db = await database;
    try {
      await db.delete(
        tableWorkoutDetail,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print("Error deleting workout detail: $e");
    }
  }
}
