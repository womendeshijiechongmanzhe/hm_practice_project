import 'package:flutter/material.dart ';
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
  List<BannerItem> banners = [
    BannerItem(
      "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg",
      "1",
    ),
    BannerItem(
      "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png",
      "2",
    ),
    BannerItem(
      "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg",
      "3",
    ),
  ];

  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: banners)),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),
      SliverToBoxAdapter(child: const HmCategory()),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),
      SliverToBoxAdapter(child: const HmSuggestion()),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: HmHot()),
              SizedBox(width: 10),
              Expanded(child: HmHot()),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: const SizedBox(height: 10)),
      HmMorelist(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
