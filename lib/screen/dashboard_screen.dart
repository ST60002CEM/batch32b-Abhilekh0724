import 'package:flutter/material.dart';
import 'package:venuevendor/screen/checkout_screen.dart';
import 'package:venuevendor/screen/home_screen.dart';
import 'package:venuevendor/screen/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  List<Widget> lstBottomScreen = [
    const HomeScreen(),
    const CheckoutScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), // Height of the AppBar
        child: Container(
          padding: const EdgeInsets.only(top: 20.0), // Padding to bring the AppBar down
          child: AppBar(
            backgroundColor: Colors.red[50],
            leading: IconButton(
              icon: const Icon(
                Icons.search,
                size: 30.0,  // Adjust the size as needed
              ),
              onPressed: () {
                // Handle search action
              },
            ),
            title: Center(
              child: Image.asset(
                'assets/icons/Venue.png', // Path to the logo image
                height: 70,
                width: 70, // Adjust the height as needed
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.person,
                  size: 30.0,  // Adjust the size as needed
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2; // Navigate to the Profile screen
                  });
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.red[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lstBottomScreen[_selectedIndex],
              const SizedBox(height: 20),
              _buildSectionTitle('Management List'),
              _buildManagementList(),
              const SizedBox(height: 20),
              _buildSectionTitle('Services'),
              _buildServicesList(),
              const SizedBox(height: 20),
              _buildSectionTitle('Recently Viewed'),
              _buildRecentlyViewedList(),
              const SizedBox(height: 20),
              _buildSectionTitle('Venue Options'),
              _buildVenueOptionsList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[600],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        iconSize: 40.0,  // Adjust the size as needed
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildManagementList() {
    return _buildSection(
      [
        _buildListTile('Booking Checklist', Icons.check_circle_outline, () {
          // Navigate to booking checklist screen or handle action
        }),
        _buildListTile('Task Manager', Icons.list_alt, () {
          // Navigate to task manager screen or handle action
        }),
      ],
    );
  }

  Widget _buildServicesList() {
    return _buildSection(
      [
        _buildListTile('Photographer', Icons.camera_alt, () {
          // Navigate to photographer screen or handle action
        }),
        _buildListTile('Makeup Artist', Icons.brush, () {
          // Navigate to makeup artist screen or handle action
        }),
        _buildListTile('Caterer', Icons.restaurant, () {
          // Navigate to caterer screen or handle action
        }),
        _buildListTile('Decorator', Icons.event, () {
          // Navigate to decorator screen or handle action
        }),
      ],
    );
  }

  Widget _buildRecentlyViewedList() {
    return _buildSection(
      [
        _buildListTile('Venue 1', Icons.place, () {
          // Navigate to venue detail screen or handle action
        }),
        _buildListTile('Venue 2', Icons.place, () {
          // Navigate to venue detail screen or handle action
        }),
        _buildListTile('Venue 3', Icons.place, () {
          // Navigate to venue detail screen or handle action
        }),
      ],
    );
  }

  Widget _buildVenueOptionsList() {
    return _buildSection(
      [
        _buildListTile('Wedding Venues', Icons.local_activity, () {
          // Navigate to wedding venue options screen or handle action
        }),
        _buildListTile('Conference Venues', Icons.business_center, () {
          // Navigate to conference venue options screen or handle action
        }),
        _buildListTile('Party Venues', Icons.celebration, () {
          // Navigate to party venue options screen or handle action
        }),
        _buildListTile('Outdoor Venues', Icons.park, () {
          // Navigate to outdoor venue options screen or handle action
        }),
      ],
    );
  }

  Widget _buildSection(List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
