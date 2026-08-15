
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class TurfDetailsScreen extends StatelessWidget {
//   const TurfDetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 280,
//               child: Stack(
//                 children: [
//                   /// IMAGE
//                   ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(30),
//                       bottomRight: Radius.circular(30),
//                     ),
//                     child: Image.network(
//                       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwq1O-qC-iZVN_4hkTobZRzKrsWYBbmqrrgls7NwcKUSzQuwJLvMC3xcU&s=10', // Your Image
//                       width: double.infinity,
//                       height: 280,
//                       fit: BoxFit.cover,
//                     ),
//                   ),

//                   /// GRADIENT
//                   Container(
//                     height: 280,
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(30),
//                         bottomRight: Radius.circular(30),
//                       ),
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.transparent,
//                           Colors.black54,
//                           Colors.black87,
//                         ],
//                       ),
//                     ),
//                   ),

//                   /// TOP BUTTONS
//                   SafeArea(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 18,
//                         vertical: 15,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           circleButton(Icons.arrow_back, () {}),

//                           Row(
//                             children: [
//                               circleButton(Icons.share, () {}),

//                               const SizedBox(width: 12),

//                               circleButton(Icons.favorite_border, () {}),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   /// DETAILS
//                   Positioned(
//                     left: 20,
//                     right: 20,
//                     bottom: 22,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Green Field Arena",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 34,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),

//                         const SizedBox(height: 12),

//                         Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 6,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: const Row(
//                                 children: [
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.orange,
//                                     size: 18,
//                                   ),
//                                   SizedBox(width: 5),
//                                   Text(
//                                     "4.6",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             const SizedBox(width: 10),

//                             const Text(
//                               "(126 reviews)",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 17,
//                               ),
//                             ),

//                             const Spacer(),

//                             const Icon(
//                               Icons.location_on,
//                               color: Colors.white,
//                               size: 20,
//                             ),

//                             const SizedBox(width: 5),

//                             const Text(
//                               "2.5 km",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 17,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),

//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// Sport & Price
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(
//                         Icons.sports_soccer,
//                         color: Color(0xff16A34A),
//                         size: 20,
//                       ),
//                       const SizedBox(width: 8),

//                       RichText(
//                         text: const TextSpan(
//                           children: [
//                             TextSpan(
//                               text: "Football",
//                               style: TextStyle(
//                                 color: Color(0xff16A34A),
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 17,
//                               ),
//                             ),
//                             TextSpan(
//                               text: " • Outdoor",
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 /// Facilities Heading
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Facilities",
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       TextButton(
//                         onPressed: () {},
//                         child: const Row(
//                           children: [
//                             Text(
//                               "View all",
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                             SizedBox(width: 3),
//                             Icon(
//                               Icons.arrow_forward_ios,
//                               size: 14,
//                               color: Colors.grey,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 SizedBox(
//                   height: 95,
//                   child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     children: const [
//                       FacilityCard(icon: Icons.local_parking, title: "Parking"),
//                       FacilityCard(icon: Icons.shower, title: "Shower"),
//                       FacilityCard(
//                         icon: Icons.lightbulb_outline,
//                         title: "Floodlights",
//                       ),
//                       FacilityCard(icon: Icons.wc, title: "Washroom"),
//                       FacilityCard(icon: Icons.local_cafe, title: "Cafeteria"),
//                       FacilityCard(icon: Icons.wifi, title: "Wi-Fi"),
//                       FacilityCard(icon: Icons.videocam, title: "CCTV"),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 14),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Select Date",
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.calendar_today_outlined,
//                           size: 20,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 SizedBox(
//                   height: 110,
//                   child: Consumer<BookingProvider>(
//                     builder: (_, provider, __) {
//                       return ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: provider.dates.length,
//                         itemBuilder: (_, index) {
//                           return DateCard(
//                             bookingDate: provider.dates[index],
//                             onTap: () => provider.selectDate(index),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 14),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   child: const Text(
//                     "Select Time",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                 ),

//                 Container(
//                   margin: EdgeInsets.all(6),
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: Consumer<BookingProvider>(
//                       builder: (_, provider, __) {
//                         return Wrap(
//                           spacing: 20,
//                           runSpacing: 12,
//                           children: [
//                             TimeSlotCard(
//                               startTime: "12:00 AM",
//                               endTime: "1:00 AM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(0),
//                               onTap: () => provider.selectSlot(0),
//                             ),
//                             TimeSlotCard(
//                               startTime: "1:00 AM",
//                               endTime: "2:00 AM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(1),
//                               onTap: () => provider.selectSlot(1),
//                             ),
//                             TimeSlotCard(
//                               startTime: "2:00 AM",
//                               endTime: "3:00 AM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(2),
//                               onTap: () => provider.selectSlot(2),
//                             ),
//                             TimeSlotCard(
//                               startTime: "3:00 AM",
//                               endTime: "4:00 AM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(3),
//                               onTap: () => provider.selectSlot(3),
//                             ),
//                             TimeSlotCard(
//                               startTime: "4:00 AM",
//                               endTime: "5:00 AM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(4),
//                               onTap: () => provider.selectSlot(4),
//                             ),
//                             TimeSlotCard(
//                               startTime: "5:00 AM",
//                               endTime: "6:00 AM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(5),
//                               onTap: () => provider.selectSlot(5),
//                             ),
//                             TimeSlotCard(
//                               startTime: "6:00 AM",
//                               endTime: "7:00 AM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(6),
//                               onTap: () => provider.selectSlot(6),
//                             ),
//                             TimeSlotCard(
//                               startTime: "7:00 AM",
//                               endTime: "8:00 AM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(7),
//                               onTap: () => provider.selectSlot(7),
//                             ),
//                             TimeSlotCard(
//                               startTime: "8:00 AM",
//                               endTime: "9:00 AM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(8),
//                               onTap: () => provider.selectSlot(8),
//                             ),
//                             TimeSlotCard(
//                               startTime: "9:00 AM",
//                               endTime: "10:00 AM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(9),
//                               onTap: () => provider.selectSlot(9),
//                             ),
//                             TimeSlotCard(
//                               startTime: "10:00 AM",
//                               endTime: "11:00 AM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(10),
//                               onTap: () => provider.selectSlot(10),
//                             ),
//                             TimeSlotCard(
//                               startTime: "11:00 AM",
//                               endTime: "12:00 PM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(11),
//                               onTap: () => provider.selectSlot(11),
//                             ),
//                             TimeSlotCard(
//                               startTime: "12:00 PM",
//                               endTime: "1:00 PM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(12),
//                               onTap: () => provider.selectSlot(12),
//                             ),
//                             TimeSlotCard(
//                               startTime: "1:00 PM",
//                               endTime: "2:00 PM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(13),
//                               onTap: () => provider.selectSlot(13),
//                             ),
//                             TimeSlotCard(
//                               startTime: "2:00 PM",
//                               endTime: "3:00 PM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(14),
//                               onTap: () => provider.selectSlot(14),
//                             ),
//                             TimeSlotCard(
//                               startTime: "3:00 PM",
//                               endTime: "4:00 PM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(15),
//                               onTap: () => provider.selectSlot(15),
//                             ),
//                             TimeSlotCard(
//                               startTime: "4:00 PM",
//                               endTime: "5:00 PM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(16),
//                               onTap: () => provider.selectSlot(16),
//                             ),
//                             TimeSlotCard(
//                               startTime: "5:00 PM",
//                               endTime: "6:00 PM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(17),
//                               onTap: () => provider.selectSlot(17),
//                             ),
//                             TimeSlotCard(
//                               startTime: "6:00 PM",
//                               endTime: "7:00 PM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(18),
//                               onTap: () => provider.selectSlot(18),
//                             ),
//                             TimeSlotCard(
//                               startTime: "7:00 PM",
//                               endTime: "8:00 PM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(19),
//                               onTap: () => provider.selectSlot(19),
//                             ),
//                             TimeSlotCard(
//                               startTime: "8:00 PM",
//                               endTime: "9:00 PM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(20),
//                               onTap: () => provider.selectSlot(20),
//                             ),
//                             TimeSlotCard(
//                               startTime: "9:00 PM",
//                               endTime: "10:00 PM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(21),
//                               onTap: () => provider.selectSlot(21),
//                             ),
//                             TimeSlotCard(
//                               startTime: "10:00 PM",
//                               endTime: "11:00 PM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(22),
//                               onTap: () => provider.selectSlot(22),
//                             ),
//                             TimeSlotCard(
//                               startTime: "11:00 PM",
//                               endTime: "12:00 AM",
//                               price: "₹1200",
//                               status: SlotStatus.available,
//                               isSelected: provider.isSelected(23),
//                               onTap: () => provider.selectSlot(23),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 50),
//               ],
//             ),
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

//       floatingActionButton: SizedBox(
//         width: MediaQuery.of(context).size.width - 32,
//         height: 56,
//         child: FloatingActionButton.extended(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => BookingScreen()),
//             );
//           },
//           backgroundColor: const Color(0xff16A34A),
//           elevation: 3,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           label: const Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Continue",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(width: 8),
//               Icon(Icons.arrow_forward_rounded, color: Colors.white),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget circleButton(IconData icon, GestureTapCallback? onTap) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: 48,
//         width: 48,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//         ),
//         child: Icon(icon, color: Colors.black87),
//       ),
//     );
//   }
// }

// class FacilityCard extends StatelessWidget {
//   final IconData icon;
//   final String title;

//   const FacilityCard({super.key, required this.icon, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 78,
//       margin: const EdgeInsets.only(left: 14),
//       child: Column(
//         children: [
//           Container(
//             height: 56,
//             width: 56,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               border: Border.all(color: Colors.grey.shade200),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(.04),
//                   blurRadius: 8,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Icon(icon, color: const Color(0xff16A34A), size: 26),
//           ),

//           const SizedBox(height: 8),

//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 13),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DateCard extends StatelessWidget {
//   final BookingDateModel bookingDate;
//   final VoidCallback onTap;

//   const DateCard({super.key, required this.bookingDate, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final date = bookingDate.date;
//     final selected = bookingDate.selected;

//     final dayName = date.day == DateTime.now().day
//         ? "Today"
//         : ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][date.weekday - 1];

//     final month = [
//       "Jan",
//       "Feb",
//       "Mar",
//       "Apr",
//       "May",
//       "Jun",
//       "Jul",
//       "Aug",
//       "Sep",
//       "Oct",
//       "Nov",
//       "Dec",
//     ][date.month - 1];

//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(18),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 500),
//         width: 70,
//         margin: const EdgeInsets.only(left: 12),
//         decoration: BoxDecoration(
//           color: selected ? const Color(0xff16A34A) : Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(
//             color: selected ? const Color(0xff16A34A) : Colors.grey.shade200,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.05),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               dayName,
//               style: TextStyle(
//                 color: selected ? Colors.white : const Color(0xff16A34A),
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               date.day.toString(),
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: selected ? Colors.white : Colors.black,
//               ),
//             ),
//             Text(
//               month,
//               style: TextStyle(color: selected ? Colors.white70 : Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// enum SlotStatus { available, booked, unavailable }

// class TimeSlotCard extends StatelessWidget {
//   final String startTime;
//   final String endTime;
//   final String price;
//   final SlotStatus status;
//   final bool isSelected;
//   final VoidCallback? onTap;

//   const TimeSlotCard({
//     super.key,
//     required this.startTime,
//     required this.endTime,
//     required this.price,
//     required this.status,
//     this.isSelected = false,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Color bgColor;
//     Color borderColor;
//     Color textColor;
//     String statusText;

//     switch (status) {
//       case SlotStatus.available:
//         bgColor = isSelected
//             ? const Color(0xff16A34A)
//             : const Color(0xffF5FCF7);
//         borderColor = const Color(0xff16A34A);
//         textColor = isSelected ? Colors.white : Colors.black;
//         statusText = "Available";
//         break;

//       case SlotStatus.booked:
//         bgColor = Colors.grey.shade100;
//         borderColor = Colors.grey.shade300;
//         textColor = Colors.grey.shade500;
//         statusText = "Booked";
//         break;

//       case SlotStatus.unavailable:
//         bgColor = const Color(0xffFDECEC);
//         borderColor = Colors.red.shade300;
//         textColor = Colors.red.shade700;
//         statusText = "Unavailable";
//         break;
//     }

//     return InkWell(
//       onTap: status == SlotStatus.available ? onTap : null,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         width: 95,
//         margin: const EdgeInsets.only(right: 12),
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: borderColor, width: isSelected ? 2 : 1),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               startTime,
//               style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
//             ),

//             Text(endTime, style: TextStyle(color: textColor)),

//             const SizedBox(height: 8),

//             Text(statusText, style: TextStyle(fontSize: 12, color: textColor)),

//             const SizedBox(height: 4),

//             Text(
//               price,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: isSelected ? Colors.white : const Color(0xff16A34A),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
