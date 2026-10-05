import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turfix_admin/view_model/user_provider.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child: Consumer<UsersProvider>(
            builder: (context, provider, child) {
              return TextField(
                onChanged: provider.searchUsers,

                decoration: InputDecoration(
                  hintText: "Search users...",
                  prefixIcon: const Icon(Icons.search),

                  suffixIcon: provider.searchQuery.isNotEmpty
                      ? IconButton(
                          onPressed: provider.clearSearch,
                          icon: const Icon(Icons.close),
                        )
                      : null,

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
              );
            },
          ),
        ),

        Expanded(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),

            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No users found'));
              }

              return Consumer<UsersProvider>(
                builder: (context, provider, child) {
                  final users = provider.filterUsers(snapshot.data!.docs);

                  if (users.isEmpty) {
                    return const Center(
                      child: Text(
                        'No users found',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    itemCount: users.length,

                    itemBuilder: (context, index) {
                      final user = users[index].data();

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: UserTile(
                          image: user['image']?.toString() ?? '',
                          name: user['name']?.toString() ?? 'No name',
                          phone: user['phone']?.toString() ?? 'No phone number',
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';

// class AdminUsersScreen extends StatelessWidget {
//   const AdminUsersScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,

//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
//         ),
//         title: const Text(
//           "Users",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//         ),
//       ),

//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(18),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: "Search users...",
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.white,
//                 contentPadding: const EdgeInsets.symmetric(vertical: 16),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: BorderSide(color: Colors.grey.shade300),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: BorderSide(color: Colors.grey.shade300),
//                 ),
//                 focusedBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(14)),
//                   borderSide: BorderSide(color: Color(0xff16A34A), width: 2),
//                 ),
//               ),
//             ),
//           ),

//           Expanded(
//             child: ListView.builder(
//               itemCount: 3,
//               itemBuilder: (context, index) {
//                 return UserTile(image: '', name: 'name', phone: 'phone');
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
