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

//获取特惠推荐
Future<SpecialRecommend> getPreferenceGoodsList() async {
  return SpecialRecommend.fromJson(
    await dioRequest.get(HttpConstants.PREFERENCE_List),
  );
}

//热榜推荐
Future<SpecialRecommend> getInVogueGoodsList() async {
  return SpecialRecommend.fromJson(
    await dioRequest.get(HttpConstants.IN_VOGUE_LIST),
  );
}

//一站式推荐
Future<SpecialRecommend> getOneStopGoodsList() async {
  return SpecialRecommend.fromJson(
    await dioRequest.get(HttpConstants.ONE_STOP_LIST),
  );
}

//更多推荐列表
Future<List<GoodDetailItem>> getRecommendGoodsList(
  Map<String, dynamic> params,
) async {
  return ((await dioRequest.get(HttpConstants.RECOMMEND_LIST, params: params))
          as List)
      .map((item) => GoodDetailItem.fromJson(item as Map<String, dynamic>))
      .toList();
}
