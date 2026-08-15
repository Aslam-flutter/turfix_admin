import 'package:flutter/material.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

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
          "Users",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search users...",
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

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              children: const [
                UserTile(
                  image: "assets/images/profile.jpg",
                  name: "Aslam Muhammed",
                  phone: "+91 98765 43210",
                ),

                SizedBox(height: 12),

                UserTile(
                  image: "assets/images/profile.jpg",
                  name: "Zaid Khan",
                  phone: "+91 91234 56789",
                ),

                SizedBox(height: 12),

                UserTile(
                  image: "assets/images/profile.jpg",
                  name: "Arjun Nair",
                  phone: "+91 99887 66554",
                ),

                SizedBox(height: 12),

                UserTile(
                  image: "assets/images/profile.jpg",
                  name: "Ramees KP",
                  phone: "+91 88997 77665",
                ),

                SizedBox(height: 12),

                UserTile(
                  image: "assets/images/profile.jpg",
                  name: "Ameen Ali",
                  phone: "+91 98700 12345",
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  final String image;
  final String name;
  final String phone;

  const UserTile({
    super.key,
    required this.image,
    required this.name,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  phone,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onSelected: (value) {},
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: "view",
                child: Row(
                  children: [
                    Icon(Icons.visibility_outlined),
                    SizedBox(width: 10),
                    Text("View"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "edit",
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined),
                    SizedBox(width: 10),
                    Text("Edit"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "block",
                child: Row(
                  children: [
                    Icon(Icons.block_outlined),
                    SizedBox(width: 10),
                    Text("Block"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "delete",
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, color: Colors.red),
                    SizedBox(width: 10),
                    Text("Delete", style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
