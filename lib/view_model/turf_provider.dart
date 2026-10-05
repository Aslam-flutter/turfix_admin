import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminTurfsProvider extends ChangeNotifier {
  String searchQuery = '';
  String selectedFilter = 'All';

  void searchTurfs(String value) {
    searchQuery = value.trim().toLowerCase();
    notifyListeners();
  }

  void selectFilter(String filter) {
    selectedFilter = filter;
    notifyListeners();
  }

  void clearSearch() {
    searchQuery = '';
    notifyListeners();
  }

  String getTurfStatus(Map<String, dynamic> data) {
    final int isVerified = (data['isVerified'] as num?)?.toInt() ?? 0;

    final bool isTurfActive = data['isTurfActive'] ?? false;

    // Not verified
    if (isVerified != 1) {
      return 'Not Verified';
    }

    // Verified → check active status
    if (isTurfActive) {
      return 'Active';
    }

    return 'Inactive';
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> filterTurfs(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> turfs,
  ) {
    return turfs.where((turf) {
      final data = turf.data();

      final turfName = data['turfName']?.toString().toLowerCase() ?? '';

      final location = data['location']?.toString().toLowerCase() ?? '';

      final searchMatch =
          turfName.contains(searchQuery) || location.contains(searchQuery);

      final status = getTurfStatus(data);

      final statusMatch = selectedFilter == 'All' || status == selectedFilter;

      return searchMatch && statusMatch;
    }).toList();
  }

  int countStatus(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> turfs,
    String status,
  ) {
    return turfs.where((turf) {
      return getTurfStatus(turf.data()) == status;
    }).length;
  }
}
