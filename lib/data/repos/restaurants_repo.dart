import 'package:dinner_dice/data/repos/base_repo.dart';
import 'package:dinner_dice/utils/secrets.dart';
import 'package:flutter/foundation.dart';
import 'package:google_place/google_place.dart';
import 'package:package_info_plus/package_info_plus.dart';

class RestaurantsRepo extends BaseRepo {
  // restaurants repo class

  Future<NearBySearchResponse?> getRestaurants() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Map<String, String> headers = <String, String>{
      if (defaultTargetPlatform == TargetPlatform.iOS)
        'x-ios-bundle-identifier': packageInfo.packageName,
      if (defaultTargetPlatform == TargetPlatform.android) ...{
        'x-android-package': packageInfo.packageName,
        'x-android-cert': "SHA1_SIGNING_KEY",
      }
    };
    if (kDebugMode) {
      headers = {};
    }
    final googlePlace = GooglePlace(Secrets.PLACES_API_KEY, headers: headers);
    final result = await googlePlace.search.getNearBySearch(
      Location(
        lat: 54.5181885,
        lng: -1.5675516,
      ),
      5000,
      type: "restaurant",
      opennow: true,
    );

    return result;
  }
}
