//封装api，目的是返回业务侧要的数据结构
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

//获取首页轮播图
Future<List<BannerItem>> getBannerList() async {
  final data = await dioRequest.get(HttpConstants.BANNER_LIST);
  return (data as List)
      .map((item) => BannerItem.fromJson(item as Map<String, dynamic>))
      .toList();
}

//获取首页分类列表
Future<List<CategoryItem>> getCategoryList() async {
  final data = await dioRequest.get(HttpConstants.CATEGORY_LIST);
  return (data as List)
      .map((item) => CategoryItem.fromJson(item as Map<String, dynamic>))
      .toList();
}
