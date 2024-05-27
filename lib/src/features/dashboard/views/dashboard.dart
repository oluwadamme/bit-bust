import 'package:bitbust/src/features/dashboard/data/controllers/nav_controller.dart';
import 'package:bitbust/src/features/dashboard/views/home_page.dart';
import 'package:bitbust/src/features/profile/views/profile_page.dart';
import 'package:bitbust/src/features/dashboard/views/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardPage extends StatefulHookConsumerWidget {
  const DashboardPage({super.key});
  static const String routeName = "/dashboard";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: ref.watch(dashNavProvider),
        children: const [
          Homepage(),
          Text("data"),
          Text("data"),
          Text("data"),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
