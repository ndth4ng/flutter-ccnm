import 'package:flutter/cupertino.dart';
import 'package:flutter_thang/models/student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentService with ChangeNotifier {
  late List<Student> _students;

  List<Student> get students => _students;

  Future<List<Student>> getStudents() async {
    try {
      var url = Uri.parse(
          'http://api.phanmemquocbao.com/api/Doituong/getobjectsall?tokenget=lethibaotran');
      var response = await http.get(url);

      List<dynamic> jsonStudentData = jsonDecode(response.body);
      _students = _fromJson(jsonStudentData);

      return _students;
    } catch (e) {
      // log(e.toString());
      return [];
    }
  }

  List<Student> _fromJson(List<dynamic> studentsJson) {
    return studentsJson.map((student) => Student.fromJson(student)).toList();
  }
}
