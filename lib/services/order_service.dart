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
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> createOrder(OrderModel model) async {
    final doc = _fireStore.collection(collectionKey).doc();
    model.id = doc.id;

    await doc.set(model.toJson());
  }

  Future<List<OrderModel>> fetchOrders() async {
    final snapshots = await _fireStore.collection(collectionKey).get();

    return snapshots.docs.map((e) => OrderModel.fromMap(e.data())).toList();
  }

  Future<List<UserModel>> fetchInfermiers() async {
    final snapshots = await _fireStore
        .collection("users")
        .where("type", isEqualTo: UserType.infermier.name)
        .get();

    return snapshots.docs.map((e) => UserModel.fromMap(e.data())).toList();
  }

  Stream<List<OrderModel>> watchVisitesOrders() {
    return _fireStore
        .collection(collectionKey)
        .where("type", isEqualTo: OrderType.visites.name)
        .snapshots()
        .map((event) => event.docs.map((e) => OrderModel.fromMap(e.data())).toList());
  }

  Stream<List<OrderModel>> watchOrders() {
    return _fireStore.collection(collectionKey).snapshots().map(
            (event) => event.docs.map((e) => OrderModel.fromMap(e.data())).toList());
  }

  Stream<List<OrderModel>> watchClientOrders() {
    return _fireStore
        .collection(collectionKey)
        .where("clientId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .map(
            (event) => event.docs.map((e) => OrderModel.fromMap(e.data())).toList());
  }

  Future<void> removeOrder(String? id) async {
    final doc = _fireStore.collection(collectionKey).doc(id);

    await doc.delete();
  }

  Future<void> updateOrder(OrderModel model) async {
    final doc = _fireStore.collection(collectionKey).doc(model.id);

    await doc.update(model.toJson());
  }

  Future<void> changeOrderStatus(OrderStatus status, String? id) async {
    final doc = _fireStore.collection(collectionKey).doc(id);
    await doc.update({"status": status.toJson()});
  }

  Future<void> changeVisitesOrderStatus(OrderStatus status, String? id) async {
    final doc = _fireStore.collection(collectionKey).doc(id);
    await doc.update({
      "status": status.toJson(),
      "clientName": AuthController.to.firestoreUser.value?.name
    });
  }

  Future<List<OrderModel>> fetchInfermierOrders() async {
    final snapshots = await _fireStore
        .collection(collectionKey)
        .where("type", isEqualTo: OrderType.visites.name)
        .where("status", isEqualTo: OrderStatus.pending.name)
        .get();
    return snapshots.docs.map((e) => OrderModel.fromMap(e.data())).toList();
  }
}
