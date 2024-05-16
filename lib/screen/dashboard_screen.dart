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
                height: 500,
                width: 500,// Adjust the height as needed
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
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
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
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
