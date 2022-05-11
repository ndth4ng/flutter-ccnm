import 'package:flutter/material.dart';
import 'package:flutter_thang/models/student.dart';
import 'package:flutter_thang/screens/authenticate/sign_in.dart';
import 'package:flutter_thang/screens/authenticate/sign_up.dart';
import 'package:flutter_thang/screens/home/home.dart';
import 'package:flutter_thang/screens/loading/loading.dart';
import 'package:flutter_thang/services/student.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<StudentService>(
        create: (_) => StudentService(),
      ),
      FutureProvider<List<Student>?>(
        create: (_) => StudentService().getStudents(),
        initialData: null,
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
        initialRoute: '/',
        routes: {
          '/': (context) => const Loading(),
          '/home': (context) => const Home(),
          '/sign-up': (context) => const SignUp(),
          '/sign-in': (context) => const SignIn(),
        });
  }
}
