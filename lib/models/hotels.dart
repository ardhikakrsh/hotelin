import 'package:awesome_notifications/models/rooms.dart';
import 'package:intl/intl.dart';

class Hotels {
  final String name;
  final String address;
  final String image;
  final String rating;
  final int startFrom;
  final List<Room> rooms;

  Hotels({
    required this.name,
    required this.address,
    required this.image,
    required this.rating,
    required this.startFrom,
    required this.rooms,
  });
}

final List<Hotels> hotelList = [
  Hotels(
    name: 'Alana Hotel',
    address: 'Jl. Palagan Tentara Pelajar No.123, Yogyakarta',
    image: 'assets/images/alana.jpg',
    rating: '4',
    startFrom: 400000,
    rooms: [
      Room(
        roomType: 'Deluxe',
        bedType: 'Double Bed',
        price: 500000,
      ),
      Room(
        roomType: 'Regular',
        bedType: 'Single Bed',
        price: 300000,
      ),
    ],
  ),
  Hotels(
    name: 'Harris Hotel',
    address: 'Jl. Bangka Raya No.45, Jakarta Selatan',
    image: 'assets/images/harris.jpg',
    rating: '4',
    startFrom: 370000,
    rooms: [
      Room(
        roomType: 'Deluxe',
        bedType: 'Double Bed',
        price: 500000,
      ),
      Room(
        roomType: 'Regular',
        bedType: 'Single Bed',
        price: 300000,
      ),
    ],
  ),
  Hotels(
    name: 'Four Points Hotel',
    address: 'Jl. Embong Malang No.25-31, Surabaya',
    image: 'assets/images/fourpoints.jpg',
    rating: '5',
    startFrom: 520000,
    rooms: [
      Room(
        roomType: 'Deluxe',
        bedType: 'Double Bed',
        price: 600000,
      ),
      Room(
        roomType: 'Regular',
        bedType: 'Single Bed',
        price: 350000,
      ),
    ],
  ),
  Hotels(
    name: 'Shangrila Hotel',
    address: 'Jl. Jend. Sudirman Kav.1, Jakarta Pusat',
    image: 'assets/images/shangrila.jpg',
    rating: '5',
    startFrom: 750000,
    rooms: [
      Room(
        roomType: 'Deluxe',
        bedType: 'Double Bed',
        price: 900000,
      ),
      Room(
        roomType: 'Regular',
        bedType: 'Single Bed',
        price: 500000,
      ),
    ],
  ),
];

// convert to stars rating
String convertToStars(String rating) {
  int starCount = int.parse(rating);
  String stars = '';
  for (int i = 0; i < starCount; i++) {
    stars += '⭐';
  }
  return stars;
}

// format double value into money format
String formatPrice(int price) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp',
    decimalDigits: 0,
  ).format(price);
}
