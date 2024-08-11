import 'package:flutter/material.dart';
import '../../../../../core/networking/local/api_service.dart';
import '../../data/model/venue_card.dart';

class CategoryDetailView extends StatefulWidget {
  final String categoryId;

  const CategoryDetailView({Key? key, required this.categoryId}) : super(key: key);

  @override
  _CategoryDetailViewState createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends State<CategoryDetailView> {
  VenueCard? venueCard;
  bool isLoading = true;
  bool hasError = false;
  final _reviewController = TextEditingController();
  double _rating = 1.0;

  @override
  void initState() {
    super.initState();
    _fetchCategoryDetails();
  }

  Future<void> _fetchCategoryDetails() async {
    try {
      final fetchedCategory = await ApiService.getCategoryById(widget.categoryId);
      setState(() {
        venueCard = fetchedCategory;
        isLoading = false;
      });
    } catch (e) {
      print('Fetch Exception: $e');
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  Future<void> _bookCategory() async {
    try {
      await ApiService.bookCategory(widget.categoryId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking successful!')),
      );
    } catch (e) {
      print('Booking Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to book category')),
      );
    }
  }

  Future<void> _submitReview() async {
    try {
      await ApiService.submitReview(widget.categoryId, _rating, _reviewController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review submitted successfully!')),
      );
      _reviewController.clear(); // Clear the review input field
    } catch (e) {
      print('Review Submission Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit review')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/Venue.png', // Path to the logo image
              height: 40.0, // Adjust height if necessary
            ),
            const SizedBox(width: 8.0),
          ],
        ),
        backgroundColor: Colors.red[50],
        elevation: 0, // Optional: Remove shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.red[50],
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError || venueCard == null
          ? const Center(child: Text('Error loading category details'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                'http://192.168.1.70:5500${venueCard!.photo ?? ''}',
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
              venueCard!.name ?? 'No Name',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 8.0),
            Text(
              venueCard!.info ?? 'No Info',
              style: const TextStyle(fontSize: 18.0),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 8.0),
            Text(
              '\$${venueCard!.price?.toString() ?? "N/A"}',
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _bookCategory,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // Button color
              ),
              child: const Text('Book Now'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _reviewController,
              decoration: const InputDecoration(
                labelText: 'Leave a review',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 8.0),
            Slider(
              value: _rating,
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: (value) {
                setState(() {
                  _rating = value;
                });
              },
              label: 'Rating: ${_rating.toStringAsFixed(1)}',
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // Button color
              ),
              child: const Text('Submit Review'),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
