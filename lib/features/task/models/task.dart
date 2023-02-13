import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todolist_app_flutter/features/task/models/category.dart';
part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task {
  const factory Task(
      {required String? title,
      required String? description,
      required String? date,
      required Category? category,
      required int? priority,
      required bool isComplete}) = _Task;
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
