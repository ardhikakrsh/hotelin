import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference bookings =
      FirebaseFirestore.instance.collection('bookings');

  Future<void> saveBookingToDatabase({
    required String userEmail,
    required String hotelName,
    required String roomType,
    required String bedType,
    required String price,
    required DateTime bookedAt,
  }) async {
    await bookings.add({
      'userEmail': userEmail,
      'hotelName': hotelName,
      'roomType': roomType,
      'bedType': bedType,
      'price': price,
      'bookedAt': DateTime.now(),
    });
  }
}
