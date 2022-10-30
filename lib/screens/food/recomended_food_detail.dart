import 'package:flutter/material.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height20),
              child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                alignment: Alignment.center,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.height20),
                    topRight: Radius.circular(Dimensions.height20),
                  ),
                ),
                child: BigText(text: 'Chinese Side', size: Dimensions.font26),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: const FlexibleSpaceBar(
              background: SizedBox(width: double.maxFinite, height: 100),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Column(
                children: const [
                  ExpandableText(
                    text:
                        'This Napa Cabernet is concentrated and shows a purple color with ruby hues. The nose presents shade-grown tobacco leaves and dried herbs hovering around ripe blackberries and currants over a spice-infused palate of polished tannins reminiscent of cinnamon and vanilla that extends over a persistent aftertaste.This Napa Cabernet is concentrated and shows a purple color with ruby hues. The nose presents shade-grown tobacco leaves and dried herbs hovering around ripe blackberries and currants over a spice-infused palate of polished tannins reminiscent of cinnamon and vanilla that extends over a persistent aftertaste.This Napa Cabernet is concentrated and shows a purple color with ruby hues. The nose presents shade-grown tobacco leaves and dried herbs hovering around ripe blackberries and currants over a spice-infused palate of polished tannins reminiscent of cinnamon and vanilla that extends over a persistent aftertaste.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Dimensions.width20 * 2.5,
              vertical: Dimensions.height10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  iconSize: Dimensions.iconSize24,
                  icon: Icons.remove,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                ),
                BigText(
                  text: '\$12.88 X 0',
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font26,
                ),
                AppIcon(
                  iconSize: Dimensions.iconSize24,
                  icon: Icons.add,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                ),
              ],
            ),
          ),
          Container(
            height: Dimensions.bottomHeight,
            padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20,
            ),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.height20,
                        horizontal: Dimensions.height20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white),
                    child:
                        const Icon(Icons.favorite, color: AppColors.mainColor)),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.height20,
                      horizontal: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor),
                  child: BigText(
                    text: '\$10 | Add to cart',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 19),
        child: FloatingActionButton(
          onPressed: () {},
        ),
      ),
    );
  }
}
