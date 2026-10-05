import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turfix_admin/model/auth_model.dart';

class FirestoreServices {
  Future<void> addUserDetails(AuthModel model) async {
    await FirebaseFirestore.instance
        .collection('admin')
        .doc(model.uid)
        .set(model.toJson());
  }
}
