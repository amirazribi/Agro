import 'package:detection/ui/auth/login_view.dart';
import 'package:detection/ui/client/client_view.dart';
import 'package:detection/ui/doctor/Consultation/detail/consultation_detail_view.dart';
  //import 'package:detection/ui/doctor/consultation/detail/consultation_detail_view.dart';
import 'package:detection/ui/farmer/orders/farm_orders_view.dart';
import 'package:detection/ui/splash_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../ui/auth/register_view.dart';
import '../ui/auth/reset_passsword_view.dart';
import '../ui/client/order/add_order_view.dart';
import '../ui/doctor/analyse/analyse_view.dart';
import '../ui/doctor/home/home_view.dart';
import '../ui/doctor/consultation/add/add_consultation_view.dart';
import '../ui/doctor/consultation/consultations_view.dart';
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
    GetPage(name: "/consultations", page: () => ConsultationsView()),
    GetPage(name: "/add_consultation", page: () => AddConsultationView()),
    GetPage(name: "/analyse", page: () => AnalyseView()),
    GetPage(name: '/reset-password', page: () => ResetPasswordView()),
    GetPage(name: "/farmer_view", page: () => FarmerView()),
    GetPage(name: "/arrosages", page: () => ArrosagesView()),
    GetPage(name: "/add_arrosage", page: () => AddArrosageView()),
    GetPage(name: "/consultation_detail", page: () => ConsultationDetailView()),
    GetPage(name: "/client_view", page: () => ClientView()),
    GetPage(name: "/add_order", page: () => AddOrderView()),
    GetPage(name: "/farmer_orders", page: () => FarmOrdersView())
  ];
}
