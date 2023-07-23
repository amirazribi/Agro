import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detection/models/enum/order_status.dart';
import 'package:detection/models/enum/user_type.dart';
import 'package:detection/models/order_model.dart';
import 'package:detection/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/enum/order_type.dart';
import '../ui/auth/controllers/auth_controller.dart';

class OrderService {
  static const collectionKey = "orders";
  final _fireStore = FirebaseFirestore.instance;

  Future createOrder(OrderModel model) async {
    final doc = _fireStore.collection(collectionKey).doc();
    model.id = doc.id;

    await doc.set(model.toJson());
  }

  Future<List<OrderModel>> fetchOrders() async {
    final snapshots = await _fireStore.collection(collectionKey).get();

    return snapshots.docs.map((e) => OrderModel.fromMap(e.data())).toList();
  }

  Future<List<UserModel>> fetchFarmers() async {
    final snapshots = await _fireStore
        .collection("users")
        .where("type", isEqualTo: UserType.farmer.name)
        .get();

    return snapshots.docs.map((e) => UserModel.fromMap(e.data())).toList();
  }

  Future<List<OrderModel>> fetchFarmerOrders() async {
    final snapshots = await _fireStore
        .collection(collectionKey)
        .where("farmerId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where("type", isEqualTo: OrderType.engrais.name)
        .get();

    return snapshots.docs.map((e) => OrderModel.fromMap(e.data())).toList();
  }

  Stream<List<OrderModel>> watchEngraisOrders() {
    return _fireStore
        .collection(collectionKey)
        .where("type", isEqualTo: OrderType.engrais.name)
        .snapshots()
        .map((event) {
      List<OrderModel> orders = [];
      orders
          .addAll(event.docs.map((e) => OrderModel.fromMap(e.data())).toList());

      return orders;
    });
  }

  Stream<List<OrderModel>> watchOrders() {
    return _fireStore.collection(collectionKey).snapshots().map((event) {
      List<OrderModel> orders = [];
      orders
          .addAll(event.docs.map((e) => OrderModel.fromMap(e.data())).toList());

      return orders;
    });
  }

  Stream<List<OrderModel>> watchClientOrders() {
    return _fireStore
        .collection(collectionKey)
        .where("clientId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .map((event) {
      List<OrderModel> orders = [];
      orders
          .addAll(event.docs.map((e) => OrderModel.fromMap(e.data())).toList());

      return orders;
    });
  }

  Future removeOrder(String? id) async {
    final doc = _fireStore.collection(collectionKey).doc(id);

    await doc.delete();
  }

  Future updateOrder(OrderModel model) async {
    final doc = _fireStore.collection(collectionKey).doc(model.id);

    doc.update(model.toJson());
  }

  Future changeOrderStatus(OrderStatus status, String? id) async {
    final doc = _fireStore.collection(collectionKey).doc(id);
    doc.update({"status": status.toJson()});
  }

  Future changeEngraisOrderStatus(OrderStatus status, String? id) async {
    final doc = _fireStore.collection(collectionKey).doc(id);
    doc.update({
      "status": status.toJson(),
      "clientName": AuthController.to.firestoreUser.value?.name
    });
  }
}
