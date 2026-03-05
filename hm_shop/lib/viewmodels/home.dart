class BannerItem {
  String? imgUrl;
  String? id;
  BannerItem(this.imgUrl, this.id);
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(json["imgUrl"] ?? "", json["id"] ?? "");
  }
}

///根据json编写class对象和工厂转化函数
class CategoryItem {
  final String id;
  final String name;
  final String picture;
  final List<CategoryItem>? children;
  final List<dynamic>? goods;

  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
    this.goods,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'],
      name: json['name'],
      picture: json['picture'],
      children: json['children'] != null
          ? (json['children'] as List)
                .map((e) => CategoryItem.fromJson(e))
                .toList()
          : null,
      goods: json['goods'],
    );
  }
}
