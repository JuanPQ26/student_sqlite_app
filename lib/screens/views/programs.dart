import 'package:flutter/material.dart';
import 'package:student_sqlite_app/db/students_database.dart';
import 'package:student_sqlite_app/models/program.dart';

class ProgramsView extends StatefulWidget {
  const ProgramsView({super.key});

  @override
  State<ProgramsView> createState() => _ProgramsViewState();
}

class _ProgramsViewState extends State<ProgramsView> {
  late List<Program> programs;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadPrograms();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future loadPrograms() async {
    setState(() {
      isLoading = true;
    });

    programs = await StudentsDatabase.instance.findAllProgram();

    setState(() {
      isLoading = false;
    });
  }

  ListView buildProgram() {
    return ListView.separated(
        itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Codigo: ${programs[index].code}"),
                    Text(programs[index].name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                  ]),
            ),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: programs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Programas Academicos"),
        elevation: 0.0,
      ),
      body: isLoading
          ? const Center(child: Text("Cargando..."))
          : programs.isEmpty
              ? const Center(child: Text("No hay programas"))
              : buildProgram(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/create-program");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
