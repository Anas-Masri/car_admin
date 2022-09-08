class FilterModel {
  String? brand;
  String? model;
  String? yom;
  String? startPrice;
  String? endPrice;
  List<String> categories;
  FilterModel({
    this.brand,
    this.model,
    this.yom,
    this.startPrice,
    this.endPrice,
    required this.categories,
  });
}
