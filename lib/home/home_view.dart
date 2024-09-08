import 'package:climbing_wall/climbing_wall/climbing_wall_widget.dart';
import 'package:climbing_wall/hold_coords.dart';
import 'package:climbing_wall/home/route_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Climbing wall widget',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ClimbingWallWidget(
        rows: 10,
        columns: 30,
        holdChild: (coords) {
          return Text('${coords.row},${coords.column}');
        },
        onPressed: (hold) {
          if (ref.read(routeProvider).contains(hold)) {
            ref.read(routeProvider.notifier).state.remove(hold);
          } else {
            ref.read(routeProvider.notifier).state.add(hold);
          }
          if (kDebugMode) {
            print(hold.toString());
          }
        },
        holdColor: (hold) {
          if (ref.read(routeProvider).contains(hold)) {
            return Colors.red;
          }
          return null;
        },
        defaultHoldColor: Colors.black12,
      ),
    );
  }
}
