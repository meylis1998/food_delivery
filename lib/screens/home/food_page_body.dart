import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../models/products_model.dart';
import '../../utils/app_constants.dart';
import '../../widgets/big_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController controller = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;
  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        _currPageValue = controller.page!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Column(
      children: [
        //Slider Section
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return popularProducts.isLoaded
                ? Container(
                    height: Dimensions.pageView,
                    child: PageView.builder(
                      controller: controller,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, index) {
                        return _buildPageItem(
                            index, popularProducts.popularProductList[index]);
                      },
                    ),
                  )
                : Container(
                    height: Dimensions.pageView,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                        color: AppColors.mainColor),
                  );
          },
        ),

        //Dots
        GetBuilder<PopularProductController>(
          builder: (popularProducts) => DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18, 9),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),

        // Popular Text
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(width: Dimensions.width20),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: '.',
                  color: Colors.black26,
                ),
              ),
              SizedBox(width: Dimensions.width20),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: 'Food pairing'),
              )
            ],
          ),
        ),

        // list of food and images
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProductController) {
          return recommendedProductController.isLoaded
              ? ListView.separated(
                  separatorBuilder: (context, index) =>
                      SizedBox(height: Dimensions.height10 / 2),
                  itemCount: recommendedProductController
                      .recommendedProductList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        // Image Section
                        Container(
                          height: Dimensions.listViewImgSize,
                          width: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.amber[400],
                            image: DecorationImage(
                              image: NetworkImage(
                                AppConstants.BASE_URI +
                                    AppConstants.UPLOAD_URI +
                                    recommendedProductController
                                        .recommendedProductList[index].img!,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // text container
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextContSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight:
                                    Radius.circular(Dimensions.radius20),
                              ),
                              color: Colors.grey.shade200,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: Dimensions.width10,
                                right: Dimensions.width10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(
                                    text: recommendedProductController
                                        .recommendedProductList[index].name!,
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  Expanded(
                                    child: SmallText(
                                      text: recommendedProductController
                                          .recommendedProductList[index]
                                          .description!,
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      IconAndTextWidget(
                                        icon: Icons.circle_sharp,
                                        text: 'Normal',
                                        iconColor: AppColors.iconColor1,
                                      ),
                                      IconAndTextWidget(
                                        icon: Icons.location_on,
                                        text: '1.7 km',
                                        iconColor: AppColors.mainColor,
                                      ),
                                      IconAndTextWidget(
                                        icon: Icons.access_time_rounded,
                                        text: '32min',
                                        iconColor: AppColors.iconColor2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(color: AppColors.mainColor),
                );
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.width10, top: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven
                  ? const Color(0xFF69c5df)
                  : const Color(0xFF9294cc),
              image: DecorationImage(
                image: NetworkImage(
                  AppConstants.BASE_URI +
                      AppConstants.UPLOAD_URI +
                      popularProduct.img!,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width30 * 1.5,
                right: Dimensions.width30 * 1.5,
                bottom: Dimensions.height30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5)),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                  left: Dimensions.height15,
                  right: Dimensions.height15,
                  top: Dimensions.height10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: popularProduct.name!),
                    SizedBox(height: Dimensions.height10),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                            5,
                            (index) => const Icon(Icons.star,
                                color: AppColors.mainColor, size: 15),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SmallText(text: '4.5'),
                        const SizedBox(width: 10),
                        SmallText(text: '1287 comments'),
                      ],
                    ),
                    SizedBox(height: Dimensions.height20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        IconAndTextWidget(
                          icon: Icons.circle_sharp,
                          text: 'Normal',
                          iconColor: AppColors.iconColor1,
                        ),
                        IconAndTextWidget(
                          icon: Icons.location_on,
                          text: '1.7 km',
                          iconColor: AppColors.mainColor,
                        ),
                        IconAndTextWidget(
                          icon: Icons.access_time_rounded,
                          text: '32min',
                          iconColor: AppColors.iconColor2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
