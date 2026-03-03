//轮播图
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;

  const HmSlider({super.key, required this.bannerList});

  @override
  State<HmSlider> createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  Widget _getSliderItem() {
    //获取媒体宽度
    final screenWidth = MediaQuery.of(context).size.width;

    return CarouselSlider(
      items: List.generate(widget.bannerList.length, (index) {
        return Image.network(
          widget.bannerList[index].imageUrl ?? "",
          fit: BoxFit.cover,
          width: screenWidth,
        );
      }),
      options: CarouselOptions(
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSliderItem()]);

    // Container(
    //   color: Colors.deepOrange,
    //   height: 300,
    //   alignment: Alignment.center,
    //   child: Text("轮播图", style: TextStyle(fontSize: 20, color: Colors.yellow)),
    // );
  }
}
