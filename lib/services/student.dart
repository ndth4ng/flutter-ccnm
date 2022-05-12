import 'package:flutter/cupertino.dart';
import 'package:flutter_thang/models/student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentService extends ChangeNotifier {
  late List<Student> _students = [];

  List<Student> get students => _students.reversed.toList();

  StudentService() {
    getStudents();
  }

  Future<void> getStudents() async {
    try {
      var url = Uri.parse(
          'http://api.phanmemquocbao.com/api/Doituong/getobjectsall?tokenget=lethibaotran');
      var response = await http.get(url);

      List<dynamic> jsonStudentData = jsonDecode(response.body);
      _students = _fromJson(jsonStudentData);

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addStudent(String fullName, gender, dateOfBirth, phone, address,
      email, department) async {
    try {
      var url = Uri.parse(
          'http://api.phanmemquocbao.com/api/Doituong/InsertObjects?p0=$fullName&p1=$gender&p2=$dateOfBirth&p3=$phone&p4=$address&p5=$email&p6=$department&tokenin=lethibaotran');

      var response = await http.get(url);

      Map<String, dynamic> student = jsonDecode(response.body);

      Student newStudent = Student(
          id: student['Id'],
          fullName: fullName,
          gender: gender,
          dateOfBirth: dateOfBirth,
          phone: phone,
          address: address,
          email: email,
          department: department);

      _students.add(newStudent);

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateStudent(int id, String fullName, gender, dateOfBirth,
      phone, address, email, department) async {
    try {
      var url = Uri.parse(
          'http://api.phanmemquocbao.com/api/Doituong/updateObjects?id=$id&p0=$fullName&p1=$gender&p2=$dateOfBirth&p3=$phone&p4=$address&p5=$email&p6=$department&tokenup=lethibaotran');

      await http.get(url);

      Student updatedStudent = Student(
          id: id,
          fullName: fullName,
          gender: gender,
          dateOfBirth: dateOfBirth,
          phone: phone,
          address: address,
          email: email,
          department: department);

      _students[_students.indexWhere((student) => student.id == id)] =
          updatedStudent;

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteStudent(int studentId) async {
    try {
      var url = Uri.parse(
          'http://api.phanmemquocbao.com/api/Doituong/deleteObject?id=$studentId&tokende=lethibaotran');

      await http.get(url);

      int index = _students.indexWhere((student) => student.id == studentId);
      _students.removeAt(index);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  List<Student> _fromJson(List<dynamic> studentsJson) {
    return studentsJson.map((student) => Student.fromJson(student)).toList();
  }
}
