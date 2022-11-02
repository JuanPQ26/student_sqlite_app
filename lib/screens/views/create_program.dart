import 'package:flutter/material.dart';
import 'package:student_sqlite_app/db/students_database.dart';
import 'package:student_sqlite_app/models/program.dart';

class CreateProgramView extends StatefulWidget {
  const CreateProgramView({super.key});

  @override
  State<CreateProgramView> createState() => _CreateProgramViewState();
}

class _CreateProgramViewState extends State<CreateProgramView> {
  final _programFormKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  child: const Text(
                "Crear Programa",
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              )),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: const Text(
                    "Rellena todos los campos",
                  ),
                )),
            Form(
                key: _programFormKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa el codigo del programa';
                          }
                          return null;
                        },
                        controller: _codeController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Codigo"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa el nombre del programa';
                          }
                          return null;
                        },
                        controller: _nameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Nombre"),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_programFormKey.currentState!.validate()) {
                            final Program createProgram = Program(
                                code: _codeController.text,
                                name: _nameController.text,
                                status: true);

                            StudentsDatabase.instance
                                .createProgram(createProgram);

                            Navigator.pushNamed(context, '/');
                          }
                        },
                        child: const Text("Guardar"))
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
