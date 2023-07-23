import 'package:detection/models/order_model.dart';
import 'package:detection/ui/client/order/add_order_view.dart';
import 'package:get/get.dart';

import '../../services/order_service.dart';

class ClientController extends GetxController {
  final service = Get.find<OrderService>();

   navigateToAddOrder() => Get.to(()=>AddOrderView());



  Stream<List<OrderModel>> getOrders() => service.watchClientOrders();
}
