import 'dart:async';
import 'package:flutter/material.dart';
import 'package:venuevendor/features/home/presentation/presentation/view/search_view.dart';

import '../../../../../core/networking/local/api_service.dart';
import '../../data/dto/get_all_categories_dto.dart';
import '../../data/model/venue_card.dart';
import 'category_detail_view.dart'; // Import CategoryDetailView

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  List<VenueCard> venueCards = [];
  List<VenueCard> filteredVenueCards = [];
  int visibleCount = 4; // Initial number of visible items
  bool isLoading = false;
  bool isSearching = false; // Flag to determine if we are searching
  String searchQuery = ''; // Store the current search query
  String selectedSortOption = 'Price: Low to High'; // Default sort option

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
        filteredVenueCards = venueCards; // Initialize filtered list
        _sortVenueCards(); // Apply the default sorting
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
        visibleCount = (visibleCount + 4 <= filteredVenueCards.length)
            ? visibleCount + 4
            : filteredVenueCards.length; // Ensure you don't go out of bounds
      });
    });
  }

  void _searchCategories(String query) {
    setState(() {
      searchQuery = query;
      isSearching = query.isNotEmpty;

      if (isSearching) {
        filteredVenueCards = venueCards.where((card) {
          final name = card.name?.toLowerCase() ?? '';
          final info = card.info?.toLowerCase() ?? '';
          final lowerQuery = query.toLowerCase();
          return name.contains(lowerQuery) || info.contains(lowerQuery);
        }).toList();
      } else {
        filteredVenueCards = venueCards;
      }

      _sortVenueCards(); // Reapply sorting after searching
      visibleCount = 4; // Reset visible count
    });
  }

  void _sortVenueCards() {
    setState(() {
      if (selectedSortOption == 'Price: Low to High') {
        filteredVenueCards.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
      } else if (selectedSortOption == 'Price: High to Low') {
        filteredVenueCards.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
      }
    });
  }

  void _onSortOptionChanged(String? newValue) {
    setState(() {
      selectedSortOption = newValue ?? 'Price: Low to High';
      _sortVenueCards(); // Apply sorting
    });
  }

  void _navigateToSearchPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[50],
        actions: [
          PopupMenuButton<String>(
            onSelected: _onSortOptionChanged,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Price: Low to High',
                child: Text('Price: Low to High'),
              ),
              const PopupMenuItem(
                value: 'Price: High to Low',
                child: Text('Price: High to Low'),
              ),
            ],
            icon: Icon(Icons.sort, color: Colors.red[700]),
          ),
        ],
      ),
      backgroundColor: Colors.red[50],
      body: isLoading && venueCards.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        itemCount: visibleCount,
        itemBuilder: (context, index) {
          if (index < filteredVenueCards.length) {
            return VenueCardWidget(venueCard: filteredVenueCards[index]);
          } else if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToSearchPage,
        backgroundColor: Colors.red,
        child: const Icon(Icons.search),
      ),
    );
  }
}

class VenueCardWidget extends StatefulWidget {
  final VenueCard venueCard;

  const VenueCardWidget({super.key, required this.venueCard});

  @override
  _VenueCardWidgetState createState() => _VenueCardWidgetState();
}

class _VenueCardWidgetState extends State<VenueCardWidget> {
  bool _isHovering = false;

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    final baseUrl = 'http://192.168.1.70:5500';

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailView(
                categoryId: widget.venueCard.id ?? '', // Pass the category ID
              ),
            ),
          );
        },
        child: Transform.scale(
          scale: _isHovering ? 1.02 : 1.0, // Slightly scale up on hover
          child: Card(
            elevation: _isHovering ? 10.0 : 4.0, // Increase elevation on hover
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      '$baseUrl${widget.venueCard.photo ?? ''}', // Construct the image URL
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
                        return const Center(
                            child: Icon(Icons.error, color: Colors.red));
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    widget.venueCard.name ?? 'No Name',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.venueCard.info ?? 'No Info',
                    style: const TextStyle(fontSize: 16.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '\$${widget.venueCard.price?.toString() ?? "N/A"}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
