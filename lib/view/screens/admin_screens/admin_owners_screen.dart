import 'package:flutter/material.dart';

class AdminOwnersScreen extends StatelessWidget {
  const AdminOwnersScreen({super.key});

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
          "Owners",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  statusChip("All", true),
                  const SizedBox(width: 10),
                  statusChip("Pending (5)", false),
                  const SizedBox(width: 10),
                  statusChip("Approved", false),
                  const SizedBox(width: 10),
                  statusChip("Rejected", false),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              children: const [
                OwnerTile(
                  image: "assets/images/profile.jpg",
                  ownerName: "Fasal Rahman",
                  phone: "+91 98765 12345",
                  turfName: "Green Field Arena",
                  status: "Pending",
                ),

                SizedBox(height: 14),

                OwnerTile(
                  image: "assets/images/profile.jpg",
                  ownerName: "Niyas Abdul",
                  phone: "+91 91234 56789",
                  turfName: "Kick Off Turf",
                  status: "Approved",
                ),

                SizedBox(height: 14),

                OwnerTile(
                  image: "assets/images/profile.jpg",
                  ownerName: "Shafee TK",
                  phone: "+91 99887 66554",
                  turfName: "Sports Hub Turf",
                  status: "Rejected",
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget statusChip(String text, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? const Color(0xff16A34A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? const Color(0xff16A34A) : Colors.grey.shade300,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class OwnerTile extends StatelessWidget {
  final String image;
  final String ownerName;
  final String phone;
  final String turfName;
  final String status;

  const OwnerTile({
    super.key,
    required this.image,
    required this.ownerName,
    required this.phone,
    required this.turfName,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;

    switch (status) {
      case "Approved":
        statusColor = Colors.green;
        break;
      case "Rejected":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.orange;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        // Navigate to Owner Details
      },
      child: Container(
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
            CircleAvatar(radius: 28, backgroundImage: AssetImage(image)),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ownerName,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    phone,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    turfName,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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

                const SizedBox(height: 16),

                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
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
