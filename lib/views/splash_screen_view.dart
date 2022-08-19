import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/product.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/viewModel/product_view_model.dart';
import 'package:flutter_template/views/views.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen_view';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 0), () async {
      await context.read<ProductViewModel>().GetAllProducts();
      await context.read<ProductViewModel>().generateFavoriteList();
      var response = context.read<ProductViewModel>().ResultData;
      if (response is List<ProductModel>) {
        Navigator.pushReplacementNamed(
          context,
          HomeView.id,
          arguments: {'products': response},
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Palette.PrimaryColor,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
