//无限滚动
import 'package:flutter/material.dart';

class HmMorelist extends StatefulWidget {
  const HmMorelist({super.key});

  @override
  State<HmMorelist> createState() => _HmMorelistState();
}

class _HmMorelistState extends State<HmMorelist> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            height: 300,
            child: Text(
              "更多推荐$index",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        );
      },
    );
  }
}
