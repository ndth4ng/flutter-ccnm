import 'package:flutter/material.dart';
import 'package:flutter_thang/models/student.dart';
import 'package:flutter_thang/services/student.dart';
import 'package:flutter_thang/shared/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditStudent extends StatefulWidget {
  static const routeName = '/edit';
  const EditStudent({Key? key}) : super(key: key);

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  final _formKey = GlobalKey<FormState>();
  late Student student;

  TextEditingController fullName = TextEditingController();
  String? gender;
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController department = TextEditingController();

  List<String> genderEnum = ['Male', 'Female'];

  // Date picker
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      dateOfBirth.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentService = Provider.of<StudentService>(context);
    student = ModalRoute.of(context)?.settings.arguments as Student;

    fullName.text = student.fullName ?? '';
    gender =
        genderEnum.contains(student.gender.toString()) ? student.gender : null;
    dateOfBirth.text = student.dateOfBirth ?? '';
    phone.text = student.phone ?? '';
    address.text = student.address ?? '';
    email.text = student.email ?? '';
    department.text = student.department ?? '';

    void onEditStudent() async {
      await studentService.updateStudent(
          student.id,
          fullName.text,
          gender,
          dateOfBirth.text,
          phone.text,
          address.text,
          email.text,
          department.text);

      Fluttertoast.showToast(
        msg: "Update student successfully.", // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.BOTTOM, // location
        timeInSecForIosWeb: 3, // duration
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      Navigator.of(context).pop();
    }

    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text("Update Student"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: fullName,
                  validator: (String? val) {
                    if (val != null && val.isEmpty) {
                      return "Enter name";
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: "Full name",
                    hintText: "Enter name",
                    suffixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        onChanged: (value) => gender = value,
                        value: gender,
                        validator: (String? val) {
                          if (val == null || val.isEmpty) {
                            return "Select gender";
                          }
                          return null;
                        },
                        items: ['Male', 'Female'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: textInputDecoration.copyWith(
                          label: const Text("Gender"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: TextFormField(
                        controller: dateOfBirth,
                        onTap: () => _selectDate(context),
                        keyboardType: TextInputType.none,
                        readOnly: true,
                        decoration: textInputDecoration.copyWith(
                          label: const Text("Date of birth"),
                        ),
                        validator: (String? val) {
                          if (val == null || val.isEmpty) {
                            return "Select date of birth";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: phone,
                  validator: (String? val) {
                    if (val != null && val.isEmpty) {
                      return "Enter phone";
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: "Phone",
                    hintText: "Enter phone",
                    suffixIcon: const Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: address,
                  validator: (String? val) {
                    if (val != null && val.isEmpty) {
                      return "Enter address";
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: "Address",
                    hintText: "Enter address",
                    suffixIcon: const Icon(Icons.location_on),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: email,
                  validator: (String? val) {
                    if (val != null && val.isEmpty) {
                      return "Enter email";
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: "Email",
                    hintText: "Enter email",
                    suffixIcon: const Icon(Icons.mail),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: department,
                  validator: (String? val) {
                    if (val != null && val.isEmpty) {
                      return "Enter department";
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: "Deparment",
                    hintText: "Enter department",
                    suffixIcon: const Icon(Icons.fact_check_rounded),
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      onEditStudent();
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
