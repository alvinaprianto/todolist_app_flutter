import 'package:todolist_app_flutter/core/constants.dart';

class CategoryModel {
  String? title;
  String? img;

  CategoryModel({this.title, this.img});

  static List<CategoryModel> generateList() {
    return [
      CategoryModel(title: "Grocery", img: icWork),
      CategoryModel(title: "Work", img: icWork),
      CategoryModel(title: "Sport", img: icWork),
      CategoryModel(title: "Design", img: icWork),
    ];
  }
}
