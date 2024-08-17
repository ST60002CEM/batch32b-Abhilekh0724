import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../../../../../core/networking/local/api_service.dart';
import '../../../../../screen/presentation/view/bottom_view/dashboard_view.dart';
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
  DateTime? _selectedDate;
  double? _rating;
  String? _comment;

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

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _bookCategory() async {
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a booking date')),
      );
      return;
    }

    final userId = '66b4690da3c2323e47087524'; // Use the logged-in user's ID
    try {
      await ApiService.bookCategory(widget.categoryId, userId, _selectedDate!);
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
    if (_rating == null || _comment == null || _comment!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide a rating and comment')),
      );
      return;
    }

    try {
      await ApiService.submitReview(widget.categoryId, _rating!, _comment!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review submitted successfully!')),
      );
      setState(() {
        _rating = null;
        _comment = null;
      });
    } catch (e) {
      print('Review Exception: $e');
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
        leading: ModalRoute.of(context)?.settings.name != '/dashboard'
            ? IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        )
            : null, // Hide back button when viewing DashboardView
      ),
      backgroundColor: Colors.red[50],
      body: isLoading
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16.0),
            Text('Loading category details...'),
          ],
        ),
      )
          : hasError || venueCard == null
          ? const Center(child: Text('Error loading category details'))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  'http://192.168.1.70:5500${venueCard!.photo ?? ''}',
                  height: 250.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) {
                      return child;
                    } else {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16.0),
                            Text('Loading image...'),
                          ],
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.error, color: Colors.red),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                venueCard!.name ?? 'No Name',
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 8.0),
              Text(
                venueCard!.info ?? 'No Info',
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 8.0),
              Text(
                '\$${venueCard!.price?.toString() ?? "N/A"}',
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 24.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        _selectedDate != null
                            ? 'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'
                            : 'No Date Selected',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: _selectDate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[300],
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Select Date',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _bookCategory,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Leave a Review',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Comment',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    _comment = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text(
                    'Rating: ',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Expanded(
                    child: Slider(
                      value: _rating ?? 0,
                      onChanged: (value) {
                        setState(() {
                          _rating = value;
                        });
                      },
                      min: 0,
                      max: 5,
                      divisions: 5,
                      label: _rating?.toString(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[300],
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Submit Review',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
