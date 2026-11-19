class Schedule {
  final int scheduleID;
  final int subjectID;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final String room;
  final int slotCapacity;

  Schedule({
    required this.scheduleID,
    required this.subjectID,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.slotCapacity,
  });

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      scheduleID: map['ScheduleID'] as int,
      subjectID: map['SubjectID'] as int,
      dayOfWeek: map['DayOfWeek'] as String,
      startTime: map['StartTime'].toString(),
      endTime: map['EndTime'].toString(),
      room: map['Room'] as String,
      slotCapacity: map['SlotCapacity'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ScheduleID': scheduleID,
      'SubjectID': subjectID,
      'DayOfWeek': dayOfWeek,
      'StartTime': startTime,
      'EndTime': endTime,
      'Room': room,
      'SlotCapacity': slotCapacity,
    };
  }
}