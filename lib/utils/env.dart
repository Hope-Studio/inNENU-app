import 'package:flutter/foundation.dart';

class Environment {
  /// debug 开关，上线需要关闭
  ///
  /// App 运行在 Release 环境时，inProduction 为 true
  /// 当 App 运行在 Debug 和 Profile 环境时，inProduction 为 false
  static const inProduction = kReleaseMode;

  static bool isDriverTest = false;
  static bool isUnitTest = false;
}
