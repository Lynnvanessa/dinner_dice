import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../data/repos/restaurants_repo.dart';

void main() async {
  test(
    'get nearby restaurants',
    () async {
      final restaurantsRepo = RestaurantsRepo();
      final response = await restaurantsRepo.getRestaurants();
      expect(response, isNotNull);
    },
    onPlatform: {
      "windows": [
        const Skip("skip windows platform"),
      ]
    },
  );
}
