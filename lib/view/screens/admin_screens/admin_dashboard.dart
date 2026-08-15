import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

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
          "Admin Dashboard",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 1.1,
            children: const [
              DashboardStatCard(
                title: "Total Users",
                value: "452",
                icon: Icons.people,
                color: Colors.blue,
              ),

              DashboardStatCard(
                title: "Total Owners",
                value: "128",
                icon: Icons.store,
                color: Colors.red,
              ),

              DashboardStatCard(
                title: "Total Turfs",
                value: "266",
                icon: Icons.stadium,
                color: Colors.orange,
              ),

              DashboardStatCard(
                title: "Total Bookings",
                value: "1,245",
                icon: Icons.calendar_month,
                color: Colors.green,
              ),
            ],
          ),

          const SizedBox(height: 28),

          const Text(
            "Recent Bookings",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 18),

          const RecentBookingTile(
            name: "Aslam Muhammed",
            turf: "Green Field Arena",
            date: "20 May 2026",
            amount: "₹1200",
          ),

          const SizedBox(height: 12),

          const RecentBookingTile(
            name: "Zaid Khan",
            turf: "Kick Off Turf",
            date: "20 May 2026",
            amount: "₹2000",
          ),

          const SizedBox(height: 12),

          const RecentBookingTile(
            name: "Ayaan Ali",
            turf: "Sports Hub Turf",
            date: "19 May 2026",
            amount: "₹1500",
          ),

          const SizedBox(height: 12),

          const RecentBookingTile(
            name: "Rahul Das",
            turf: "Victory Ground",
            date: "19 May 2026",
            amount: "₹1000",
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class DashboardStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const DashboardStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(.12),
            child: Icon(icon, color: color, size: 22),
          ),

          const SizedBox(height: 14),

          Text(
            title,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class RecentBookingTile extends StatelessWidget {
  final String name;
  final String turf;
  final String date;
  final String amount;

  const RecentBookingTile({
    super.key,
    required this.name,
    required this.turf,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xff16A34A);

    return Container(
      padding: const EdgeInsets.all(14),
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
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage("assets/images/profile.jpg"),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  turf,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                ),

                const SizedBox(height: 4),

                Text(
                  date,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                ),
              ],
            ),
          ),

          Text(
            amount,
            style: const TextStyle(
              color: primary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
