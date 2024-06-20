import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'bottom_view/dashboard_view.dart';
import 'bottom_view/profile_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int selectedIndex = 0;
  List<Widget> lstScreen = [
    const DashboardView(),
    const ProfileView(),
  ];

  List<Widget> venueCards = const [
    VenueCard(
      imagePath: 'assets/images/AOne.jpg',
      venueName: 'AONE',
      description: 'Rustic outdoor wedding venue with ocean view and picnic tables.',
      rating: 4.5,
      review: 'Great place, had a wonderful time!',
    ),
    SizedBox(height: 16.0),
    VenueCard(
      imagePath: 'assets/images/jeremy.jpg',
      venueName: 'Green Side',
      description: 'Serene outdoor wedding venue by a lake with greenery backdrop',
      rating: 4.0,
      review: 'Good ambiance and service.',
    ),
    SizedBox(height: 16.0),
    VenueCard(
      imagePath: 'assets/images/Party.jpg',
      venueName: 'VenueVendor',
      description: 'Outdoor wedding venue with good ambience',
      rating: 3.5,
      review: 'Nice place, but could be better.',
    ),
    SizedBox(height: 16.0),
    VenueCard(
      imagePath: 'assets/images/Dar.jpg',
      venueName: 'Classic',
      description: 'Elegant indoor wedding reception venue with string lights decoration..',
      rating: 5.0,
      review: 'Absolutely fantastic!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[50],
        title: const Text('Venue Vendor'),
      ),
      backgroundColor: Colors.red[50],
      body: selectedIndex == 0
          ? ListView(
        padding: const EdgeInsets.all(16.0),
        children: venueCards,
      )
          : lstScreen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}

class VenueCard extends StatelessWidget {
  final String imagePath;
  final String venueName;
  final String description;
  final double rating;
  final String review;

  const VenueCard({
    Key? key,
    required this.imagePath,
    required this.venueName,
    required this.description,
    required this.rating,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imagePath,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              venueName,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const StarRating(rating: 4.5),
                const SizedBox(width: 8.0),
                Text(
                  '$rating',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              review,
              style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;

  const StarRating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      Icon starIcon;
      if (i <= rating) {
        starIcon = const Icon(Icons.star, color: Colors.amber);
      } else if (i - rating < 1) {
        starIcon = const Icon(Icons.star_half, color: Colors.amber);
      } else {
        starIcon = const Icon(Icons.star_border, color: Colors.amber);
      }
      stars.add(starIcon);
    }
    return Row(children: stars);
  }
}
