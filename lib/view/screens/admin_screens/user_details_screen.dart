import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final data = user.data() ?? {};

    final String name = data['name']?.toString() ?? 'Unknown';

    final String email = data['email']?.toString() ?? 'Not available';

    final String phone = data['phone']?.toString() ?? 'Not available';

    final String photoUrl = data['photoUrl']?.toString() ?? '';

    final String role = data['role']?.toString() ?? 'user';

    final String uid = data['uid']?.toString() ?? user.id;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'User Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),

        actions: [
          IconButton(
            onPressed: () => _refreshUser(context),
            icon: const Icon(Icons.refresh, color: Colors.black),
            tooltip: 'Refresh',
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          // Profile Card
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                // Profile image
                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: photoUrl.isEmpty
                      ? Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.person,
                            size: 55,
                            color: Colors.grey.shade500,
                          ),
                        )
                      : Image.network(
                          photoUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey.shade200,
                              child: Icon(
                                Icons.person,
                                size: 55,
                                color: Colors.grey.shade500,
                              ),
                            );
                          },
                        ),
                ),

                const SizedBox(height: 16),

                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  email,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),

                const SizedBox(height: 12),

                // Role badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff16A34A).withOpacity(.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    role.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xff16A34A),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Personal Information
          _SectionCard(
            title: 'Personal Information',
            children: [
              _InfoTile(icon: Icons.person_outline, title: 'Name', value: name),

              _InfoTile(
                icon: Icons.email_outlined,
                title: 'Email',
                value: email,
              ),

              _InfoTile(
                icon: Icons.phone_outlined,
                title: 'Phone',
                value: phone,
              ),

              _InfoTile(icon: Icons.badge_outlined, title: 'Role', value: role),
            ],
          ),

          const SizedBox(height: 18),

          // Account Information
          _SectionCard(
            title: 'Account Information',
            children: [
              _InfoTile(icon: Icons.fingerprint, title: 'UID', value: uid),

              _InfoTile(
                icon: Icons.account_circle_outlined,
                title: 'Account Type',
                value: role == 'user' ? 'User' : role,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _refreshUser(BuildContext context) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .get();

      if (!snapshot.exists) return;

      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserDetailsScreen(user: snapshot),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to refresh user details')),
      );
    }
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          ...children,
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 21, color: Colors.grey.shade600),

          const SizedBox(width: 12),

          SizedBox(
            width: 85,
            child: Text(
              title,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
