import 'package:flutter/material.dart';
import 'package:student_sqlite_app/db/students_database.dart';
import 'package:student_sqlite_app/models/student.dart';

class StudentsView extends StatefulWidget {
  const StudentsView({super.key});

  @override
  State<StudentsView> createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  late List<Student> students;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  @override
  void dispose() {
    StudentsDatabase.instance.close();
    super.dispose();
  }

  Future loadStudents() async {
    setState(() {
      isLoading = true;
    });

    students = await StudentsDatabase.instance.findAllStudent();

    setState(() {
      isLoading = false;
    });
  }

  ListView buildStudent() {
    return ListView.separated(
        itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("Codigo ${students[index].code}")],
            )),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: students.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estudiantes'),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: 0,
                  child: Text("Ver Programas"),
                )
              ];
            },
            onSelected: (value) {
              switch (value) {
                case 0:
                  Navigator.pushNamed(context, "/programs");
                  break;
                default:
              }
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(child: Text("Cargando..."))
          : students.isEmpty
              ? const Center(child: Text('No hay estudiantes'))
              : buildStudent(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/create-student');
          },
          child: const Icon(Icons.add)),
    );
  }
}
