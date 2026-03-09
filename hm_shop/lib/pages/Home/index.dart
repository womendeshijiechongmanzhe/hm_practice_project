import 'package:flutter/material.dart ';
import 'package:get/get.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMorelist.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';
import 'package:hm_shop/utils/ToastUtils.dart';
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
  ScrollController _scrollController = ScrollController();

  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();

  int _paddingTop = 0;

  final UserController _userController = Get.put(UserController());
  Future<void> _initUser() async {
    await tokenManager.init();
    // 初始化用户信息
    if (tokenManager.getToken().isNotEmpty) {
      _userController.updateUserInfo(await getUserProfileAPI());
    }
  }

  @override
  void initState() {
    super.initState();

    _initUser();

    Future.microtask(() {
      _paddingTop = 100;
      setState(() {});
      _key.currentState?.show();
    });

    _registerEvent();
  }

  //获取首页分类列表
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryList();
  }

  //获取首页轮播图
  Future<void> _getBannerList() async {
    _bannerList = await getBannerList();
  }

  //获取特惠推荐
  Future<void> _getPreferenceGoodsList() async {
    _preferenceGoods = await getPreferenceGoodsList();
  }

  //获取热榜推荐
  Future<void> _getInVogueGoodsList() async {
    _inVogueGoods = await getInVogueGoodsList();
  }

  //获取一站式推荐
  Future<void> _getOneStopGoodsList() async {
    _oneStopGoods = await getOneStopGoodsList();
  }

  //页码
  int _page = 1;
  bool _isLoading = false; //是否正在加载中
  bool _hasMore = true; //是否还有更多数据

  //获取更多推荐列表
  Future<void> _getRecommendGoodsList() async {
    //当正在加载中或没有更多数据时，直接返回
    if (_isLoading || !_hasMore) return;
    //设置正在加载中为true
    _isLoading = true;

    int requestLimit = _page * 8;
    _recommendGoodsList = await getRecommendGoodsList({"limit": requestLimit});

    setState(() {});
    _isLoading = false;
    if (_recommendGoodsList.length < requestLimit) {
      _hasMore = false;
      return;
    }
    _page++; //页码增加
  }

  //注册事件   监听滚动到底部的事件
  void _registerEvent() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent - 50)) {
        _getRecommendGoodsList();
      }
    });
  }

  Future<void> _OnRefresh() async {
    // 重置页码
    _page = 1;
    _isLoading = false;
    _hasMore = true;
    // 清空推荐列表
    await _getBannerList();
    await _getCategoryList();
    await _getPreferenceGoodsList();
    await _getInVogueGoodsList();
    await _getOneStopGoodsList();
    await _getRecommendGoodsList();
    ToastUtils.showToast(context, "刷新成功");
    _paddingTop = 0;
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.only(top: _paddingTop.toDouble()),
      child: RefreshIndicator(
        key: _key,
        onRefresh: _OnRefresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: _getScrollChildren(),
        ),
      ),
    );
  }
}
