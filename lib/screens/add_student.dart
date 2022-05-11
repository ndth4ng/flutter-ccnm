import 'package:flutter/material.dart';
import 'package:flutter_thang/shared/constants.dart';
import 'package:intl/intl.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();

  String fullName = '';
  String? gender;
  String phone = '';
  String email = '';
  DateTime? dateOfBirth;
  String address = '';
  String department = '';

  // Date picker
  TextEditingController dateCtl = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        dateCtl.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text("Add Student"),
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
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  validator: (String? val) {
                    if (val != null && val.isEmpty) {
                      return "Enter name";
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: "Full name",
                    hintText: "Enter name",
                    suffixIcon: const Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField<String>(
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
                        onChanged: (val) => setState(() {
                          gender = val!;
                        }),
                        decoration: textInputDecoration.copyWith(
                          label: const Text("Gender"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: TextFormField(
                        controller: dateCtl,
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
                  onChanged: (val) {
                    setState(() => phone = val);
                  },
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
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => address = val);
                  },
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
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
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
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => department = val);
                  },
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
                      print('sign in');
                    }
                  },
                  child: const Text(
                    'Create',
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
