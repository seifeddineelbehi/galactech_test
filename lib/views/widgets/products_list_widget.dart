import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/product.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/views/widgets/pub_item.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    Key? key,
    required this.product,
  }) : super(key: key);
  final List<ProductModel> product;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<ProductModel> products = [];
  final Tween<Offset> _offset = Tween(begin: const Offset(1, 0), end: const Offset(0, 0));
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _addGames();
    });
    super.initState();
  }

  void _addGames() {
    Future ft = Future(() {});
    for (int i = 0; i < (widget.product.length).round(); i++) {
      ft = ft.then((data) {
        return Future.delayed(const Duration(milliseconds: 500), () {
          products.add(widget.product[i]);
          _listKey.currentState?.insertItem(products.length - 1);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
      child: SizedBox(
        height: SizeConfig.safeBlockVertical * 32,
        child: AnimatedList(
          key: _listKey,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.safeBlockHorizontal * 4.5,
            vertical: SizeConfig.safeBlockVertical * 1,
          ),
          initialItemCount: products.length,
          itemBuilder: (context, index, animation) => SlideTransition(
            position: animation.drive(_offset),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PubItem(
                data: products[index],
              ),
            ),
          ), // ListTile
        ),
      ),
    );
  }
}
