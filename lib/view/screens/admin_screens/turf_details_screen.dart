import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:turfix_admin/view_model/turf_provider.dart';

class AdminTurfDetailsScreen extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> turf;

  const AdminTurfDetailsScreen({super.key, required this.turf});

  @override
  Widget build(BuildContext context) {
    final data = turf.data() ?? {};

    final String turfName = data['turfName']?.toString() ?? 'Unknown Turf';

    final String location =
        data['location']?.toString() ?? 'Location unavailable';

    final String description =
        data['description']?.toString() ?? 'No description available';

    final String phone = data['phoneNumber']?.toString() ?? 'Not available';

    final String openingTime =
        data['openingTime']?.toString() ?? 'Not available';

    final String closingTime =
        data['closingTime']?.toString() ?? 'Not available';

    final double price = (data['pricePerHour'] as num?)?.toDouble() ?? 0.0;

    final double rating = (data['rating'] as num?)?.toDouble() ?? 0.0;

    final int isVerified = (data['isVerified'] as num?)?.toInt() ?? 0;

    final bool isTurfActive = data['isTurfActive'] == true;

    final double? latitude = (data['latitude'] as num?)?.toDouble();

    final double? longitude = (data['longitude'] as num?)?.toDouble();

    final List<String> images = List<String>.from(data['turfImages'] ?? []);

    final List<String> facilities = List<String>.from(data['facilities'] ?? []);

    final List<String> sports = List<String>.from(data['sports'] ?? []);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'Turf Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),

        actions: [
          IconButton(
            onPressed: () => _refreshTurf(context),
            icon: const Icon(Icons.refresh, color: Colors.black),
            tooltip: 'Refresh',
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          // IMAGE
          _buildImageSection(images),

          const SizedBox(height: 18),

          // BASIC DETAILS
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  turfName,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 19,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    _StatusBadge(
                      text: _getVerificationStatus(isVerified),
                      color: _getVerificationColor(isVerified),
                    ),

                    const SizedBox(width: 8),

                    _StatusBadge(
                      text: isTurfActive ? 'Active' : 'Inactive',
                      color: isTurfActive ? Colors.green : Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // TURF INFORMATION
          _SectionCard(
            title: 'Turf Information',
            children: [
              _InfoTile(
                icon: Icons.sports_soccer,
                title: 'Turf Name',
                value: turfName,
              ),

              _InfoTile(
                icon: Icons.location_on_outlined,
                title: 'Location',
                value: location,
              ),

              _InfoTile(
                icon: Icons.currency_rupee,
                title: 'Price / Hour',
                value: '₹${price.toStringAsFixed(0)}',
              ),

              _InfoTile(
                icon: Icons.access_time,
                title: 'Opening',
                value: openingTime,
              ),

              _InfoTile(
                icon: Icons.access_time_filled,
                title: 'Closing',
                value: closingTime,
              ),

              _InfoTile(
                icon: Icons.phone_outlined,
                title: 'Phone',
                value: phone,
              ),

              _InfoTile(
                icon: Icons.star_outline,
                title: 'Rating',
                value: rating.toStringAsFixed(1),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // DESCRIPTION
          _SectionCard(
            title: 'Description',
            children: [
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),

          // SPORTS
          if (sports.isNotEmpty) ...[
            const SizedBox(height: 18),

            _SectionCard(
              title: 'Sports',
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: sports.map((sport) {
                    return _Tag(text: sport);
                  }).toList(),
                ),
              ],
            ),
          ],

          // FACILITIES
          if (facilities.isNotEmpty) ...[
            const SizedBox(height: 18),

            _SectionCard(
              title: 'Facilities',
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: facilities.map((facility) {
                    return _Tag(text: facility);
                  }).toList(),
                ),
              ],
            ),
          ],

          // LOCATION COORDINATES
          if (latitude != null && longitude != null) ...[
            const SizedBox(height: 18),

            _SectionCard(
              title: 'Location Coordinates',
              children: [
                _InfoTile(
                  icon: Icons.my_location,
                  title: 'Latitude',
                  value: latitude.toString(),
                ),

                _InfoTile(
                  icon: Icons.my_location,
                  title: 'Longitude',
                  value: longitude.toString(),
                ),
              ],
            ),
          ],

          const SizedBox(height: 25),

          // ADMIN ACTIONS
          if (isVerified == 0) _AdminActions(turfId: turf.id),

          if (isVerified == 1)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                children: [
                  Icon(Icons.verified, color: Color(0xff16A34A)),
                  SizedBox(width: 10),
                  Text(
                    'This turf is verified.',
                    style: TextStyle(
                      color: Color(0xff16A34A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          if (isVerified == -1) _AdminActions(turfId: turf.id),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ---------------- IMAGE ----------------

  Widget _buildImageSection(List<String> images) {
    if (images.isEmpty) {
      return Container(
        height: 230,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.sports_soccer, size: 70, color: Colors.grey),
      );
    }

    return SizedBox(
      height: 230,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              images[index],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade200,
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  // ---------------- REFRESH ----------------

  Future<void> _refreshTurf(BuildContext context) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('turfs')
          .doc(turf.id)
          .get();

      if (!snapshot.exists) return;

      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AdminTurfDetailsScreen(turf: snapshot),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to refresh turf details')),
      );
    }
  }

  String _getVerificationStatus(int value) {
    if (value == 1) return 'Verified';
    if (value == -1) return 'Rejected';
    return 'Not Verified';
  }

  Color _getVerificationColor(int value) {
    if (value == 1) return Colors.green;
    if (value == -1) return Colors.red;
    return Colors.orange;
  }
}

class _AdminActions extends StatelessWidget {
  final String turfId;

  const _AdminActions({required this.turfId});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminTurfsProvider>(
      builder: (context, provider, child) {
        return Row(
          children: [
            // REJECT
            Expanded(
              child: OutlinedButton(
                onPressed: () async {
                  final confirm = await _showRejectDialog(context);

                  if (!confirm) return;

                  final success = await provider.rejectTurf(turfId);

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success ? 'Turf rejected' : 'Unable to reject turf',
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

            // VERIFY
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final success = await provider.verifyTurf(turfId);

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success ? 'Turf verified' : 'Unable to verify turf',
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
                child: const Text(
                  'Verify',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _showRejectDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reject Turf?'),
          content: const Text('Are you sure you want to reject this turf?'),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 21, color: Colors.grey.shade600),

          const SizedBox(width: 12),

          SizedBox(
            width: 90,
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
  final String text;
  final Color color;

  const _StatusBadge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;

  const _Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xff16A34A).withOpacity(.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xff16A34A),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
