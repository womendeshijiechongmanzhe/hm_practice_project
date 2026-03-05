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

// 商品项
class GoodsItem {
  final String id;
  final String name;
  final String? desc;
  final String price;
  final String picture;
  final int orderNum;

  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      price: json['price'],
      picture: json['picture'],
      orderNum: json['orderNum'],
    );
  }
}

// 商品列表
class GoodsItems {
  final int counts;
  final int pageSize;
  final int pages;
  final int page;
  final List<GoodsItem> items;

  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json['counts'],
      pageSize: json['pageSize'],
      pages: json['pages'],
      page: json['page'],
      items: (json['items'] as List).map((e) => GoodsItem.fromJson(e)).toList(),
    );
  }
}

// 子类型
class SubType {
  final String id;
  final String title;
  final GoodsItems goodsItems;

  SubType({required this.id, required this.title, required this.goodsItems});

  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
      id: json['id'],
      title: json['title'],
      goodsItems: GoodsItems.fromJson(json['goodsItems']),
    );
  }
}

// 特惠推荐
class SpecialRecommend {
  final String id;
  final String title;
  final List<SubType> subTypes;

  SpecialRecommend({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory SpecialRecommend.fromJson(Map<String, dynamic> json) {
    return SpecialRecommend(
      id: json['id'],
      title: json['title'],
      subTypes: (json['subTypes'] as List)
          .map((e) => SubType.fromJson(e))
          .toList(),
    );
  }
}

//更多推荐列表
class GoodDetailItem extends GoodsItem {
  int payCount = 0;
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");

  factory GoodDetailItem.fromJson(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json['id']?.toString() ?? "",
      name: json['name']?.toString() ?? "",
      price: json['price']?.toString() ?? "",
      picture: json['picture']?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}
