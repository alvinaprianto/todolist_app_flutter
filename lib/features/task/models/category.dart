import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constants.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class Category with _$Category {
  const Category._();
  const factory Category(
      {required String title,
      required String img,
      required String colorHex}) = _Category;
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  static List<Category> generateList() {
    return [
      Category(
          title: "Grocery",
          img: icWork,
          colorHex: category1.value.toRadixString(16)),
      Category(
          title: "Work",
          img: icWork,
          colorHex: category2.value.toRadixString(16)),
      Category(
          title: "Sport",
          img: icWork,
          colorHex: category3.value.toRadixString(16)),
      Category(
          title: "Design",
          img: icWork,
          colorHex: category4.value.toRadixString(16)),
    ];
  }
}
