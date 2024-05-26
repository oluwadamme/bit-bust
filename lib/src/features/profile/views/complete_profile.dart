import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompleteProfilePage extends StatefulHookConsumerWidget {
  const CompleteProfilePage({super.key});
  static const String routeName = "/complete_profile";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends ConsumerState<CompleteProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
