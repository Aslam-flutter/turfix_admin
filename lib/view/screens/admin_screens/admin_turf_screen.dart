import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turfix_admin/view_model/turf_provider.dart';

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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),

        title: const Text(
          "Turfs Management",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),

      body: Column(
        children: [
          // SEARCH
          Padding(
            padding: const EdgeInsets.all(18),
            child: Consumer<AdminTurfsProvider>(
              builder: (context, provider, child) {
                return TextField(
                  onChanged: provider.searchTurfs,

                  decoration: InputDecoration(
                    hintText: "Search turfs...",

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
                      borderSide: BorderSide(
                        color: Color(0xff16A34A),
                        width: 2,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // FILTERS
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection('turfs').snapshots(),

            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              }

              final turfs = snapshot.data!.docs;

              return Consumer<AdminTurfsProvider>(
                builder: (context, provider, child) {
                  return SizedBox(
                    height: 45,

                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,

                      padding: const EdgeInsets.symmetric(horizontal: 18),

                      child: Row(
                        children: [
                          _filterChip(context, provider, 'All', turfs.length),

                          const SizedBox(width: 10),

                          _filterChip(
                            context,
                            provider,
                            'Not Verified',
                            provider.countStatus(turfs, 'Not Verified'),
                          ),

                          const SizedBox(width: 10),

                          _filterChip(
                            context,
                            provider,
                            'Active',
                            provider.countStatus(turfs, 'Active'),
                          ),

                          const SizedBox(width: 10),

                          _filterChip(
                            context,
                            provider,
                            'Inactive',
                            provider.countStatus(turfs, 'Inactive'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),

          const SizedBox(height: 20),

          // TURF LIST
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('turfs')
                  .snapshots(),

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No turfs found'));
                }

                return Consumer<AdminTurfsProvider>(
                  builder: (context, provider, child) {
                    final turfs = provider.filterTurfs(snapshot.data!.docs);

                    if (turfs.isEmpty) {
                      return const Center(
                        child: Text(
                          'No turfs found',
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 18),

                      itemCount: turfs.length,

                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 14);
                      },

                      itemBuilder: (context, index) {
                        final turf = turfs[index].data();

                        final images = List<String>.from(
                          turf['turfImages'] ?? [],
                        );

                        final image = images.isNotEmpty ? images.first : '';

                        final status = provider.getTurfStatus(turf);

                        return TurfManagementTile(
                          image: image,

                          turfName:
                              turf['turfName']?.toString() ?? 'No turf name',

                          location:
                              turf['location']?.toString() ?? 'No location',

                          status: status,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(
    BuildContext context,
    AdminTurfsProvider provider,
    String filter,
    int count,
  ) {
    final bool selected = provider.selectedFilter == filter;

    return InkWell(
      onTap: () {
        provider.selectFilter(filter);
      },

      borderRadius: BorderRadius.circular(12),

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),

        decoration: BoxDecoration(
          color: selected ? const Color(0xff16A34A) : Colors.white,

          borderRadius: BorderRadius.circular(12),

          border: Border.all(
            color: selected ? const Color(0xff16A34A) : Colors.grey.shade300,
          ),
        ),

        child: Text(
          '$filter ($count)',
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,

            fontWeight: FontWeight.w600,
          ),
        ),
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

    final bool isNotVerified = status == "Not Verified";

    final Color statusColor;

    if (isNotVerified) {
      statusColor = Colors.orange;
    } else if (isActive) {
      statusColor = Colors.green;
    } else {
      statusColor = Colors.red;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(18),

      onTap: () {
        // Open Turf Details
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

              child: image.isEmpty
                  ? Container(
                      width: 75,
                      height: 75,
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.sports_soccer,
                        color: Colors.grey,
                      ),
                    )
                  : Image.network(
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,

                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
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

// import 'package:flutter/material.dart';
// class AdminTurfsScreen extends StatelessWidget {
//   const AdminTurfsScreen({super.key});

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
//           "Turfs Management",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//         ),
//       ),

//       body: ListView(
//         padding: const EdgeInsets.all(18),
//         children: [
//           TurfManagementTile(
//             image:
//                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwq1O-qC-iZVN_4hkTobZRzKrsWYBbmqrrgls7NwcKUSzQuwJLvMC3xcU&s=10",

//             turfName: "Green Field Arena",
//             location: "Kozhikode, Kerala",
//             status: "Active",
//           ),

//           SizedBox(height: 14),

//           TurfManagementTile(
//             image:
//                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwq1O-qC-iZVN_4hkTobZRzKrsWYBbmqrrgls7NwcKUSzQuwJLvMC3xcU&s=10",

//             turfName: "Kick Off Turf",
//             location: "Kannur, Kerala",
//             status: "Active",
//           ),

//           SizedBox(height: 14),

//           TurfManagementTile(
//             image:
//                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwq1O-qC-iZVN_4hkTobZRzKrsWYBbmqrrgls7NwcKUSzQuwJLvMC3xcU&s=10",

//             turfName: "Sports Hub Turf",
//             location: "Malappuram, Kerala",
//             status: "Inactive",
//           ),

//           SizedBox(height: 14),

//           TurfManagementTile(
//             image:
//                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwq1O-qC-iZVN_4hkTobZRzKrsWYBbmqrrgls7NwcKUSzQuwJLvMC3xcU&s=10",

//             turfName: "Victory Ground",
//             location: "Kozhikode, Kerala",
//             status: "Active",
//           ),

//           SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }

// class TurfManagementTile extends StatelessWidget {
//   final String image;
//   final String turfName;
//   final String location;
//   final String status;

//   const TurfManagementTile({
//     super.key,
//     required this.image,
//     required this.turfName,
//     required this.location,
//     required this.status,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool isActive = status == "Active";

//     return InkWell(
//       borderRadius: BorderRadius.circular(18),
//       onTap: () {
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(builder: (context) =>  ),
//         // );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(color: Colors.grey.shade200),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.03),
//               blurRadius: 8,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 image,
//                 width: 75,
//                 height: 75,
//                 fit: BoxFit.cover,
//               ),
//             ),

//             const SizedBox(width: 14),

//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     turfName,
//                     style: const TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(height: 6),

//                   Row(
//                     children: [
//                       Icon(
//                         Icons.location_on_outlined,
//                         color: Colors.grey.shade600,
//                         size: 16,
//                       ),

//                       const SizedBox(width: 4),

//                       Expanded(
//                         child: Text(
//                           location,
//                           style: TextStyle(
//                             color: Colors.grey.shade600,
//                             fontSize: 14,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 10),

//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 5,
//                     ),
//                     decoration: BoxDecoration(
//                       color: isActive
//                           ? Colors.green.withOpacity(.12)
//                           : Colors.red.withOpacity(.12),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       status,
//                       style: TextStyle(
//                         color: isActive ? Colors.green : Colors.red,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             Icon(
//               Icons.arrow_forward_ios,
//               size: 18,
//               color: Colors.grey.shade400,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
