import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../core/networking/local/api_service.dart';
import '../../data/dto/get_all_categories_dto.dart';
import '../../data/model/venue_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  List<VenueCard> venueCards = [];
  int visibleCount = 4; // Initial number of visible items
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchVenueCards();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      loadMoreItems();
    }
  }

  Future<void> _fetchVenueCards() async {
    setState(() {
      isLoading = true;
    });
    try {
      GetAllCategoriesDTO dto = await ApiService.getCategories();
      print('Fetched Categories: ${dto.categories}'); // Debugging line
      setState(() {
        venueCards = dto.categories ?? []; // Handle null categories
        isLoading = false;
      });
    } catch (e) {
      print('Fetch Exception: $e'); // Debugging line
      setState(() {
        isLoading = false;
      });
    }
  }

  void loadMoreItems() {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false; // Hide loading indicator
        visibleCount = (visibleCount + 4 <= venueCards.length)
            ? visibleCount + 4
            : venueCards.length; // Ensure you don't go out of bounds
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
      body: isLoading && venueCards.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        itemCount: visibleCount,
        itemBuilder: (context, index) {
          if (index < venueCards.length) {
            return VenueCardWidget(venueCard: venueCards[index]);
          } else if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container();
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
    // Update the base URL to match your server's IP and port
    final baseUrl = 'http://192.168.1.70:5500';

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
              child: Image.network(
                '$baseUrl${venueCard.photo ?? ''}', // Construct the image URL
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    return child;
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.error, color: Colors.red));
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              venueCard.name ?? 'No Name',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 8.0),
            Text(
              venueCard.info ?? 'No Info',
              style: const TextStyle(fontSize: 16.0),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 8.0),
            Text(
              '\$${venueCard.price?.toString() ?? "N/A"}',
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
