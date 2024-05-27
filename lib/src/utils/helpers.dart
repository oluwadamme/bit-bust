// ignore_for_file: deprecated_member_use

import 'dart:developer' as dev;
import 'package:bitbust/src/utils/utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class Helpers {
  static Duration animationDuration = const Duration(milliseconds: 400);

  static Future<void> copyToClipboard({
    required BuildContext context,
    required String copyValue,
    String? snackBarMessage,
  }) {
    return Clipboard.setData(ClipboardData(text: copyValue)).then((_) {
      ToastUtil.showSuccessToast(context, "Copied!!");
    });
  }

  // static Future<void> launch(String url, {LaunchMode mode = LaunchMode.externalApplication}) async {
  //   if (!await launchUrl(Uri.parse(url), mode: mode)) {
  //     throw Exception('Could not launch $url');
  //   }
  // }

  static String formatIntDate(String time) {
    if (time.length > 3) {
      final first2Num = time.substring(0, 2);
      final last2Num = time.substring(2);

      return "$first2Num:$last2Num";
    }
    final first2Num = time.substring(0, 1);
    final last2Num = time.substring(1);
    return "0$first2Num:$last2Num";
  }

  static void sendFeedback({int level = 1}) {
    level == 1
        ? HapticFeedback.lightImpact()
        : level == 2
            ? HapticFeedback.mediumImpact()
            : HapticFeedback.heavyImpact();
  }

  static Future<XFile?> selectImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      // Pick an image.
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      return image;
    } catch (e, st) {
      Helpers.logc(e, error: true, stackTrace: st);
    }
    return null;
  }

  static Future<XFile?> takeImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      // Pick an image.
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      return image;
    } catch (e, st) {
      Helpers.logc(e, error: true, stackTrace: st);
    }
    return null;
  }

  static void logc(Object? o, {bool error = false, StackTrace? stackTrace}) {
    if (kDebugMode) {
      if (error) {
        dev.log("🐛 => $o");
        FirebaseCrashlytics.instance.recordError(o, stackTrace);
      } else {
        dev.log("✅ => $o");
      }
    }
  }

  static bool isTodayDate(DateTime date) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    return date == today;
  }

  static double toDouble(dynamic data) {
    if (data.runtimeType == double) {
      return data;
    } else if (data.runtimeType == int) {
      return int.parse(data.toString()).toDouble();
    } else if (data.runtimeType == String) {
      return double.parse(data);
    } else if (data == null) {
      return 0.0;
    } else {
      return data;
    }
  }

  static void closeKeyboard(BuildContext context) {
    if (FocusScope.of(context).hasPrimaryFocus || FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  static Widget svg(String asset, {Color color = AppColors.greye8, BoxFit fit = BoxFit.contain}) {
    return SvgPicture.asset(
      asset,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      fit: fit,
    );
  }
}
