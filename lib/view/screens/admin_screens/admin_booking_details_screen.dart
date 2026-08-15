import 'package:flutter/material.dart';

class AdminBookingDetailsPage extends StatelessWidget {
  const AdminBookingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xff16A34A);

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
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => const [
              PopupMenuItem(value: "invoice", child: Text("Download Invoice")),
              PopupMenuItem(value: "share", child: Text("Share Booking")),
            ],
          ),
        ],
        title: const Text(
          "Booking Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: primary.withOpacity(.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Text(
                  "BK-2025-000123",
                  style: TextStyle(color: primary, fontWeight: FontWeight.bold),
                ),
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(.12),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(radius: 4, backgroundColor: Colors.orange),
                    SizedBox(width: 8),
                    Text(
                      "Upcoming",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// USER CARD
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 34,
                  backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwq1O-qC-iZVN_4hkTobZRzKrsWYBbmqrrgls7NwcKUSzQuwJLvMC3xcU&s=10",
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Aslam Muhammed",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(Icons.call, color: primary, size: 18),

                          const SizedBox(width: 6),

                          Text(
                            "+91 98765 43210",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          const Icon(
                            Icons.email_outlined,
                            color: primary,
                            size: 18,
                          ),

                          const SizedBox(width: 6),

                          Text(
                            "aslam@gmail.com",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: primary.withOpacity(.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.call, color: primary),
                        SizedBox(height: 6),
                        Text(
                          "Call",
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// TURF INFORMATION CARD
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwq1O-qC-iZVN_4hkTobZRzKrsWYBbmqrrgls7NwcKUSzQuwJLvMC3xcU&s=10",

                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Green Field Arena",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 18,
                            color: Color(0xff16A34A),
                          ),

                          const SizedBox(width: 6),

                          Expanded(
                            child: Text(
                              "Kozhikode, Kerala",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(
                            Icons.sports_soccer,
                            size: 18,
                            color: Color(0xff16A34A),
                          ),

                          const SizedBox(width: 6),

                          Text(
                            "Football",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xff16A34A).withOpacity(.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.visibility_outlined,
                          color: Color(0xff16A34A),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "View",
                          style: TextStyle(
                            color: Color(0xff16A34A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// BOOKING INFORMATION
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: const [
                BookingInfoRow(
                  icon: Icons.calendar_today_outlined,
                  title: "Date",
                  value: "20 May 2026",
                ),

                Divider(),

                BookingInfoRow(
                  icon: Icons.access_time,
                  title: "Time",
                  value: "06:00 PM - 07:00 PM",
                ),

                Divider(),

                BookingInfoRow(
                  icon: Icons.timer_outlined,
                  title: "Duration",
                  value: "1 Hour",
                ),

                Divider(),

                BookingInfoRow(
                  icon: Icons.group_outlined,
                  title: "Players",
                  value: "10 Players",
                ),

                Divider(),

                BookingInfoRow(
                  icon: Icons.currency_rupee,
                  title: "Amount",
                  value: "₹1200",
                ),

                Divider(),

                BookingInfoRow(
                  icon: Icons.payment_outlined,
                  title: "Payment",
                  value: "Paid",
                  valueColor: Colors.green,
                ),

                Divider(),

                BookingInfoRow(
                  icon: Icons.check_circle_outline,
                  title: "Booking Status",
                  value: "Confirmed",
                  valueColor: Colors.green,
                ),

                Divider(),

                BookingInfoRow(
                  icon: Icons.history,
                  title: "Booked On",
                  value: "18 May 2026, 10:30 AM",
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// USER NOTE
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xff16A34A).withOpacity(.06),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xff16A34A).withOpacity(.2),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.notes_outlined, color: Color(0xff16A34A)),
                    SizedBox(width: 8),
                    Text(
                      "User Note",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                Text(
                  "Please keep the field clean after the match and ensure the floodlights remain on until the booking ends.",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),

          const SizedBox(height: 110),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.call, color: Colors.white),
                    label: const Text(
                      "Call",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff16A34A),
                      minimumSize: const Size.fromHeight(55),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.chat, color: Colors.white),
                    label: const Text(
                      "WhatsApp",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff25D366),
                      minimumSize: const Size.fromHeight(55),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.visibility_outlined,
                      color: Color(0xff16A34A),
                    ),
                    label: const Text(
                      "View Turf",
                      style: TextStyle(
                        color: Color(0xff16A34A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(55),
                      side: const BorderSide(color: Color(0xff16A34A)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.cancel_outlined, color: Colors.red),
                    label: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(55),
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BookingInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? valueColor;

  const BookingInfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 22),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
            ),
          ),

          Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
