import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF800000),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF5A0000)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'School Management',
                  style: TextStyle(color: Color(0xFFFFD700), fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text('System Navigation', style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.people, color: Color(0xFFFFD700)),
            title: const Text('Students', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushReplacementNamed(context, '/student-list'),
          ),
          ListTile(
            leading: const Icon(Icons.book, color: Color(0xFFFFD700)),
            title: const Text('Subjects', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushReplacementNamed(context, '/subject-list'),
          ),
          ListTile(
            leading: const Icon(Icons.schedule, color: Color(0xFFFFD700)),
            title: const Text('Schedules', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushReplacementNamed(context, '/schedule-list'),
          ),
          ListTile(
            leading: const Icon(Icons.how_to_reg, color: Color(0xFFFFD700)),
            title: const Text('Enrollments', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushReplacementNamed(context, '/enrollment-list'),
          ),
          ListTile(
            leading: const Icon(Icons.grade, color: Color(0xFFFFD700)),
            title: const Text('Grades', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushReplacementNamed(context, '/grade-list'),
          ),
        ],
      ),
    );
  }
}