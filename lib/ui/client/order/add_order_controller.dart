import 'package:detection/models/order_model.dart';
import 'package:detection/models/user_model.dart';
import 'package:detection/services/order_service.dart';
import 'package:get/get.dart';

class AddOrderController extends GetxController {
  final service = Get.find<OrderService>();
  RxList<UserModel> users = RxList<UserModel>();

  addOrder(OrderModel orderModel) async {
    await service.createOrder(orderModel);
  }

  @override
  void onInit() {
    fetchInfermier();
    super.onInit();
  }

  fetchInfermier() async {
    users.value = await service.fetchInfermiers();
  }
}
