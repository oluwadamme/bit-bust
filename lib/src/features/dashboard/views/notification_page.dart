import 'package:bitbust/src/components/bold_header.dart';
import 'package:bitbust/src/components/components.dart';
import 'package:bitbust/src/utils/app_color.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulHookConsumerWidget {
  const NotificationPage({super.key});
  static const String routeName = "/notification";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const CustomBackButton(),
        title: const BoldHeader(text: "Notifications"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                LightHeader(
                  text: "All Notifications",
                  fontSize: 14,
                  color: AppColors.grey5D,
                ),
                Spacer(),
                LightHeader(
                  text: "Mark all as read",
                  fontSize: 14,
                  color: AppColors.purple7B,
                ),
                XMargin(30)
              ],
            ),
          ),
          const YMargin(10),
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BoldHeader(text: "${index + 1}"),
                      ...List.generate(
                        index + 1,
                        (index) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.greyF0))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 3,
                                          backgroundColor: AppColors.blue17,
                                        ),
                                        XMargin(7),
                                        BoldHeader(text: "Deposit", fontSize: 16)
                                      ],
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "Your deposit of ",
                                        style: mediumStyle(14, AppColors.grey8B),
                                        children: [
                                          TextSpan(
                                            text: "0.000045BTC ",
                                            style: mediumStyle(14, AppColors.grey2E),
                                          ),
                                          const TextSpan(text: "was successful.")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              LightHeader(
                                text: DateFormat("hh:mm a").format(DateTime.now()).toLowerCase(),
                                fontSize: 14,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) => const YMargin(10),
                itemCount: 4),
          )
        ],
      ),
    );
  }
}
