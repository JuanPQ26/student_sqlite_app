final String tableStudents = 'students';

class StudentsFields {
  static final List<String> values = [id, code, name, program, status];

  static final String id = '_id';
  static final String code = 'code';
  static final String name = 'name';
  static final String program = 'program';
  static final String status = 'status';
}

class Student {
  final int? id;
  final String code;
  final String name;
  final String program;
  final bool status;

  Student(
      {this.id,
      required this.code,
      required this.name,
      required this.program,
      required this.status});

  Map<String, Object?> toJson() => {
        StudentsFields.id: id,
        StudentsFields.code: code,
        StudentsFields.name: name,
        StudentsFields.program: program,
        StudentsFields.status: status ? 1 : 0
      };

  Student copy(
          {int? id,
          String? code,
          String? name,
          String? program,
          bool? status}) =>
      Student(
          id: id ?? this.id,
          code: code!,
          name: name!,
          program: program!,
          status: status!);

  static Student fromJson(Map<String, Object?> json) => Student(
      id: json[StudentsFields.id] as int?,
      code: json[StudentsFields.code] as String,
      name: json[StudentsFields.name] as String,
      program: json[StudentsFields.program] as String,
      status: json[StudentsFields.status] == 1);
}
