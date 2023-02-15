import 'package:flutter/material.dart';


import '../../data/products_list_response.dart';
import 'color_indicator_view.dart';
import 'rating_view.dart';

class ProductItemView extends StatelessWidget {
  const ProductItemView(
      {Key? key,
      required this.product,
      this.imageAlignment = Alignment.center,
      this.onProductPressed})
      : super(key: key);

  final Product product;
  final Alignment imageAlignment;
  final Function()? onProductPressed;

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
        onProductPressed?.call( );
      },
      child: SizedBox(
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network('${product.thumbnail}',
                      alignment: imageAlignment, fit: BoxFit.cover)),

            ],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${product.brand}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: Theme.of(context).textTheme.caption),
                Text('${product.title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: Theme.of(context).textTheme.bodyText1),
                if (product.description?.isNotEmpty == true)
                  Text('${product.description}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontSize: 12, color: Colors.grey)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),

                ),
                Row(
                  children: [
                    Text('${product.price} \$',
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent
                        )),


                  ],
                ),
                RatingView(
                    value: product.rating?.toInt()??0,
                     ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
