import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/schedule_model.dart';
import '../../models/subject_model.dart';
import '../../viewmodels/schedule_viewmodel.dart';

class AddScheduleScreen extends StatefulWidget {
  final List<Subject> availableSubjects;

  const AddScheduleScreen({super.key, required this.availableSubjects});

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final _formKey = GlobalKey<FormState>();

  int? _selectedSubjectID;
  final _dayController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _roomController = TextEditingController();
  final _capacityController = TextEditingController();

  @override
  void dispose() {
    _dayController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _roomController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedSubjectID != null) {
      final newSchedule = Schedule(
        scheduleID: DateTime.now().millisecondsSinceEpoch,
        subjectID: _selectedSubjectID!,
        dayOfWeek: _dayController.text.trim(),
        startTime: _startTimeController.text.trim(),
        endTime: _endTimeController.text.trim(),
        room: _roomController.text.trim(),
        slotCapacity: int.parse(_capacityController.text.trim()),
      );

      final scheduleVM = Provider.of<ScheduleViewModel>(context, listen: false);
      if (scheduleVM.hasConflict(newSchedule)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Schedule Conflict: Room "${newSchedule.room}" is already booked on ${newSchedule.dayOfWeek} during this time slot!',
            ),
            backgroundColor: Colors.red[800],
          ),
        );
        return;
      }

      Navigator.pop(context, newSchedule);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A0000),
        title: const Text('Add Schedule', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Assign Class Schedule',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFFD700)),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<int>(
                value: _selectedSubjectID,
                dropdownColor: const Color(0xFF5A0000),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Select Subject',
                  labelStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.book, color: Color(0xFFFFD700)),
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                items: widget.availableSubjects.map((sub) {
                  return DropdownMenuItem<int>(
                    value: sub.subjectID,
                    child: Text('${sub.subjectCode} - ${sub.subjectName}'),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedSubjectID = val),
                validator: (val) => val == null ? 'Please select a subject.' : null,
              ),
              const SizedBox(height: 15),
              _buildTextField(_dayController, 'Day of Week (e.g., Monday)', Icons.calendar_today),
              const SizedBox(height: 15),
              _buildTextField(_startTimeController, 'Start Time (e.g., 08:00 AM)', Icons.access_time),
              const SizedBox(height: 15),
              _buildTextField(_endTimeController, 'End Time (e.g., 11:00 AM)', Icons.access_time_filled),
              const SizedBox(height: 15),
              _buildTextField(_roomController, 'Room (e.g., Lab 302)', Icons.room),
              const SizedBox(height: 15),
              _buildTextField(_capacityController, 'Slot Capacity', Icons.group, keyboardType: TextInputType.number),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: _submit,
                child: const Text('Save Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      validator: (val) => val == null || val.trim().isEmpty ? '$label is required.' : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: const Color(0xFFFFD700)),
        filled: true,
        fillColor: Colors.black26,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}