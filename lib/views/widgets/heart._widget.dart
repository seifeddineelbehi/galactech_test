import 'package:flutter/material.dart';
import 'package:flutter_template/model/product.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/viewModel/product_view_model.dart';
import 'package:provider/provider.dart';

class HeartWidget extends StatefulWidget {
  const HeartWidget({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductModel product;
  @override
  _HeartWidgetState createState() => _HeartWidgetState();
}

class _HeartWidgetState extends State<HeartWidget> with SingleTickerProviderStateMixin {
  bool isFav = false;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;
  late Animation<double> _curve;

  addFavoritGame() async {
    print("add ");
    //await context.read<ProductModel>().setFavoriteGames(widget.game);
  }

  // removeFromFavorite() async {
  //   print("remove ");
  //   await context.read<GamesViewModel>().removeMealFromFavorite(widget.game);
  // }

  @override
  void initState() {
    super.initState();
    isFav = context.read<ProductViewModel>().getFavoriteList.contains(widget.product);
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    _curve = CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);

    _colorAnimation = !isFav
        ? ColorTween(begin: Colors.red.withOpacity(0.3), end: Colors.red).animate(_curve)
        : ColorTween(begin: Colors.red, end: Colors.red.withOpacity(0.3)).animate(_curve);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 30, end: 50),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 50, end: 30),
        weight: 50,
      ),
    ]).animate(_curve);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    });
  }

  // dismiss the animation when widgit exits screen
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, _) {
          return IconButton(
            icon: Icon(
              Icons.favorite,
              color: _colorAnimation.value,
              size: _sizeAnimation.value,
            ),
            onPressed: () async {
              isFav ? _controller.reverse() : _controller.forward();
              await context.read<ProductViewModel>().addToFavoriteList(widget.product, "");
            },
          );
        });
  }
}
