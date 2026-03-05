//爆款
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmHot extends StatefulWidget {
  final SpecialRecommend reuslt;
  final String type;
  const HmHot({super.key, required this.reuslt, required this.type});

  @override
  State<HmHot> createState() => _HmHotState();
}

class _HmHotState extends State<HmHot> {
  List<GoodsItem> get _items {
    if (widget.reuslt.subTypes.isEmpty) return [];
    return widget.reuslt.subTypes.first.goodsItems.items.take(2).toList();
  }

  List<Widget> _getChildrenList() {
    return _items.map((item) {
      return Container(
        width: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  "lib/assets/err_image.jpg",
                  width: 80,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                item.picture,
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  item.price.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.type == "step" ? "一站买全" : "爆款推荐",
          style: TextStyle(
            color: const Color.fromARGB(255, 97, 19, 19),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          widget.type == "step" ? "精心优选" : "最受欢迎",
          style: TextStyle(
            color: const Color.fromARGB(255, 86, 24, 20),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.type == "hot" ? Colors.white : Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _getChildrenList(),
            ),
          ],
        ),
      ),
    );
  }
}
