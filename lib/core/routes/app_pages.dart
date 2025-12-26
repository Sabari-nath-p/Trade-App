import 'package:get/get.dart';
import 'package:tradeapp/features/auth/screens/signin_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/journal/screens/add_trade_screen.dart';
import '../../features/tradelogs/screens/trade_logs_screen.dart';
import '../../features/ai_assistant/screens/ai_assistant_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGNIN;

  static final routes = [
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupScreen(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SignInScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardScreen(),
      transition:
          Transition.noTransition, // Web-like feel (no slide animations)
    ),
    GetPage(
      name: _Paths.TRADE_LOGS,
      page: () => const TradeLogsScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.ADD_TRADE,
      page: () => const AddTradeScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.AI_ASSISTANT,
      page: () => const AiAssistantScreen(),
      transition: Transition.noTransition,
    ),
  ];
}
