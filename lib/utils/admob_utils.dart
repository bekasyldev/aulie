import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:granth_flutter/configs.dart';
import 'package:nb_utils/nb_utils.dart';

BannerAd createBannerAd() {
  return BannerAd(
    request: AdRequest(),
    adUnitId: Platform.isAndroid ? BANNER_ID_ANDROID : BANNER_ID_IOS,
    size: AdSize.banner,
    listener: BannerAdListener(),
  );
}

Future<InterstitialAd?> createInterstitialAd() async {
  InterstitialAd? interstitialAd;
  await InterstitialAd.load(
    adUnitId: Platform.isAndroid ? INTERSTITIAL_ID_ANDROID : INTERSTITIAL_ID_IOS,
    request: AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (InterstitialAd ad) {
        print('$ad loaded');
        ad.show();
      },
      onAdFailedToLoad: (LoadAdError error) {
        throw error.message;
      },
    ),
  );
  log(interstitialAd);
  return interstitialAd;
}
