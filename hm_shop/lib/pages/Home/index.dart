import 'package:flutter/material.dart ';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMorelist.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<BannerItem> _bannerList = [];
  List<CategoryItem> _categoryList = [];
  SpecialRecommend _preferenceGoods = SpecialRecommend(
    id: "id",
    title: "title",
    subTypes: [],
  );
  SpecialRecommend _inVogueGoods = SpecialRecommend(
    id: "id",
    title: "title",
    subTypes: [],
  );
  SpecialRecommend _oneStopGoods = SpecialRecommend(
    id: "id",
    title: "title",
    subTypes: [],
  );
  List<GoodDetailItem> _recommendGoodsList = [];

  @override
  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getPreferenceGoodsList();
    _getInVogueGoodsList();
    _getOneStopGoodsList();
    _getRecommendGoodsList();
  }

  //获取首页分类列表
  void _getCategoryList() async {
    _categoryList = await getCategoryList();
    setState(() {});
  }

  //获取首页轮播图
  void _getBannerList() async {
    _bannerList = await getBannerList();
    setState(() {});
  }

  //获取特惠推荐
  void _getPreferenceGoodsList() async {
    _preferenceGoods = await getPreferenceGoodsList();
    setState(() {});
  }

  //获取热榜推荐
  void _getInVogueGoodsList() async {
    _inVogueGoods = await getInVogueGoodsList();
    setState(() {});
  }

  //获取一站式推荐
  void _getOneStopGoodsList() async {
    _oneStopGoods = await getOneStopGoodsList();
    setState(() {});
  }

  //获取更多推荐列表
  void _getRecommendGoodsList() async {
    _recommendGoodsList = await getRecommendGoodsList({"limit": 10});
    setState(() {});
  }

  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: HmSuggestion(preferenceGoods: _preferenceGoods),
      ),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(reuslt: _inVogueGoods, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(reuslt: _oneStopGoods, type: "step"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),
      HmMorelist(recommendGoodsList: _recommendGoodsList),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
