import 'package:flutter/material.dart';
import 'package:flutter_thang/models/student.dart';
import 'package:flutter_thang/screens/add_student.dart';
import 'package:flutter_thang/screens/authenticate/sign_in.dart';
import 'package:flutter_thang/screens/edit_student.dart';
import 'package:flutter_thang/services/student.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  static const routeName = '/';
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _students = context.watch<StudentService>().students;

    void onStudentSelected(Student student) {
      Navigator.pushNamed(
        context,
        EditStudent.routeName,
        arguments: Student(
          id: student.id,
          fullName: student.fullName,
          gender: student.gender,
          phone: student.phone,
          address: student.address,
          dateOfBirth: student.dateOfBirth,
          email: student.email,
          department: student.department,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nguyen Duc Thang"),
        centerTitle: true,
        elevation: 0.0,
        actions: const [AppBarAction()],
      ),
      backgroundColor: Colors.green[50],
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 1.0,
              horizontal: 4.0,
            ),
            child: Card(
              child: ListTile(
                onTap: () {
                  onStudentSelected(_students[index]);
                },
                title: Text(_students[index].fullName ?? 'Unnamed'),
                subtitle: Text(context
                        .watch<StudentService>()
                        .students[index]
                        .department ??
                    "No department"),
                leading: const Icon(Icons.person),
                trailing: TileItemAction(
                  student: _students[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AppBarAction extends StatelessWidget {
  const AppBarAction({
    Key? key,
  }) : super(key: key);

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddStudent(),
          ),
        );
        break;
      case 1:
        context.read<StudentService>().getStudents();

        Fluttertoast.showToast(
          msg: "Data refreshed!", // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.BOTTOM, // location
          timeInSecForIosWeb: 3, // duration
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        break;
      case 2:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const SignIn(),
          ),
          (route) => false,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: (item) => onSelected(context, item),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: const [
              Icon(
                Icons.add_box_rounded,
                color: Colors.green,
              ),
              SizedBox(width: 8.0),
              Text('Add student')
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: const [
              Icon(
                Icons.logout,
                color: Colors.green,
              ),
              SizedBox(width: 8.0),
              Text('Refresh')
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: const [
              Icon(
                Icons.logout,
                color: Colors.green,
              ),
              SizedBox(width: 8.0),
              Text('Sign Out')
            ],
          ),
        ),
      ],
    );
  }
}

class TileItemAction extends StatelessWidget {
  final Student student;
  const TileItemAction({
    Key? key,
    required this.student,
  }) : super(key: key);

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _sendMail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
      query:
          'subject=Mail Subject&body=Mail from Nguyen Duc Thang', //add subject and body here
    );

    await launchUrl(launchUri);
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        if (student.phone != null) {
          _makePhoneCall(student.phone!);
        } else {
          print('can not make phone call');
        }
        break;
      case 1:
        if (student.email != null) {
          _sendMail(student.email!);
        } else {
          print('can not send mail');
        }

        break;
      case 2:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Delete student'),
                content:
                    const Text('Are you sure you want to delete this student?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<StudentService>().deleteStudent(student.id);
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                        msg: "Delete student successfully.", // message
                        toastLength: Toast.LENGTH_SHORT, // length
                        gravity: ToastGravity.BOTTOM, // location
                        timeInSecForIosWeb: 3, // duration
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                      );
                    },
                    child: const Text('Yes'),
                  ),
                ],
              );
            });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.settings),
      onSelected: (item) => onSelected(context, item),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: const [
              Icon(
                Icons.phone,
                color: Colors.green,
              ),
              SizedBox(width: 8.0),
              Text('Call')
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: const [
              Icon(
                Icons.mail,
                color: Colors.green,
              ),
              SizedBox(width: 8.0),
              Text('Mail')
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: const [
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
              SizedBox(width: 8.0),
              Text('Delete')
            ],
          ),
        ),
      ],
    );
  }
}
