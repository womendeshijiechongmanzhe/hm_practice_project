import 'package:hm_shop/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tokenmanager {
  //返回持久化对象的实例对象
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  String _token = "";
  // 初始化
  Future<void> init() async {
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  // 设置token
  Future<void> setToken(String val) async {
    //获取持久化实例
    final prefs = await _getInstance();
    //写入磁盘中
    await prefs.setString(GlobalConstants.TOKEN_KEY, val);
    _token = val;
  }

  // 获取token
  String getToken() {
    return _token;
  }

  // 移除token
  Future<void> removeToken() async {
    final prefs = await _getInstance();
    await prefs.remove(GlobalConstants.TOKEN_KEY);
    _token = "";
  }
}

final Tokenmanager tokenManager = Tokenmanager();
