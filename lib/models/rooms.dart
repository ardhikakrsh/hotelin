class Room {
  final int id;
  final String roomType; // e.g., Reguler, Deluxe
  final String bedType; // e.g., Single Bed, Double Bed
  final int price;

  Room({
    required this.id,
    required this.roomType,
    required this.bedType,
    required this.price,
  });
}
