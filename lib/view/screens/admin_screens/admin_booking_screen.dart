import 'package:flutter/material.dart';
import 'package:turfix_admin/view/screens/admin_screens/admin_booking_details_screen.dart';

class AdminBookingsScreen extends StatelessWidget {
  const AdminBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: const Text(
          "Bookings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),

      body: Column(
        children: [
          /// Search
          Padding(
            padding: const EdgeInsets.all(18),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search bookings...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: Color(0xff16A34A), width: 2),
                ),
              ),
            ),
          ),

          /// Filter Chips
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              children: [
                bookingFilterChip("All", true),
                const SizedBox(width: 10),
                bookingFilterChip("Upcoming", false),
                const SizedBox(width: 10),
                bookingFilterChip("Completed", false),
                const SizedBox(width: 10),
                bookingFilterChip("Cancelled", false),
              ],
            ),
          ),

          const SizedBox(height: 18),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              children: const [
                BookingTile(
                  customerName: "Aslam Muhammed",
                  turfName: "Green Field Arena",
                  date: "20 May 2026",
                  time: "06:00 PM - 07:00 PM",
                  amount: "₹1200",
                  status: "Upcoming",
                ),

                SizedBox(height: 14),

                BookingTile(
                  customerName: "Zaid Khan",
                  turfName: "Kick Off Turf",
                  date: "20 May 2026",
                  time: "08:00 PM - 09:00 PM",
                  amount: "₹1500",
                  status: "Completed",
                ),

                SizedBox(height: 14),

                BookingTile(
                  customerName: "Rahul Das",
                  turfName: "Victory Ground",
                  date: "19 May 2026",
                  time: "05:00 PM - 06:00 PM",
                  amount: "₹1000",
                  status: "Cancelled",
                ),

                SizedBox(height: 14),

                BookingTile(
                  customerName: "Ameen Ali",
                  turfName: "Sports Hub Turf",
                  date: "18 May 2026",
                  time: "07:00 PM - 08:00 PM",
                  amount: "₹1800",
                  status: "Upcoming",
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bookingFilterChip(String title, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? const Color(0xff16A34A) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: selected ? const Color(0xff16A34A) : Colors.grey.shade300,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class BookingTile extends StatelessWidget {
  final String customerName;
  final String turfName;
  final String date;
  final String time;
  final String amount;
  final String status;

  const BookingTile({
    super.key,
    required this.customerName,
    required this.turfName,
    required this.date,
    required this.time,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;

    switch (status) {
      case "Completed":
        statusColor = Colors.green;
        break;
      case "Cancelled":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.orange;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminBookingDetailsPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xff16A34A).withOpacity(.1),
              child: const Icon(Icons.person, color: Color(0xff16A34A)),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customerName,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(
                        Icons.stadium_outlined,
                        size: 16,
                        color: Color(0xff16A34A),
                      ),

                      const SizedBox(width: 6),

                      Expanded(
                        child: Text(
                          turfName,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                        color: Color(0xff16A34A),
                      ),

                      const SizedBox(width: 6),

                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_outlined,
                        size: 16,
                        color: Color(0xff16A34A),
                      ),

                      const SizedBox(width: 6),

                      Text(
                        time,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: const TextStyle(
                    color: Color(0xff16A34A),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
