import 'package:flutter/material.dart';
import 'package:grocery_app/feature/home/models/product_model.dart';

class ProductTleWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  const ProductTleWidget({super.key, required this.productDataModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(productDataModel.imageUrl))),
          ),
          Text(productDataModel.name),
          Text(productDataModel.description)
        ],
      ),
    );
  }
}
