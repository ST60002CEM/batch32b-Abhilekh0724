import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venuevendor/features/home/presentation/view/bottom_view/profile_view.dart';
import 'package:venuevendor/features/home/presentation/view/home_view.dart';
import 'package:venuevendor/screen/checkout_screen.dart';
import 'package:venuevendor/screen/home_screen.dart';
import 'package:venuevendor/screen/map_screen.dart';
import 'package:venuevendor/screen/profile_screen.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class DashboardView extends ConsumerWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    List<Widget> lstBottomScreen = [
      const HomeView(),
      const CheckoutScreen(),
      const ProfileView(),
      const MapScreen(),
    ];

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
                size: 30.0, // Adjust the size as needed
              ),
              onPressed: () {
                // Handle search action
              },
            ),
            title: const Center(
              child: Image(
                image: AssetImage(
                  'assets/icons/Venue.png', // Path to the logo image
                ),
                height: 70,
                width: 70, // Adjust the height as needed
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.person,
                  size: 30.0, // Adjust the size as needed
                ),
                onPressed: () {
                  ref.read(selectedIndexProvider.notifier).state = 2; // Navigate to the Profile screen
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.red[50],
      body: lstBottomScreen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[600],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: selectedIndex,
        onTap: (index) {
          ref.read(selectedIndexProvider.notifier).state = index;
        },
        type: BottomNavigationBarType.fixed,
        iconSize: 40.0, // Adjust the size as needed
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
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Location',
          ),
        ],
      ),
    );
  }
}