
import 'package:detection/models/order_model.dart';
import 'package:detection/services/order_service.dart';
import 'package:get/get.dart';

class EngraisOrderController extends GetxController with StateMixin<List<OrderModel>> {

  final service = Get.find<OrderService>();

  @override
  onReady() {
    getOrders();
  }

  getOrders() async {
    change(null, status: RxStatus.loading());
    try {
      final data = await service.fetchFarmerOrders();
      if (data.isEmpty) {
        change(data, status: RxStatus.empty());
      } else {
        change(data, status: RxStatus.success());
      }
    } on Exception catch (e) {
      change(null, status: RxStatus.error("unknown error"));
    }
  }
}