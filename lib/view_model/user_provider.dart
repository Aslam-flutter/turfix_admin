import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier {
  String searchQuery = '';

  void searchUsers(String value) {
    searchQuery = value.trim().toLowerCase();
    notifyListeners();
  }

  void clearSearch() {
    searchQuery = '';
    notifyListeners();
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> filterUsers(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> users,
  ) {
    if (searchQuery.isEmpty) {
      return users;
    }

    return users.where((user) {
      final data = user.data();

      final name = data['name']?.toString().toLowerCase() ?? '';

      final phone = data['phone']?.toString().toLowerCase() ?? '';

      final email = data['email']?.toString().toLowerCase() ?? '';

      return name.contains(searchQuery) ||
          phone.contains(searchQuery) ||
          email.contains(searchQuery);
    }).toList();
  }
}
