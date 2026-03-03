//轮播图
import 'package:flutter/material.dart';

class HmSlider extends StatefulWidget {
  const HmSlider({super.key});

  @override
  State<HmSlider> createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange,
      height: 300,
      alignment: Alignment.center,
      child: Text("轮播图", style: TextStyle(fontSize: 20, color: Colors.yellow)),
    );
  }
}
