import 'package:flutter/material.dart';
import 'package:flutter_template/model/product.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/viewModel/product_view_model.dart';
import 'package:flutter_template/views/pages/favorites_view.dart';
import 'package:flutter_template/views/widgets/products_list_widget.dart';
import 'package:flutter_template/views/widgets/pub_item.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const String id = 'home_view';
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.PageMainColor,
          centerTitle: true,
          title: const Text(
            "Products",
            style: TextStyle(color: Palette.textColor),
          ),
          elevation: 1,
          actions: [
            IconButton(
              onPressed: () async {
                var response = context.read<ProductViewModel>().getFavoriteList;
                if (response is List<ProductModel>) {
                  Navigator.pushNamed(
                    context,
                    FavoritesView.id,
                    arguments: {'products': response},
                  );
                }
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
          ],
        ),
        backgroundColor: Palette.PageMainColor,
        body: buildBody(arguments["products"]),
      ),
    );
  }

  buildBody(List<ProductModel> products) {
    return Center(
      child: SizedBox(
        width: SizeConfig.safeBlockHorizontal * 95,
        height: SizeConfig.safeBlockVertical * 100,
        child: ProductList(product: products),
      ),
    );
  }
}
