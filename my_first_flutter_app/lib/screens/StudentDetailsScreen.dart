import 'package:flutter/material.dart';
import 'StudentListScreen.dart';

class StudentDetailsScreen extends StatelessWidget {
  final Profile profile;
  const StudentDetailsScreen({super.key,
      required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A0000),
        title: Text(
          'Student Details',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
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
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: (profile.imagePath?.isNotEmpty == true)
                        ? Image.asset(
                            profile.imagePath!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 120,
                            height: 120,
                            color: Colors.grey[800],
                            child: const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.white54,
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    profile.name ?? 'Name Unknown',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.yellow,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    profile.courseAndsection ?? 'Course: Unknown',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Age: ${profile.age?.toString() ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Hobbies: ${(profile.hobbies != null && profile.hobbies!.isNotEmpty) ? profile.hobbies!.join(", ") : "Not provided"}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Height: ${profile.height!= null ? "${profile.height} cm" : "Unknown"}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Student ID: ${profile.studentId ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Email: ${profile.email ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Contact No.: ${profile.phoneNumber ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (profile.studentStatus == false)
                  const Center(
                  child:
                    Text(
                      'WARNING: STUDENT IS NOT ENROLLED',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Helvetica',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          final nameController = TextEditingController(text: profile.name);
                          final courseController = TextEditingController(text: profile.courseAndsection);
                          final ageController = TextEditingController(text: profile.age?.toString());
                          final emailController = TextEditingController(text: profile.email);
                          final phoneController = TextEditingController(text: profile.phoneNumber);

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                            top: 20.0,
                            bottom: MediaQuery.of(context).viewInsets.bottom + 20.0,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Edit Student Details',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 15),
                                TextField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: courseController,
                                  decoration: const InputDecoration(
                                    labelText: 'Course & Section',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: ageController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Age',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: phoneController,
                                  decoration: const InputDecoration(
                                    labelText: 'Contact No.',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context); 
                                  },
                                  child: const Text('Save Changes'),
                                ),
                                  ],
                                  ),
                                  ),
                                  );
                                },
                            );
                           print('Edit pressed for ${profile.name}');
                        },
                    ),
                    SizedBox(width: 10),
                    if (profile.studentStatus == true)
                      const Icon(Icons.circle,
                      size: 25,
                      color: Colors.green)
                    else
                      const Icon(Icons.circle,
                      size: 25,
                      color: Colors.red),
                    SizedBox(width: 10)  
                  ],
              )
            )
            ]
          ),
          ),
        ]
          ),
        );
        }      
  }

