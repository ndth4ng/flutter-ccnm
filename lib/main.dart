import 'package:flutter/material.dart';
import 'package:flutter_thang/screens/add_student.dart';
import 'package:flutter_thang/screens/authenticate/sign_in.dart';
import 'package:flutter_thang/screens/authenticate/sign_up.dart';
import 'package:flutter_thang/screens/edit_student.dart';
import 'package:flutter_thang/screens/loading/loading.dart';
import 'package:flutter_thang/services/student.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<StudentService>(
        create: (_) => StudentService(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: Loading.routeName,
        routes: {
          Loading.routeName: (context) => const Loading(),
          SignUp.routeName: (context) => const SignUp(),
          SignIn.routeName: (context) => const SignIn(),
          AddStudent.routeName: (context) => const AddStudent(),
          EditStudent.routeName: (context) => const EditStudent(),
        });
  }
}
