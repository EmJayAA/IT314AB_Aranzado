class Student {
  final int studentID;
  final String studentNumber;
  final String firstName;
  final String lastName;
  final String email;
  final String course;
  final int yearLevel;
  final String? contactNumber;
  final DateTime createdAt;

  Student({
    required this.studentID,
    required this.studentNumber,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.course,
    required this.yearLevel,
    this.contactNumber,
    required this.createdAt,
  });

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      studentID: map['StudentID'] != null 
          ? int.tryParse(map['StudentID'].toString()) ?? 0 
          : 0,
      studentNumber: map['StudentNumber']?.toString() ?? '',
      firstName: map['FirstName']?.toString() ?? '',
      lastName: map['LastName']?.toString() ?? '',
      email: map['Email']?.toString() ?? '',
      course: map['Course']?.toString() ?? '',
      yearLevel: map['YearLevel'] != null 
          ? int.tryParse(map['YearLevel'].toString()) ?? 1 
          : 1,
      contactNumber: map['ContactNumber']?.toString(),
      createdAt: map['CreatedAt'] != null
          ? (map['CreatedAt'] is DateTime
              ? map['CreatedAt'] as DateTime
              : DateTime.tryParse(map['CreatedAt'].toString()) ?? DateTime.now())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'StudentID': studentID,
      'StudentNumber': studentNumber,
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'Course': course,
      'YearLevel': yearLevel,
      'ContactNumber': contactNumber,
      'CreatedAt': createdAt.toIso8601String(),
    };
  }
}