import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venuevendor/features/auth/presentation/navigator/register_navigator.dart';

import '../../../../app/navigator/navigator.dart';
import '../../../home/presentation/navigator/home_navigator.dart';
import '../view/login_view.dart';

final loginViewNavigatorProvider = Provider((ref) => LoginViewNavigator());

class LoginViewNavigator with RegisterViewRoute, HomeViewRoute {}

mixin LoginViewRoute {
  openLoginView() {
    NavigateRoute.popAndPushRoute(const LoginView());
  }
}
