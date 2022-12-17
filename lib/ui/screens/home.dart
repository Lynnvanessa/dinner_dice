import 'package:diner_dice/data/providers/home_provider.dart';
import 'package:diner_dice/ui/theme/colors.dart';
import 'package:diner_dice/ui/theme/typography.dart';
import 'package:diner_dice/ui/widgets/restaurant_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Consumer<HomeProvider>(builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: Text(
                    "Diner Dice",
                    style: AppTypography.headline(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Visibility(
                  visible: !provider.searching,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 10, left: 12, right: 12),
                            child: const Text(
                              "Get all open restaurants near you and a random selection from our dice.",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: provider.searching
                                ? null
                                : provider.getRestaurants,
                            child: const Text("Roll the Dice"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Visibility(
                    visible: provider.searching,
                    child: Image.asset(
                      "assets/icons/dice.gif",
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                if (provider.selectedRestaurant != null)
                  Visibility(
                    visible: provider.selectedRestaurant != null &&
                        !provider.searching,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 12, right: 12),
                          child: Text(
                            "Random pick",
                            style: AppTypography.bodyBold(
                                color: AppColors.primary),
                          ),
                        ),
                        RestaurantPreview(
                          provider.selectedRestaurant!,
                          isDiceSelected: true,
                        ),
                      ],
                    ),
                  ),
                Visibility(
                  visible:
                      provider.restaurants.isNotEmpty && !provider.searching,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("restaurants/nearby");
                      },
                      child: Text(
                          "see ${provider.restaurants.length}+ other nearby restaurants"),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
