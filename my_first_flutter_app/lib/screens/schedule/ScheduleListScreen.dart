import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/schedule_model.dart';
import '../../viewmodels/schedule_viewmodel.dart';
import '../../viewmodels/subject_viewmodel.dart';
import 'ScheduleDetailsScreen.dart';
import 'AddScheduleScreen.dart';
import '../app_drawer.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({super.key, required this.title});

  final String title;

  @override
  State<ScheduleListScreen> createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  late final ScheduleViewModel _scheduleViewModel;
  late final SubjectViewModel _subjectViewModel;

  @override
  void initState() {
    super.initState();
    _scheduleViewModel = Provider.of<ScheduleViewModel>(context, listen: false);
    _subjectViewModel = Provider.of<SubjectViewModel>(context, listen: false);
    
    _scheduleViewModel.fetchSchedules();
    _subjectViewModel.fetchSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A0000),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              final newSchedule = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddScheduleScreen(availableSubjects: _subjectViewModel.subjects),
                ),
              );
              if (newSchedule != null && newSchedule is Schedule) {
                try {
                  await _scheduleViewModel.addNewSchedule(newSchedule);
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString().replaceFirst('Exception: ', '')),
                        backgroundColor: Colors.red[800],
                      ),
                    );
                  }
                }
              }
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListenableBuilder(
        listenable: _scheduleViewModel,
        builder: (context, child) {
          if (_scheduleViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }

          if (_scheduleViewModel.schedules.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Schedules Found.',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Tap the + button in the top right to add a schedule.',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: _scheduleViewModel.schedules.length,
            itemBuilder: (context, index) {
              final schedule = _scheduleViewModel.schedules[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleDetailsScreen(schedule: schedule),
                      ),
                    );
                    _scheduleViewModel.fetchSchedules();
                  },
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Color(0xFFFFD700), width: 1.5),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.schedule, size: 40, color: Colors.white54),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                schedule.dayOfWeek,
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.yellow),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Time: ${schedule.startTime} - ${schedule.endTime}',
                                style: const TextStyle(fontSize: 18, color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Room: ${schedule.room}',
                                style: const TextStyle(fontSize: 16, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            onPressed: () async {
                              await _scheduleViewModel.removeSchedule(schedule.scheduleID);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}