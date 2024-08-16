import 'dart:async';
import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venuevendor/features/book/presentation/view/booking_view.dart';
import 'package:venuevendor/features/profile/presentation/view/profile_view.dart'; // Import ProfilePage
import 'package:venuevendor/screen/checkout_screen.dart';
import 'package:venuevendor/screen/map_screen.dart';
import 'package:venuevendor/app/navigator_key/navigator_key.dart';
import 'package:venuevendor/screen/presentation/view/bottom_view/profile_view.dart';


import '../../../../features/home/presentation/presentation/view/home_view.dart';
import '../../../../features/home/presentation/presentation/view/search_view.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  List<double> _accelerometerValue = [];
  final List<StreamSubscription<dynamic>> _streamSubscriptions = [];
  double _lastX = 0, _lastY = 0, _lastZ = 0;
  int _shakeThreshold = 40;
  bool _canDetectShake = true;
  Duration debounceDuration = const Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    if (accelerometerEvents != null) {
      _streamSubscriptions.add(accelerometerEvents!.listen((event) {
        if (mounted) {
          setState(() {
            _accelerometerValue = [event.x, event.y, event.z];
          });

          double deltaX = (event.x - _lastX).abs();
          double deltaY = (event.y - _lastY).abs();
          double deltaZ = (event.z - _lastZ).abs();

          if (_canDetectShake && (deltaX > _shakeThreshold || deltaY > _shakeThreshold || deltaZ > _shakeThreshold)) {
            _onShake();
            _canDetectShake = false;
            Future.delayed(debounceDuration, () {
              if (mounted) {
                _canDetectShake = true;
              }
            });
          }

          _lastX = event.x;
          _lastY = event.y;
          _lastZ = event.z;
        }
      }));
    }
  }

  @override
  void dispose() {
    for (var subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  void _onShake() {
    _showReportDialog();
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _controller = TextEditingController();

        return AlertDialog(
          title: const Text('Report a Problem'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: "Describe the issue"),
            maxLines: 3,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                // Handle the submission
                String problemDescription = _controller.text;
                Navigator.of(context).pop();
                showMySnackBar(
                  message: 'Problem reported successfully!',
                  color: Colors.green,
                );
                // Optionally, handle the submitted problem description
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    List<Widget> lstBottomScreen = [
      const HomeView(),
      BookingView(userId: '66b4690da3c2323e47087524'),
      ProfilePage(),
      const MapScreen(),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Container(
          padding: const EdgeInsets.only(top: 20.0),
          child: AppBar(
            backgroundColor: Colors.red[50],
            leading: IconButton(
              icon: const Icon(
                Icons.search,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
            ),
            title: const Center(
              child: Image(
                image: AssetImage(
                  'assets/icons/Venue.png',
                ),
                height: 70,
                width: 70,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.person,
                  size: 30.0,
                ),
                onPressed: () {
                  ref.read(selectedIndexProvider.notifier).state = 2; // Switch to ProfilePage
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
        iconSize: 40.0,
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
            icon: Icon(Icons.map),
            label: 'Location',
          ),
        ],
      ),
    );
  }
}

void showMySnackBar({
  required String message,
  Color? color,
}) {
  ScaffoldMessenger.of(
    AppNavigator.navigatorKey.currentState!.context,
  ).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color ?? Colors.green,
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
