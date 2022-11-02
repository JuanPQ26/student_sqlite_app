import 'package:flutter/material.dart';
import 'package:student_sqlite_app/screens/views/create_program.dart';
import 'package:student_sqlite_app/screens/views/create_student.dart';
import 'package:student_sqlite_app/screens/views/programs.dart';
import 'package:student_sqlite_app/screens/views/students.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const StudentsView(),
        "/create-student": (context) => const CreateStudentView(),
        "/programs": (context) => const ProgramsView(),
        "/create-program": (context) => const CreateProgramView()
      },
    );
  }
}
