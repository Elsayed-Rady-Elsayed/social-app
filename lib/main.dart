import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/consts.dart';
import 'package:socialapp/controller/cashHelper/cashHelper.dart';
import 'package:socialapp/view/screens/Home/HomeLayout.dart';
import 'package:socialapp/view/screens/auth/firstScreen.dart';
import 'package:socialapp/view/screens/auth/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CashHelper.InitialStat();
  uid = CashHelper.GetData(key: 'uid');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme:const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        primarySwatch: Colors.blue,
      ),
      home:uid!=null ? HomeScreen() : FirstScreen(),
    );
  }
}
