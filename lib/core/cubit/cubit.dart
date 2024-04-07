import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omran/core/cubit/states.dart';
import 'package:omran/core/widgets/snack_bar.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  void showNotification(v, flp) async {
    var android = const AndroidNotificationDetails(
      '0',
      'ذكرني',
      priority: Priority.high,
      importance: Importance.max,
    );
    var platform = NotificationDetails(android: android);
    await flp.show(0, 'ذكرني', '$v', platform, payload: 'VIS \n $v');
  }

  void callbackDispatcher(massege) {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSetttings = InitializationSettings(android: android);
    flp.initialize(initSetttings);
    showNotification(massege, flp);
  }

  bool ready = false;
  Database? database;
  List<Map> newTasks = [];

  void createDatabase() {
    openDatabase(
      'azza.db',
      version: 1,
      onCreate: (database, version) {
        print('///////////////////////////// ');
        print('Database created');
        database.execute('''
        CREATE TABLE tabb (
          id INTEGER PRIMARY KEY,
          name TEXT,
          type TEXT,
          dosageAmount TEXT,
          doseTime TEXT,
          numberDoses TEXT,
          image TEXT
        )
      ''').then((value) {
          print('///////////////////////////// ');
          print('Table created');
        }).catchError((error) {
          print('///////////////////////////// ');
          print('Error when creating table: $error');
        });
      },
      onOpen: (database) {
        print('///////////////////////////// ');
        print('Database opened');
      },
    ).then((value) async {
      database = value;
      await getDataFromDatabase(database);
      emit(AppCreateDatabaseState());
    });
    ready = true;
  }

  Future<void> getDataFromDatabase(database) async {
    emit(AppGetDatabaseLoadingState());
    final List<Map<dynamic, dynamic>> fetchedData =
        await database!.rawQuery('SELECT * FROM tabb');
    newTasks = fetchedData;
    emit(AppGetDatabaseState());
  }

  List<Map<dynamic, dynamic>> searchByName(String name) {
    List<Map<dynamic, dynamic>> results = [];
    for (var task in newTasks) {
      if (task['name'] == name) {
        results.add(task);
      }
    }
    return results;
  }

  emitt() {
    emit(emitNoThink());
  }

  Future<XFile?> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  insertToDatabase({
    required BuildContext context,
    required String name,
    required String type,
    required String dosageAmount,
    required String doseTime,
    required String numberDoses,
    required String imagePath,
  }) async {
    await database?.transaction((txn) {
      txn
          .rawInsert(
        'INSERT INTO tabb ( name ,  type , dosageAmount , doseTime , numberDoses ,image ) '
        'VALUES("$name", "$type", "$dosageAmount", "$doseTime", "$numberDoses", "$imagePath" )',
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        showSnackBar(context, 'لم تتم عملية التخزين بنجاح قم بأعادة المحاولة',
            Colors.red);

        print('Error When Inserting New Record ${error.toString()}');
      });

      return Future.value();
    });
  }

  void updateData({
    required BuildContext context,
    required int id,
    required String name,
    required String type,
    required String dosageAmount,
    required String doseTime,
    required String numberDoses,
    required String imagePath,
  }) async {
    final updateStatement = '''
    UPDATE tabb
    SET name = '$name',
        dosageAmount = '$dosageAmount',
        doseTime = '$doseTime',
        type = '$type',
        numberDoses = '$numberDoses',
        image = '$imagePath'
    WHERE id = $id
  ''';

    database?.transaction((txn) async {
      await txn.rawUpdate(updateStatement).then((value) {
        emit(AppUpdateDatabaseState());
        getDataFromDatabase(database);
      }).catchError((e) {
        showSnackBar(context, 'لم تتم عملية التخزين بنجاح قم بأعادة المحاولة',
            Colors.red);
        print('Error When Updating Record: ${e.toString()}');
      });
    });
  }

  void deleteData({
    required String id,
  }) async {
    database!.rawDelete('DELETE FROM tabb WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void deleteAllData([emitSignal = true]) async {
    database!.rawDelete('DELETE FROM tabb').then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    }).catchError((e) {
      print(e.toString());
    });
  }

  /////////////////////////////////////////////////////////////////////////////
  Database? database2;
  List<Map> newTasks2 = [];
  bool ready2 = false;

  void createDatabase2() {
    openDatabase(
      'personname.db',
      version: 1,
      onCreate: (database, version) {
        print('///////////////////////////// ');
        print('Database created');
        database.execute('''
        CREATE TABLE personnametable (
          id INTEGER PRIMARY KEY,
          name TEXT,
          phone TEXT,
          phoneSupervisor TEXT,
          nameSupervisor TEXT,
          age TEXT,
          location TEXT,
          image TEXT
        )
      ''').then((value) {
          print('///////////////////////////// ');
          print('Table created');
        }).catchError((error) {
          print('///////////////////////////// ');
          print('Error when creating table: $error');
        });
      },
      onOpen: (database) {
        print('///////////////////////////// ');
        print('Database opened');
      },
    ).then((value) async {
      database2 = value;
      await getDataFromDatabase2(database2);
      emit(AppCreateDatabaseState());
    });
    ready2 = true;
  }

  Future<void> getDataFromDatabase2(Database? database2) async {
    emit(AppGetDatabaseLoadingState());
    final List<Map<dynamic, dynamic>> fetchedData =
        await database2!.rawQuery('SELECT * FROM personnametable');
    newTasks2 = fetchedData;
    emit(AppGetDatabaseState());
  }

  insertToDatabase2({
    required BuildContext context,
    required String name,
    required String nameSupervisor,
    required String location,
    required String age,
    required String phone,
    required String phoneSupervisor,
    required String imagePath,
  }) async {
    await database2?.transaction((txn) {
      txn
          .rawInsert(
        'INSERT INTO personnametable ( name , phone , nameSupervisor , phoneSupervisor , age , location ,image ) '
        'VALUES("$name", "$phone", "$nameSupervisor", "$phoneSupervisor", "$age", "$location", "$imagePath" )',
      )
          .then((value) {
        emit(AppInsertDatabaseState());
        getDataFromDatabase2(database2);
      }).catchError((error) {
        showSnackBar(context, 'لم تتم عملية التخزين بنجاح قم بأعادة المحاولة',
            Colors.red);
        print('Error When Inserting New Record ${error.toString()}');
      });
      return Future.value();
    });
  }

  void deleteData2({
    required String id,
  }) async {
    database2!.rawDelete('DELETE FROM personnametable WHERE id = ?', [id]).then(
        (value) {
      getDataFromDatabase2(database2);
      emit(AppDeleteDatabaseState());
    });
  }

  void deleteAllData2([emitSignal = true]) async {
    database2!.rawDelete('DELETE FROM personnametable').then((value) {
      getDataFromDatabase2(database2);
      emit(AppDeleteDatabaseState());
    }).catchError((e) {
      print(e.toString());
    });
  }

  Database? database3;
  List<Map> newTasks3 = [];
  bool ready3 = false;

  void createDatabase3({required int id}) {
    openDatabase(
      'personname$id.db',
      version: 1,
      onCreate: (database, version) {
        print('///////////////////////////// ');
        print('Database created');
        database.execute('''
        CREATE TABLE personnametablesick$id (
          id INTEGER PRIMARY KEY,
          name TEXT,
          type TEXT,
          dosageAmount TEXT,
          doseTime TEXT,
          numberDoses TEXT,
          image TEXT
        )
      ''').then((value) {
          print('///////////////////////////// ');
          print('Table created');
        }).catchError((error) {
          print('///////////////////////////// ');
          print('Error when creating table: $error');
        });
      },
      onOpen: (database) {
        print('///////////////////////////// ');
        print('Database opened');
      },
    ).then((value) async {
      database3 = value;
      await getDataFromDatabase3(database3, id);
      emit(AppCreateDatabaseState());
    });
    ready3 = true;
  }

  Future<void> getDataFromDatabase3(Database? database3, int id) async {
    emit(AppGetDatabaseLoadingState());
    final List<Map<dynamic, dynamic>> fetchedData =
        await database3!.rawQuery('SELECT * FROM personnametablesick$id');
    newTasks3 = fetchedData;
    emit(AppGetDatabaseState());
  }

  insertToDatabase3({
    required BuildContext context,
    required String name,
    required String type,
    required String dosageAmount,
    required String doseTime,
    required String numberDoses,
    required String imagePath,
    required int id,
  }) async {
    await database3?.transaction((txn) {
      print('sss');

      txn
          .rawInsert(
        'INSERT INTO personnametablesick$id ( name , type , dosageAmount , doseTime , numberDoses ,image ) '
        'VALUES("$name", "$type" , "$dosageAmount", "$doseTime", "$numberDoses", "$imagePath" )',
      )
          .then((value) {
        emit(AppInsertDatabaseState());
        getDataFromDatabase3(database3, id);
      }).catchError((error) {
        showSnackBar(context, 'لم تتم عملية التخزين بنجاح قم بأعادة المحاولة',
            Colors.red);
        print('Error When Inserting New Record ${error.toString()}');
      });
      return Future.value();
    });
  }

  void deleteData3({
    required int id,
  }) async {
    database3!.rawDelete(
        'DELETE FROM personnametablesick$id WHERE id = ?', [id]).then((value) {
      getDataFromDatabase3(database3, id);
      emit(AppDeleteDatabaseState());
    });
  }

  void deleteAllData3([emitSignal = true, int? id]) async {
    database3!.rawDelete('DELETE FROM personnametablesick$id').then((value) {
      getDataFromDatabase3(database3, id!);
      emit(AppDeleteDatabaseState());
    }).catchError((e) {
      print(e.toString());
    });
  }
}
