import 'package:flutter/material.dart';
import 'package:store/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:store/features/products/presentation/pages/product_details_page.dart';

import '../../data/products_list_response.dart';
import '../../domain/repos/products_repository.dart';
import '../widgets/product_card.dart';
import '../widgets/product_item_view.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({Key? key}) : super(key: key);

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PaginationList<Product>(
        repositoryCallBack: (data) => ProductsRepository.getAllMyMedia(data),
        listBuilder: (List<Product> list){
          return ListView.builder(
              // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              //     maxCrossAxisExtent: 200,
              //     childAspectRatio: 3 / 2,
              //     crossAxisSpacing: 20,
              //     mainAxisSpacing: 20),
              itemCount: list.length,
              itemBuilder: (c,index){
                return InkWell(

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductItemView(
                      product: list[index],
                      onProductPressed: ( ){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>  ProductScreen(product: list[index] ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              });


        },

      ),
    );
  }
}
