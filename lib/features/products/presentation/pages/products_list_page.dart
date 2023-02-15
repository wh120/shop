import 'package:flutter/material.dart';
import 'package:store/core/boilerplate/pagination/widgets/pagination_list.dart';

import '../../data/products_list_response.dart';
import '../../domain/repos/products_repository.dart';

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
            itemCount: list.length,
            itemBuilder:(context, index) {
            return Text(list[index].title.toString());
          },);

        },

      ),
    );
  }
}
