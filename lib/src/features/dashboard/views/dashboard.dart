import 'package:bitbust/src/components/bold_header.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        leadingWidth: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            LightHeader(
              text: "Good morning",
              fontSize: 12,
            ),
            BoldHeader(
              text: "Kolade Kolawole",
              fontSize: 14,
            )
          ],
        ),
        actions: [
          SvgPicture.asset("assets/svg/notification.svg"),
          const XMargin(5),
          const CircleAvatar(radius: 12, backgroundColor: Colors.black),
          const XMargin(15),
        ],
      ),
      body: const Column(),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.greye8))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [CircleAvatar(radius: 3, backgroundColor: AppColors.grey900), SvgPicture.asset("assetName")],
            )
          ],
        ),
      ),
    );
  }
}
