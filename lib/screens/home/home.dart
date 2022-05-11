import 'package:flutter/material.dart';
import 'package:flutter_thang/models/student.dart';
import 'package:flutter_thang/screens/add_student.dart';
import 'package:flutter_thang/screens/authenticate/sign_in.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _students = Provider.of<List<Student>?>(context);

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
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const SignIn(),
            ),
            (route) => false,
          );
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("List"),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          PopupMenuButton<int>(
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
              const PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 1,
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
          )
        ],
      ),
      backgroundColor: Colors.green[50],
      body: _students == null
          ? const Text('loading')
          : ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 1.0,
                    horizontal: 4.0,
                  ),
                  child: Card(
                    child: ListTile(
                      onTap: () {},
                      title: Text(_students[index].fullName ?? 'Unnamed'),
                      subtitle:
                          Text(_students[index].department ?? "No department"),
                      leading: const Icon(Icons.person),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
