class Subject {
  final int subjectID;
  final String subjectCode;
  final String subjectName;
  final int units;
  final String description;

  Subject({
    required this.subjectID,
    required this.subjectCode,
    required this.subjectName,
    required this.units,
    required this.description,
  });

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      subjectID: map['SubjectID'] != null 
          ? int.tryParse(map['SubjectID'].toString()) ?? 0 
          : 0,
      subjectCode: map['SubjectCode']?.toString() ?? '',
      subjectName: map['SubjectName']?.toString() ?? '',
      units: map['Units'] != null 
          ? int.tryParse(map['Units'].toString()) ?? 3 
          : 3,
      description: map['Description']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'SubjectID': subjectID,
      'SubjectCode': subjectCode,
      'SubjectName': subjectName,
      'Units': units,
      'Description': description,
    };
  }
}