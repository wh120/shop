import 'package:flutter/material.dart';

import '../../data/products_list_response.dart';

class ColorIndicatorView extends StatelessWidget {
  const ColorIndicatorView({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {

    return Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
            shape: BoxShape.circle,


            border: Border.all(
              width: 1,
              color: Colors.grey,
              style: BorderStyle.solid,
            ),

                ));
  }
}
