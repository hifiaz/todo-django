import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
@CopyWith()
class Todo {
  const Todo(
      {this.id,
      required this.title,
      this.description,
      required this.completed,
      this.created,
      this.updated});

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  final int? id;
  final String title;
  final String? description;
  final bool completed;
  final DateTime? created;
  final DateTime? updated;

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
