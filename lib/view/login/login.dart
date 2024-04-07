import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:omran/core/widgets/navigation.dart';

import '../../core/local/cache_helper.dart';
import '../chose/chose.dart';
import '../sick/sick.dart';
import '../sicksupervisor/sick_supervisor.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogIn();
}

class _LogIn extends State<LogIn> {


  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;
  String? isLogin;

  Future<void> authenticateWithBiometrics(context) async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
      });
      authenticated = await auth.authenticate(
        localizedReason:
        'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _isAuthenticating = false;
      });
      return;
    }
    if (authenticated) {
      if(isLogin=='sick'){
        navigateAndFinish(context, const Sick());
      }else if(isLogin=='SickSupervisor'){
        navigateAndFinish(context, const SickSupervisor());
      }else{
        navigateAndFinish(context, const Choose());
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('فشلت عملية الدخول'),
        ),
      );
    }
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }
  @override
  void initState() {
    isLogin= CacheHelper.getData(key: 'onChoose')??'notLogIn';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              const Text('تسجيل الدخول بأستخدام\n بصمة الاصبع',textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              if (_isAuthenticating)
                ElevatedButton(
                  onPressed: _cancelAuthentication,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cancel),
                      Text('الغاء التسجيل'),
                    ],
                  ),
                )
              else
                Column(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                          return Colors.deepPurple;
                        }),
                      ),
                      onPressed: (){
                        authenticateWithBiometrics(context);
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.fingerprint,color: Colors.white,),
                          SizedBox(width: 5,),
                          Text('بصمة الاصبع',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
