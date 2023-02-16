import 'package:flutter/material.dart';
import 'package:store/features/products/data/products_list_response.dart';
import '../../../../core/widgets/sliders/carousel_with_indicator.dart';

import '../widgets/rating_view.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
              CarouselWithIndicator(
                imgList: List.generate(
                    widget.product.images!.length,
                    (index) => CarouselSlide(
                        imagePath: widget.product.images![index])),
              ),
              Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: <Widget>[
                    SizedBox(
                        width: double.infinity,
                        child: Text(widget.product.brand ?? "",
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.left)),
                    const SizedBox(height: 7),

                    SizedBox(
                        width: double.infinity,
                        child: Text(widget.product.title ?? "",
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.left)),
                    const SizedBox(height: 8),
                    Text('${widget.product.description}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text('${widget.product.price} \$',
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            softWrap: false,
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent
                            )),


                      ],
                    ),
                    const SizedBox(height: 10),
                    RatingView(
                        value: widget.product.rating?.toInt() ?? 0,
                        iconSize: 12,
                        fontSize: 12,
                        isExtended: true),
                    const SizedBox(height: 10),
                    // PriceRowView(price: product.price!),
                    const SizedBox(height: 10),

                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.blue),
                          onPressed: () => {},
                          child: const Text("Add to Bag")),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                        onPressed: () => {},
                        style: OutlinedButton.styleFrom(
                          primary: Colors.blue,
                          side: const BorderSide(
                              width: 1.0,
                              color: Colors.blue,
                              style: BorderStyle.solid),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.favorite_border),
                              SizedBox(width: 12),
                              Text("Favorite"),
                            ]))
                  ])),
            ])),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 20),
        )
      ],
    ));
  }
}
