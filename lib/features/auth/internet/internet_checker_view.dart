import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venuevendor/core/common/internet_checker/internet_checker_view_model.dart';

class InternetCheckerView extends ConsumerWidget {
  const InternetCheckerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //check for internet
    final connectivityStatus=ref.watch(connectivityStatusProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet Checker'),
      ),
      body: connectivityStatus==ConnectivityStatus.isConnected
        ?const Center(
        child: Text('connected'),
      )
          : const Center(
        child: Text('disconnected'),
      )
    );
  }
}
