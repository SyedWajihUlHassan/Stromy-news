import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stromy/views/home.dart';
import 'package:stromy/views/login.dart';
// import 'package:localstore/localstore.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email') ?? "";
  var password = prefs.getString('password') ?? "";
  print(email);
runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: email == "admin@gmail.com" && password == "1234"
        "" ? Home() : Login()));
}

// class MyApp extends StatelessWidget {
//   final appTitle = 'StromyNews';
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'StromyNews',
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

