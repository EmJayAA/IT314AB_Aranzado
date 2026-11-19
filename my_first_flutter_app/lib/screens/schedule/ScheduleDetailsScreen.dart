import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/schedule_model.dart';
import '../../viewmodels/schedule_viewmodel.dart';

class ScheduleDetailsScreen extends StatefulWidget {
  final Schedule schedule;
  const ScheduleDetailsScreen({super.key, required this.schedule});

  @override
  State<ScheduleDetailsScreen> createState() => _ScheduleDetailsScreenState();
}

class _ScheduleDetailsScreenState extends State<ScheduleDetailsScreen> {
  late final ScheduleViewModel _scheduleViewModel;
  late Schedule _currentSchedule;

  @override
  void initState() {
    super.initState();
    _scheduleViewModel = Provider.of<ScheduleViewModel>(context, listen: false);
    _currentSchedule = widget.schedule;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A0000),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Schedule Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: Color(0xFFFFD700),
                  width: 1.5,
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 25.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.schedule, size: 50, color: Colors.white54),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _currentSchedule.dayOfWeek,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: Colors.yellow,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Time: ${_currentSchedule.startTime} - ${_currentSchedule.endTime}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Helvetica',
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Room: ${_currentSchedule.room}',
                          style: const TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Slot Capacity: ${_currentSchedule.slotCapacity}',
                          style: const TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Schedule ID: ${_currentSchedule.scheduleID}',
                          style: const TextStyle(fontSize: 14, color: Colors.white54),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Subject ID: ${_currentSchedule.subjectID}',
                          style: const TextStyle(fontSize: 14, color: Colors.white54),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // Clean any accidental "Time(...)" wrappers for the text controllers
                        final cleanStart = _currentSchedule.startTime.replaceAll(RegExp(r'Time\(|\)'), '');
                        final cleanEnd = _currentSchedule.endTime.replaceAll(RegExp(r'Time\(|\)'), '');

                        final dayController = TextEditingController(text: _currentSchedule.dayOfWeek);
                        final startTimeController = TextEditingController(text: cleanStart);
                        final endTimeController = TextEditingController(text: cleanEnd);
                        final roomController = TextEditingController(text: _currentSchedule.room);
                        final capacityController = TextEditingController(text: _currentSchedule.slotCapacity.toString());

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext modalContext) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 20.0,
                                bottom: MediaQuery.of(modalContext).viewInsets.bottom + 20.0,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Edit Schedule Details',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextField(
                                      controller: dayController,
                                      decoration: const InputDecoration(
                                        labelText: 'Day of Week',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: startTimeController,
                                      decoration: const InputDecoration(
                                        labelText: 'Start Time (e.g., 08:00:00)',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: endTimeController,
                                      decoration: const InputDecoration(
                                        labelText: 'End Time (e.g., 10:00:00)',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: roomController,
                                      decoration: const InputDecoration(
                                        labelText: 'Room',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: capacityController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'Slot Capacity',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFFFD700),
                                        foregroundColor: Colors.black,
                                      ),
                                      onPressed: () async {
                                        final updatedSchedule = Schedule(
                                          scheduleID: _currentSchedule.scheduleID,
                                          subjectID: _currentSchedule.subjectID,
                                          dayOfWeek: dayController.text.trim(),
                                          startTime: startTimeController.text.trim(),
                                          endTime: endTimeController.text.trim(),
                                          room: roomController.text.trim(),
                                          slotCapacity: int.tryParse(capacityController.text.trim()) ?? _currentSchedule.slotCapacity,
                                        );

                                        await _scheduleViewModel.editSchedule(updatedSchedule);

                                        setState(() {
                                          _currentSchedule = updatedSchedule;
                                        });

                                        if (context.mounted) {
                                          Navigator.pop(modalContext);
                                        }
                                      },
                                      child: const Text('Save Changes'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}