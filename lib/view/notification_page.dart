import 'package:flutter/material.dart';
import 'package:hotelin/view/home_page.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatelessWidget {
  final String? title;
  final String? message;
  final String? bookingId;
  final String? hotelName;
  final String? roomType;
  final String? bedType;
  final String? price;
  final DateTime? bookedAt;

  const NotificationPage({
    super.key,
    this.title,
    this.message,
    this.bookingId,
    this.hotelName,
    this.roomType,
    this.bedType,
    this.price,
    this.bookedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'NOTIFICATION',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 5,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.check_circle_outline,
                color: Colors.blueAccent,
              ),
              title: Text(title ?? 'No Title'),
              subtitle: Text(message ?? 'No Message'),
            ),
            const Divider(height: 20),

            ListTile(
              leading: const Icon(
                Icons.payment,
                color: Colors.blueAccent,
              ),
              title: const Text('Payment Received'),
              subtitle: Text(
                  'We have received your payment for bookingId #${bookingId ?? '#12345'}.'),
            ),
            const Divider(height: 20),

            const ListTile(
              leading: Icon(
                Icons.local_offer,
                color: Colors.blueAccent,
              ),
              title: Text('Special Offer!'),
              subtitle: Text('Get 20% off your next stay. Limited time offer!'),
            ),
            const Divider(height: 20),

            // detail booking
            ListTile(
              leading: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
              title: const Text('Booking Details'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Check your booking details below:'),
                  const SizedBox(height: 8),
                  Text(
                    hotelName ?? 'N/A',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${roomType ?? 'N/A'} Room',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    bedType ?? 'N/A',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    price ?? 'N/A',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    bookedAt != null
                        ? 'Booked At: ${DateFormat('dd-MM-yyyy').format(bookedAt!)}'
                        : 'N/A',
                  ),
                ],
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shadowColor: Colors.blue.shade300,
                      elevation: 5,
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Back to Home',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
