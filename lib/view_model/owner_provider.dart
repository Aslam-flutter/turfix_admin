import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminOwnersProvider extends ChangeNotifier {
  String searchQuery = '';
  String selectedStatus = 'All';

  bool isUpdating = false;

  void searchOwners(String value) {
    searchQuery = value.trim().toLowerCase();
    notifyListeners();
  }

  void selectStatus(String status) {
    selectedStatus = status;
    notifyListeners();
  }

  void clearSearch() {
    searchQuery = '';
    notifyListeners();
  }

  String getStatus(int isAccepted) {
    switch (isAccepted) {
      case 1:
        return 'Approved';
      case -1:
        return 'Rejected';
      default:
        return 'Pending';
    }
  }

  // Accept owner
  Future<bool> acceptOwner(String ownerId) async {
    try {
      isUpdating = true;
      notifyListeners();

      await FirebaseFirestore.instance.collection('owners').doc(ownerId).update(
        {'isAccepted': 1},
      );

      return true;
    } catch (e) {
      debugPrint('Accept owner error: $e');
      return false;
    } finally {
      isUpdating = false;
      notifyListeners();
    }
  }

  // Reject owner
  Future<bool> rejectOwner(String ownerId) async {
    try {
      isUpdating = true;
      notifyListeners();

      await FirebaseFirestore.instance.collection('owners').doc(ownerId).update(
        {'isAccepted': -1},
      );

      return true;
    } catch (e) {
      debugPrint('Reject owner error: $e');
      return false;
    } finally {
      isUpdating = false;
      notifyListeners();
    }
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> filterOwners(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> owners,
  ) {
    return owners.where((owner) {
      final data = owner.data();

      final name = data['name']?.toString().toLowerCase() ?? '';

      final phone = data['phone']?.toString().toLowerCase() ?? '';

      final email = data['email']?.toString().toLowerCase() ?? '';

      final searchMatch =
          name.contains(searchQuery) ||
          phone.contains(searchQuery) ||
          email.contains(searchQuery);

      final isAccepted = (data['isAccepted'] as num?)?.toInt() ?? 0;

      final status = getStatus(isAccepted);

      final statusMatch = selectedStatus == 'All' || status == selectedStatus;

      return searchMatch && statusMatch;
    }).toList();
  }

  int countStatus(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> owners,
    String status,
  ) {
    return owners.where((owner) {
      final data = owner.data();

      final isAccepted = (data['isAccepted'] as num?)?.toInt() ?? 0;

      return getStatus(isAccepted) == status;
    }).length;
  }
}
