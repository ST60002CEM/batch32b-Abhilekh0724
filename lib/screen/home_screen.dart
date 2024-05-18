import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[50],
      ),
      backgroundColor: Colors.red[50],
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          VenueCard(
            imagePath: 'assets/images/AOne.jpg',
            venueName: 'AONE',
            description: 'This is a description for Venue 1.',
          ),
          SizedBox(height: 16.0),
          VenueCard(
            imagePath: 'assets/images/jeremy.jpg',
            venueName: 'Venue 2',
            description: 'This is a description for Venue 2.',
          ),
          SizedBox(height: 16.0),
          VenueCard(
            imagePath: 'assets/images/Party.jpg',
            venueName: 'Venue 3',
            description: 'This is a description for Venue 3.',
          ),
          VenueCard(
            imagePath: 'assets/images/Dar.jpg',
            venueName: 'Venue 4',
            description: 'This is a description for Venue 4.',
          ),
        ],
      ),
    );
  }
}

class VenueCard extends StatelessWidget {
  final String imagePath;
  final String venueName;
  final String description;

  const VenueCard({
    super.key,
    required this.imagePath,
    required this.venueName,
    required this.description,
  });

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
          ],
        ),
      ),
    );
  }
}