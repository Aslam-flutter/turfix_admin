import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminBookingsProvider extends ChangeNotifier {
  String searchQuery = '';
  String selectedFilter = 'All';

  void searchBookings(String value) {
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

  String getBookingStatus(Map<String, dynamic> data) {
    final firebaseStatus = data['status']?.toString().toLowerCase() ?? '';

    // Cancelled always has priority
    if (firebaseStatus == 'cancelled') {
      return 'Cancelled';
    }

    final startAt = data['startAt'];
    final endAt = data['endAt'];

    if (startAt is! Timestamp || endAt is! Timestamp) {
      return 'Upcoming';
    }

    final now = DateTime.now();

    final startTime = startAt.toDate();
    final endTime = endAt.toDate();

    if (now.isBefore(startTime)) {
      return 'Upcoming';
    }

    if (now.isBefore(endTime)) {
      return 'Playing';
    }

    return 'Completed';
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> filterBookings(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> bookings,
  ) {
    return bookings.where((booking) {
      final data = booking.data();

      final customerName = data['customerName']?.toString().toLowerCase() ?? '';

      final turfName = data['turfName']?.toString().toLowerCase() ?? '';

      final phone = data['phone']?.toString().toLowerCase() ?? '';

      final bookingId = booking.id.toLowerCase();

      final searchMatch =
          customerName.contains(searchQuery) ||
          turfName.contains(searchQuery) ||
          phone.contains(searchQuery) ||
          bookingId.contains(searchQuery);

      final status = getBookingStatus(data);

      final statusMatch = selectedFilter == 'All' || status == selectedFilter;

      return searchMatch && statusMatch;
    }).toList();
  }

  int countStatus(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> bookings,
    String status,
  ) {
    return bookings.where((booking) {
      return getBookingStatus(booking.data()) == status;
    }).length;
  }
}
