// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../../app/navigator/navigator.dart';
// import '../../../../auth/presentation/navigator/login_navigator.dart';
// import '../view/home_view.dart';
// import '../view/category_detail_view.dart';
//
// final homeViewNavigatorProvider = Provider<HomeViewNavigator>((ref) {
//   return HomeViewNavigator();
// });
//
// class HomeViewNavigator with LoginViewRoute, HomeViewRoute {
//   // Navigate to CategoryDetailView and pass categoryId as a parameter
//   openCategoryDetailView(String categoryId) {
//     NavigateRoute.pushRoute(CategoryDetailView(categoryId: categoryId));
//   }
// }
//
// mixin HomeViewRoute {
//   // Navigate to HomeView
//   openHomeView() {
//     NavigateRoute.popAndPushRoute(const HomeView());
//   }
// }
