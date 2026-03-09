// 全局常量
class GlobalConstants {
  static const String baseUrl = 'https://meikou-api.itheima.net';
  static const int TIMEOUT = 5000;
  static const String SUCCESS_CODE = "1";
  static const String TOKEN_KEY = "hm_shop_token";
}

// 请求地址接口常量
class HttpConstants {
  static const String BANNER_LIST = "/home/banner";
  static const String CATEGORY_LIST = "/home/category/head";
  static const String PREFERENCE_List = "/hot/preference";
  static const String IN_VOGUE_LIST = "/hot/inVogue";
  static const String ONE_STOP_LIST = "/hot/oneStop";
  static const String RECOMMEND_LIST = "/home/recommend";
  static const String GUESS_LIST = "/home/goods/guessLike";
  static const String LOGIN = "/login";
  static const String USER_PROFILE = "/member/profile"; // 用户信息接口地址
}
