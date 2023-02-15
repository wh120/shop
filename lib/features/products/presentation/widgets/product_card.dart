import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:store/features/products/data/products_list_response.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return productCard(context,product.thumbnail! ,product.price.toString());
  }
  Stack productCard(BuildContext context,String imageUrl,String price) {
    return Stack(
      children: [
         Padding(
          padding: const EdgeInsets.only(right:5.0,left:5.0,top: 15,bottom: 15),
          child: Card(
            elevation: 10,
            child: Container(
              width: MediaQuery.of(context).size.width*0.40,
              height: MediaQuery.of(context).size.height*0.35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.transparent,
                  image: DecorationImage(image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,

                  )
              ),
              //child: Image.network(imageUrl,fit: BoxFit.cover, ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 40,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                width: 70,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.8),
                ),
                child: Center(child: Text('\$$price',style: TextStyle(color: Colors.white,fontFamily: 'Ubuntu',letterSpacing: 1,fontWeight: FontWeight.w500),)),
              ),

            ),
          ),
        ),

      ],
    );
  }

  f(){

  }
}
