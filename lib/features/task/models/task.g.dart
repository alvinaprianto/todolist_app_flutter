// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$$_TaskFromJson(Map<String, dynamic> json) => _$_Task(
      title: json['title'] as String?,
      description: json['description'] as String?,
      date: json['date'] as String?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      priority: json['priority'] as int?,
      isComplete: json['isComplete'] as bool,
    );

Map<String, dynamic> _$$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'date': instance.date,
      'category': instance.category,
      'priority': instance.priority,
      'isComplete': instance.isComplete,
    };
