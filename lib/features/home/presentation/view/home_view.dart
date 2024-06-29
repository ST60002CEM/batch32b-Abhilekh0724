import 'dart:async';

import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<VenueCard> venueCards = [
    const VenueCard(
      imagePath: 'assets/images/AOne.jpg',
      venueName: 'AONE',
      description:
      'Rustic outdoor wedding venue with ocean view and picnic tables.',
      rating: 4.5,
      review: 'Great place, had a wonderful time!',
    ),
    const VenueCard(
      imagePath: 'assets/images/jeremy.jpg',
      venueName: 'Green Side',
      description:
      'Serene outdoor wedding venue by a lake with greenery backdrop',
      rating: 4.0,
      review: 'Good ambiance and service.',
    ),
    const VenueCard(
      imagePath: 'assets/images/Party.jpg',
      venueName: 'VenueVendor',
      description: 'Outdoor wedding venue with good ambience',
      rating: 3.5,
      review: 'Nice place, but could be better.',
    ),
    const VenueCard(
      imagePath: 'assets/images/Dar.jpg',
      venueName: 'Classic',
      description:
      'Elegant indoor wedding reception venue with string lights decoration..',
      rating: 5.0,
      review: 'Absolutely fantastic!',
    ),
    const VenueCard(
      imagePath: 'assets/images/11.jpg',
      venueName: 'Aone',
      description:
      'Elegant indoor wedding reception venue with string lights decoration..',
      rating: 5.0,
      review: 'Absolutely fantastic!',
    ),
    const VenueCard(
      imagePath: 'assets/images/22.jpg',
      venueName: 'National',
      description:
      'Elegant indoor wedding reception venue with string lights decoration..',
      rating: 5.0,
      review: 'Absolutely fantastic!',
    ),
    const VenueCard(
      imagePath: 'assets/images/33.jpeg',
      venueName: 'Heritage',
      description:
      'Elegant indoor wedding reception venue with string lights decoration..',
      rating: 5.0,
      review: 'Absolutely fantastic!',
    ),
    const VenueCard(
      imagePath: 'assets/images/33.jpg',
      venueName: 'Valley',
      description:
      'Elegant indoor wedding reception venue with string lights decoration..',
      rating: 5.0,
      review: 'Absolutely fantastic!',
    ),
    const VenueCard(
      imagePath: 'assets/images/1.jpeg',
      venueName: 'Venue',
      description:
      'Elegant indoor wedding reception venue with string lights decoration..',
      rating: 5.0,
      review: 'Absolutely fantastic!',
    ),
    const VenueCard(
      imagePath: 'assets/images/2.jpeg',
      venueName: 'Oosis',
      description:
      'Elegant indoor wedding reception venue with string lights decoration..',
      rating: 5.0,
      review: 'Absolutely fantastic!',
    ),
    const VenueCard(
      imagePath: 'assets/images/3.jpeg',
      venueName: 'BiheGhar',
      description:
      'Elegant indoor wedding reception venue with string lights decoration..',
      rating: 5.0,
      review: 'Absolutely fantastic!',
    ),
  ];

  final ScrollController _scrollController = ScrollController();
  int visibleCount = 4; // Initial number of visible items
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reached the end of the list, load more items
      loadMoreItems();
    }
  }

  void loadMoreItems() {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    // Simulate loading delay
    Timer(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false; // Hide loading indicator
        // Implement looping logic
        visibleCount = (visibleCount + 4 <= venueCards.length)
            ? visibleCount + 4
            : 4; // Loop back to the start after reaching the end
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[50],
      ),
      backgroundColor: Colors.red[50],
      body: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        itemCount: venueCards.length + (visibleCount < venueCards.length ? 1 : 0),
        itemBuilder: (context, index) {
          int adjustedIndex = index % venueCards.length;
          if (index < visibleCount) {
            return VenueCardWidget(venueCard: venueCards[adjustedIndex]);
          } else if (index == visibleCount && isLoading) {
            return const Center(
              child: CircularProgressIndicator(), // Show loading indicator
            );
          } else if (index == visibleCount) {
            return const Center(
            );
          } else {
            return Container(); // Empty container for index out of bounds safety
          }
        },
      ),
    );
  }
}

class VenueCardWidget extends StatelessWidget {
  final VenueCard venueCard;

  const VenueCardWidget({super.key, required this.venueCard});

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
                venueCard.imagePath,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              venueCard.venueName,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              venueCard.description,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const StarRating(rating: 4.5),
                const SizedBox(width: 8.0),
                Text(
                  '${venueCard.rating}',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              venueCard.review,
              style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

class VenueCard {
  final String imagePath;
  final String venueName;
  final String description;
  final double rating;
  final String review;

  const VenueCard({
    required this.imagePath,
    required this.venueName,
    required this.description,
    required this.rating,
    required this.review,
  });
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
