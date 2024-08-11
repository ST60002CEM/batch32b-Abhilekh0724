import 'package:flutter/material.dart';
import 'package:venuevendor/core/networking/local/api_service.dart';
import '../../data/dto/get_all_categories_dto.dart';
import '../../data/model/venue_card.dart';
import 'category_detail_view.dart'; // Import CategoryDetailView

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<VenueCard> venueCards = [];
  List<VenueCard> filteredVenueCards = [];
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchVenueCards();
  }

  Future<void> _fetchVenueCards() async {
    setState(() {
      isLoading = true;
    });
    try {
      GetAllCategoriesDTO dto = await ApiService.getCategories();
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

  void _search() {
    setState(() {
      searchQuery = _searchController.text;
      _filterCards(searchQuery);
    });
  }

  void _filterCards(String query) {
    setState(() {
      filteredVenueCards = venueCards.where((card) {
        final name = card.name?.toLowerCase() ?? '';
        final info = card.info?.toLowerCase() ?? '';
        final lowerQuery = query.toLowerCase();
        return name.contains(lowerQuery) || info.contains(lowerQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[50],
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _search,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.red[50],
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : searchQuery.isEmpty
          ? const Center(child: Text('Enter a search query'))
          : filteredVenueCards.isEmpty
          ? const Center(child: Text('No results found'))
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: filteredVenueCards.length,
        itemBuilder: (context, index) {
          return VenueCardWidget(venueCard: filteredVenueCards[index]);
        },
      ),
    );
  }
}

class VenueCardWidget extends StatelessWidget {
  final VenueCard venueCard;

  const VenueCardWidget({Key? key, required this.venueCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseUrl = 'http://192.168.1.70:5500'; // Update with your base URL

    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            '$baseUrl${venueCard.photo ?? ''}', // Construct the image URL
            height: 60.0,
            width: 60.0,
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
        title: Text(venueCard.name ?? 'Unknown'),
        subtitle: Text(venueCard.info ?? 'No information'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailView(categoryId: venueCard.id),
            ),
          );
        },
      ),
    );
  }
}
