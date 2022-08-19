import 'package:flutter/material.dart';
import 'package:flutter_template/model/product.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/viewModel/product_view_model.dart';
import 'package:flutter_template/views/widgets/favorite_products_list_widget.dart';
import 'package:flutter_template/views/widgets/products_list_widget.dart';
import 'package:flutter_template/views/widgets/pub_item.dart';
import 'package:provider/provider.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);
  static const String id = 'favorites_view';
  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.PageMainColor,
          centerTitle: true,
          title: const Text(
            "Favorites",
            style: TextStyle(color: Palette.textColor),
          ),
          elevation: 1,
          actions: [],
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
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
        child: FavoriteProductList(product: products),
      ),
    );
  }
}
