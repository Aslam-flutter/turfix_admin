import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminOwnersProvider extends ChangeNotifier {
  String searchQuery = '';
  String selectedStatus = 'All';

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

  List<QueryDocumentSnapshot<Map<String, dynamic>>> filterOwners(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> owners,
  ) {
    return owners.where((owner) {
      final data = owner.data();

      final name = data['name']?.toString().toLowerCase() ?? '';

      final phone = data['phone']?.toString().toLowerCase() ?? '';

      final email = data['email']?.toString().toLowerCase() ?? '';

      final ownerSearchMatch =
          name.contains(searchQuery) ||
          phone.contains(searchQuery) ||
          email.contains(searchQuery);

      final isAccepted = (data['isAccepted'] as num?)?.toInt() ?? 0;

      final status = getStatus(isAccepted);

      final statusMatch = selectedStatus == 'All' || status == selectedStatus;

      return ownerSearchMatch && statusMatch;
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
