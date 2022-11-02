import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:student_sqlite_app/models/program.dart';
import 'package:student_sqlite_app/db/students_database.dart';
import 'package:student_sqlite_app/models/student.dart';

class CreateStudentView extends StatefulWidget {
  const CreateStudentView({super.key});

  @override
  State<CreateStudentView> createState() => _CreateStudentViewState();
}

class _CreateStudentViewState extends State<CreateStudentView> {
  final _studentFormKey = GlobalKey<FormState>();

  final _codeController = TextEditingController();
  final _nameController = TextEditingController();

  String? _programSelected;
  bool isLoading = false;

  late List<Program> programsFound;

  void _onProgramSelected(value) {
    setState(() {
      _programSelected = value;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    setState(() {
      isLoading = true;
    });

    programsFound = await StudentsDatabase.instance.findAllProgram();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: Text('Cargando...'),
              )
            : Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: const Text(
                            "Crear Estudiante",
                            style: TextStyle(
                                fontSize: 32.0, fontWeight: FontWeight.bold),
                          ),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: const Text(
                            "Rellena todos los campos",
                          ),
                        )),
                    Form(
                        key: _studentFormKey,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 25),
                              child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor ingresa el codigo de estudiante';
                                    }
                                    return null;
                                  },
                                  controller: _codeController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Codigo")),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 25),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingresa el nombre del estudiante';
                                  }

                                  return null;
                                },
                                controller: _nameController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Nombre"),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 25),
                              child: DropdownButtonFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return "Por favor selecciona el programa del estudiante";
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  hint: const Text("Programa"),
                                  items: programsFound
                                      .map((el) => DropdownMenuItem(
                                          value: el.name, child: Text(el.name)))
                                      .toList(),
                                  value: _programSelected,
                                  onChanged: _onProgramSelected),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (_studentFormKey.currentState!
                                      .validate()) {
                                    final Student createStudent = Student(
                                        code: _codeController.text,
                                        name: _nameController.text,
                                        program: _programSelected!,
                                        status: true);

                                    StudentsDatabase.instance
                                        .createStudent(createStudent);

                                    Navigator.pushNamed(context, "/");
                                  }
                                },
                                child: const Text("Guardar"))
                          ],
                        )),
                  ],
                )),
      ),
    );
  }
}
