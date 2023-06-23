import 'package:detection/ui/auth/login_view.dart';
import 'package:detection/ui/splash_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../ui/doctor/analyse/analyse_view.dart';
import '../ui/auth/register_view.dart';
import '../ui/auth/reset_passsword_view.dart';
import '../ui/doctor/home/home_view.dart';
import '../ui/doctor/serre/add/add_serre_view.dart';
import '../ui/doctor/serre/serres_view.dart';
import '../ui/farmer/arrosage/add/add_arrosage_view.dart';
import '../ui/farmer/arrosage/arrosages_view.dart';
import '../ui/farmer/farmer_view.dart';

class Pages {
  Pages._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => SplashView()),
    GetPage(name: '/login', page: () => LoginView()),
    GetPage(name: '/register', page: () => RegisterView()),
    GetPage(name: '/home', page: () => HomeView()),
    GetPage(name: "/serres", page: () => SerresView()),
    GetPage(name: "/add_serre", page: () => AddSerreView()),
    GetPage(name: "/analyse", page: ()=>AnalyseView()),
    GetPage(name: '/reset-password', page: () => ResetPasswordView()),
    GetPage(name: "/farmer_view", page: ()=>FarmerView()),
    GetPage(name: "/arrosages", page: ()=>ArrosagesView()),
    GetPage(name: "/add_arrosage", page:()=> AddArrosageView())
  ];
}
