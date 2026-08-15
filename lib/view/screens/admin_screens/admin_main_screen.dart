import 'package:flutter/material.dart';
import 'package:turfix_admin/view/screens/admin_screens/admin_booking_screen.dart';
import 'package:turfix_admin/view/screens/admin_screens/admin_dashboard.dart';
import 'package:turfix_admin/view/screens/admin_screens/admin_owners_screen.dart';
import 'package:turfix_admin/view/screens/admin_screens/admin_turf_screen.dart';
import 'package:turfix_admin/view/screens/admin_screens/admin_user_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    AdminDashboardScreen(),
    AdminUsersScreen(),
    AdminOwnersScreen(),
    AdminTurfsScreen(),
    AdminBookingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xff16A34A);

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: pages),

      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xff111827),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.15),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              navItem(
                index: 0,
                icon: Icons.dashboard_outlined,
                label: "Dashboard",
                color: primary,
              ),

              navItem(
                index: 1,
                icon: Icons.people_outline,
                label: "Users",
                color: primary,
              ),

              navItem(
                index: 2,
                icon: Icons.group_outlined,
                label: "Owners",
                color: primary,
              ),

              navItem(
                index: 3,
                icon: Icons.stadium_outlined,
                label: "Turfs",
                color: primary,
              ),

              navItem(
                index: 4,
                icon: Icons.calendar_month_outlined,
                label: "Bookings",
                color: primary,
              ),

              // navItem(
              //   index: 4,
              //   icon: Icons.person_outline,
              //   label: "Profile",
              //   color: primary,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem({
    required int index,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    final bool selected = selectedIndex == index;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: selected ? color : Colors.grey, size: 24),

            const SizedBox(height: 4),

            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
