import 'package:flutter/material.dart';
import 'package:todolist_app_flutter/core/constants.dart';

class CategoryModel {
  String? title;
  String? img;
  Color? color;

  CategoryModel({this.title, this.img, this.color});

  toJson() {
    var data = <String, dynamic>{};
    data["title"] = title;
    data["img"] = img;
    data["color"] = color;
    return data;
  }

  static List<CategoryModel> generateList() {
    return [
      CategoryModel(title: "Grocery", img: icWork, color: category1),
      CategoryModel(title: "Work", img: icWork, color: category2),
      CategoryModel(title: "Sport", img: icWork, color: category3),
      CategoryModel(title: "Design", img: icWork, color: category4),
    ];
  }
}
