import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

import 'package:hm_shop/constants/index.dart';

Future<GoodsDetailsItems> getGuessLikeGoods(Map<String, dynamic> params) async {
  return GoodsDetailsItems.fromJson(
    await dioRequest.get(HttpConstants.GUESS_LIST, params: params),
  );
}
