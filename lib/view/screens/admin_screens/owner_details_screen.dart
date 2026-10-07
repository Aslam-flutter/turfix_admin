import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turfix_admin/view_model/owner_provider.dart';

class OwnerDetailsScreen extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> owner;

  const OwnerDetailsScreen({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    final data = owner.data() ?? {};

    final String name = data['name']?.toString() ?? 'Unknown';

    final String email = data['email']?.toString() ?? 'Not available';

    final String phone = data['phone']?.toString() ?? 'Not available';

    final String photoUrl = data['photoUrl']?.toString() ?? '';

    final String role = data['role']?.toString() ?? 'owner';

    final String uid = data['uid']?.toString() ?? owner.id;

    final int isAccepted = (data['isAccepted'] as num?)?.toInt() ?? 0;

    Future<void> _refreshOwner(BuildContext context) async {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('owners')
            .doc(owner.id)
            .get();

        if (!snapshot.exists) return;

        if (!context.mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OwnerDetailsScreen(owner: snapshot),
          ),
        );
      } catch (e) {
        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to refresh owner details')),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Owner Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () => _refreshOwner(context),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),

      body: Consumer<AdminOwnersProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.all(18),
            children: [
              // Profile
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
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 12),

                    _StatusBadge(status: provider.getStatus(isAccepted)),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Personal details
              _SectionCard(
                title: 'Owner Information',
                children: [
                  _InfoTile(
                    icon: Icons.person_outline,
                    title: 'Name',
                    value: name,
                  ),

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

                  _InfoTile(
                    icon: Icons.badge_outlined,
                    title: 'Role',
                    value: role,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Account details
              _SectionCard(
                title: 'Account Information',
                children: [
                  _InfoTile(icon: Icons.fingerprint, title: 'UID', value: uid),

                  _InfoTile(
                    icon: Icons.verified_user_outlined,
                    title: 'Acceptance',
                    value: isAccepted == 1
                        ? 'Approved'
                        : isAccepted == -1
                        ? 'Rejected'
                        : 'Pending',
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Action buttons
              if (isAccepted == 0) ...[
                Row(
                  children: [
                    // Reject
                    Expanded(
                      child: OutlinedButton(
                        onPressed: provider.isUpdating
                            ? null
                            : () async {
                                final confirm = await _showRejectDialog(
                                  context,
                                );

                                if (!confirm) return;

                                final success = await provider.rejectOwner(
                                  owner.id,
                                );

                                if (!context.mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      success
                                          ? 'Owner rejected'
                                          : 'Unable to reject owner',
                                    ),
                                  ),
                                );
                              },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Reject',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Accept
                    Expanded(
                      child: ElevatedButton(
                        onPressed: provider.isUpdating
                            ? null
                            : () async {
                                final success = await provider.acceptOwner(
                                  owner.id,
                                );

                                if (!context.mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      success
                                          ? 'Owner approved'
                                          : 'Unable to approve owner',
                                    ),
                                  ),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff16A34A),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: provider.isUpdating
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Accept',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                      ),
                    ),
                  ],
                ),
              ],

              // Already approved
              if (isAccepted == 1)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.08),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle, color: Color(0xff16A34A)),
                      SizedBox(width: 10),
                      Text(
                        'This owner is approved.',
                        style: TextStyle(
                          color: Color(0xff16A34A),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

              // Already rejected
              if (isAccepted == -1)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(.08),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.cancel, color: Colors.red),
                      SizedBox(width: 10),
                      Text(
                        'This owner is rejected.',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<bool> _showRejectDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reject Owner?'),
          content: const Text('Are you sure you want to reject this owner?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Reject'),
            ),
          ],
        );
      },
    );

    return result ?? false;
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

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (status) {
      case 'Approved':
        color = Colors.green;
        break;

      case 'Rejected':
        color = Colors.red;
        break;

      default:
        color = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}
