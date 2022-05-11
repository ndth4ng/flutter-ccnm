class Student {
  final int id;
  final String? fullName;
  final String? gender;
  final String? dateOfBirth;
  final String? phone;
  final String? address;
  final String? email;
  final String? department;

  Student({
    required this.id,
    this.fullName,
    this.gender,
    this.dateOfBirth,
    this.phone,
    this.address,
    this.email,
    this.department,
  });

  Student.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        fullName = json['p0'],
        gender = json['p1'],
        dateOfBirth = json['p2'],
        phone = json['p3'],
        address = json['p4'],
        email = json['p5'],
        department = json['p6'];
}
