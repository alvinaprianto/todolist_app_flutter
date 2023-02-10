import 'package:flutter/foundation.dart';

import 'category_model.dart';

class TaskModel {
  String? title;
  String? desc;
  String? date;
  CategoryModel? tag;
  int? priority;

  TaskModel({this.title, this.desc, this.date, this.tag, this.priority});

  toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["desc"] = desc;
    data["date"] = date;
    data["tag"] = tag;
    data["priority"] = priority;
    return data;
  }
}
