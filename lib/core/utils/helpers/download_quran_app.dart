import 'dart:io';

import '../../device/device_utility.dart';

Future<void> downloadQuranApp() async {
  if (Platform.isAndroid) {
    DDeviceUtils.launchUrl("https://play.google.com/store/apps/details?id=sa.QuranComplex.QuranHafs&pcampaignid=web_share");
  } else if (Platform.isIOS) {
    DDeviceUtils.launchUrl("https://apps.apple.com/us/app/quran-hafs-by-kfgqpc/id1616321992");
  }
}
