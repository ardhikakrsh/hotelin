import 'package:flutter/material.dart';
import 'package:hotelin/models/hotels.dart';
import 'package:hotelin/service/auth/auth_service.dart';
import 'package:hotelin/service/database/firestore.dart';
import 'package:hotelin/service/notifications/notification_service.dart';
import 'package:hotelin/view/home_page.dart';

class RoomDetailPage extends StatelessWidget {
  final Hotels hotel;

  const RoomDetailPage({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final FirestoreService db = FirestoreService();
    final user = AuthService().getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HOTEL DETAILS',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 5,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hotel image
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.asset(
                hotel.image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hotel name
                  Text(
                    hotel.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Hotel address
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 18,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        hotel.address,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Hotel rating
                  Row(
                    children: [
                      const Icon(
                        Icons.apartment_rounded,
                        size: 20,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 2),
                      const Text(
                        'Hotel',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      ...getRatingStars(hotel.rating),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),

                  // Room details
                  const Text(
                    'Available Rooms',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Room list
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: hotel.rooms.length,
                    itemBuilder: (context, index) {
                      final room = hotel.rooms[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${room.roomType} Room',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.hotel,
                                    size: 24,
                                    color: Colors.black87,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    room.bedType,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Price: ${formatPrice(room.price)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // save booking to database
                                    await db.saveBookingToDatabase(
                                      userEmail: user?.email ?? 'empty',
                                      hotelName: hotel.name,
                                      roomType: room.roomType,
                                      bedType: room.bedType,
                                      price: formatPrice(room.price),
                                      bookedAt: DateTime.now(),
                                    );
                                    // create notification
                                    await NotificationService
                                        .createNotification(
                                      id: room.id,
                                      bookingId: DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString(),
                                      title: 'Booking Confirmation',
                                      body:
                                          'You have booked a ${room.roomType} room at ${hotel.name}.',
                                      hotelName: hotel.name,
                                      roomType: room.roomType,
                                      bedType: room.bedType,
                                      price: formatPrice(room.price),
                                      bookedAt: DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          'Booking successful!',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                    Navigator.push(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomePage(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    elevation: 5,
                                    foregroundColor: Colors.white,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.calendar_month_sharp,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Book Now',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
