import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omran/view/login/login.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'bloc_observer.dart';
import 'core/cubit/cubit.dart';
import 'core/cubit/states.dart';
import 'core/local/cache_helper.dart';
import 'core/styles/themes.dart';

void showNotification( v, flp) async {
  var android = const AndroidNotificationDetails(
      '0',
      'ذكرني',
      priority: Priority.high,
      importance: Importance.max,
  );
  var platform = NotificationDetails(android: android);
  await flp.show(0, 'ذكرني', '$v', platform, payload: 'VIS \n $v');
}

void callbackDispatcher() {
  workmanager.executeTask((task, inputData) async {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSetttings = InitializationSettings(android: android);
    flp.initialize(initSetttings);
    showNotification('قم بالدخول للتطبيق لمراجعة اوقات العلاج', flp);
    return Future.value(true);
  });
}

Workmanager workmanager = Workmanager();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await workmanager.initialize(callbackDispatcher, isInDebugMode: false);
  await workmanager.registerPeriodicTask(
    "0",
    "قم بالدخول للتطبيق لمراجعة اوقات العلاج",
    frequency: const Duration(hours: 2),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'ذكرني',
            debugShowCheckedModeBanner: false,
            theme: ThemeService().lightTheme,
            themeMode: ThemeMode.light,
            home: const LogIn(),
          );
        },
      ),
    );
  }
}
