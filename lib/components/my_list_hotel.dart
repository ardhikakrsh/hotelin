import 'package:flutter/material.dart';
import 'package:hotelin/models/hotels.dart';
import 'package:hotelin/view/room_detail_page.dart';

class MyListHotel extends StatelessWidget {
  final int index;
  const MyListHotel({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          // Navigasi ke detail
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomDetailPage(
                hotel: hotelList[index],
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Gambar Hotel
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  hotelList[index].image,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),

              // Detail Hotel
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // hotel name
                    Text(
                      hotelList[index].name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // hotel address
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 20,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            hotelList[index].address,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),

                    // hotel stars
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
                        ...getRatingStars(
                          hotelList[index].rating,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 8,
                          ),
                          child: Text(
                            'Start from ${formatPrice(hotelList[index].startFrom)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
