class Grade {
  final int gradeID;
  final int enrollmentID;
  final double gradeValue;
  final String? remarks;
  final DateTime dateRecorded;

  Grade({
    required this.gradeID,
    required this.enrollmentID,
    required this.gradeValue,
    this.remarks,
    required this.dateRecorded,
  });

  factory Grade.fromMap(Map<String, dynamic> map) {
  final rawGrade = map['GradeValue'];
  final double parsedGradeValue = rawGrade is num
      ? rawGrade.toDouble()
      : double.parse(rawGrade.toString());

  return Grade(
    gradeID: map['GradeID'] as int,
    enrollmentID: map['EnrollmentID'] as int,
    gradeValue: parsedGradeValue,
    remarks: map['Remarks'] as String?,
    dateRecorded: map['DateRecorded'] is DateTime
        ? map['DateRecorded'] as DateTime
        : DateTime.parse(map['DateRecorded'].toString()),
   );
  }

  Map<String, dynamic> toMap() {
    return {
      'GradeID': gradeID,
      'EnrollmentID': enrollmentID,
      'GradeValue': gradeValue,
      'Remarks': remarks,
      'DateRecorded': dateRecorded.toIso8601String(),
    };
  }
}