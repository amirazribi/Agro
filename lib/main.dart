import 'package:detection/services/order_service.dart';
import 'package:detection/services/consultation_service.dart';
import 'package:detection/ui/auth/controllers/auth_controller.dart';
import 'package:detection/ui/components/loading.dart';
import 'package:detection/ui/doctor/analyse/AnalysisModel.dart';
import 'package:detection/utlis/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put<AuthController>(AuthController());
  Get.put<ConsultationService>(ConsultationService(), permanent: true);
  Get.put<OrderService>(OrderService(), permanent: true);
  // Charger l'ABI du contrat Ethereum à partir du fichier Analysis.json
  final contractABI = await rootBundle.loadString("assets/Analysis.json");
  print(contractABI);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Loading(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: const [
          // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],
        initialRoute: "/",
        theme: ThemeData(
          colorScheme: ColorScheme.light(primary: Colors.green),
        ),
        getPages: Pages.routes,
      ),
    );
  }
}
