
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venuevendor/features/auth/presentation/view/login_view.dart';

import '../../../../app/navigator/navigator.dart';
import '../view/register_view.dart';
import 'login_navigator.dart';
final registerViewNavigatorProvider = Provider((ref) => RegisterViewNavigator());

class RegisterViewNavigator with LoginViewRoute {}

mixin RegisterViewRoute {
  openRegisterView() {
    NavigateRoute.pushRoute(const RegisterView());
  }
}
