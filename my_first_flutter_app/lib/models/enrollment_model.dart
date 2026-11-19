class Enrollment {
  final int enrollmentID;
  final int studentID;
  final int subjectID;
  final int scheduleID;
  final DateTime enrolledAt;
  final String status;

  Enrollment({
    required this.enrollmentID,
    required this.studentID,
    required this.subjectID,
    required this.scheduleID,
    required this.enrolledAt,
    required this.status,
  });

  factory Enrollment.fromMap(Map<String, dynamic> map) {
    return Enrollment(
      enrollmentID: map['EnrollmentID'] as int,
      studentID: map['StudentID'] as int,
      subjectID: map['SubjectID'] as int,
      scheduleID: map['ScheduleID'] as int,
      enrolledAt: map['EnrolledAt'] is DateTime
          ? map['EnrolledAt'] as DateTime
          : DateTime.parse(map['EnrolledAt'].toString()),
      status: map['Status'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'EnrollmentID': enrollmentID,
      'StudentID': studentID,
      'SubjectID': subjectID,
      'ScheduleID': scheduleID,
      'EnrolledAt': enrolledAt.toIso8601String(),
      'Status': status,
    };
  }
}