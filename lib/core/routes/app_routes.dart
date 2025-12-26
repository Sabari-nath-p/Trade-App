part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SIGNUP = _Paths.SIGNUP;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const TRADE_LOGS = _Paths.TRADE_LOGS;
  static const ADD_TRADE = _Paths.ADD_TRADE;
  static const AI_ASSISTANT = _Paths.AI_ASSISTANT;
  static const SIGNIN = _Paths.SIGNIN;
}

abstract class _Paths {
  _Paths._();
  static const SIGNUP = '/signup';
  static const SIGNIN = '/sigin';

  static const DASHBOARD = '/dashboard';
  static const TRADE_LOGS = '/trade-logs';
  static const ADD_TRADE = '/add-trade';
  static const AI_ASSISTANT = '/ai-assistant';
}
