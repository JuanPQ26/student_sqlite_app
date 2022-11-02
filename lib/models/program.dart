const String tableProgram = 'programs';

class ProgramsFields {
  static final List<String> values = [id, code, name, status];

  static const String id = '_id';
  static const String code = 'code';
  static const String name = 'name';
  static const String status = 'status';
}

class Program {
  final int? id;
  final String code;
  final String name;
  final bool status;

  Program(
      {this.id, required this.code, required this.name, required this.status});

  Map<String, Object?> toJson() => {
        ProgramsFields.id: id,
        ProgramsFields.code: code,
        ProgramsFields.name: name,
        ProgramsFields.status: status ? 1 : 0
      };

  Program copy({int? id, String? code, String? name, bool? status}) =>
      Program(id: id ?? this.id, code: code!, name: name!, status: status!);

  static Program fromJson(Map<String, Object?> json) => Program(
      id: json[ProgramsFields.id] as int?,
      code: json[ProgramsFields.code] as String,
      name: json[ProgramsFields.name] as String,
      status: json[ProgramsFields.status] == 1);
}
