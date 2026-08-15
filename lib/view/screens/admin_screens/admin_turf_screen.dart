import 'package:flutter/material.dart';
class AdminTurfsScreen extends StatelessWidget {
  const AdminTurfsScreen({super.key});

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
          "Turfs Management",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          TurfManagementTile(
            image:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwq1O-qC-iZVN_4hkTobZRzKrsWYBbmqrrgls7NwcKUSzQuwJLvMC3xcU&s=10",

            turfName: "Green Field Arena",
            location: "Kozhikode, Kerala",
            status: "Active",
          ),

          SizedBox(height: 14),

          TurfManagementTile(
            image:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwq1O-qC-iZVN_4hkTobZRzKrsWYBbmqrrgls7NwcKUSzQuwJLvMC3xcU&s=10",

            turfName: "Kick Off Turf",
            location: "Kannur, Kerala",
            status: "Active",
          ),

          SizedBox(height: 14),

          TurfManagementTile(
            image:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwq1O-qC-iZVN_4hkTobZRzKrsWYBbmqrrgls7NwcKUSzQuwJLvMC3xcU&s=10",

            turfName: "Sports Hub Turf",
            location: "Malappuram, Kerala",
            status: "Inactive",
          ),

          SizedBox(height: 14),

          TurfManagementTile(
            image:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwq1O-qC-iZVN_4hkTobZRzKrsWYBbmqrrgls7NwcKUSzQuwJLvMC3xcU&s=10",

            turfName: "Victory Ground",
            location: "Kozhikode, Kerala",
            status: "Active",
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class TurfManagementTile extends StatelessWidget {
  final String image;
  final String turfName;
  final String location;
  final String status;

  const TurfManagementTile({
    super.key,
    required this.image,
    required this.turfName,
    required this.location,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = status == "Active";

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) =>  ),
        // );
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
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image,
                width: 75,
                height: 75,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    turfName,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey.shade600,
                        size: 16,
                      ),

                      const SizedBox(width: 4),

                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.green.withOpacity(.12)
                          : Colors.red.withOpacity(.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: isActive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
