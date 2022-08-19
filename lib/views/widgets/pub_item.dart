import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/model/product.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/views/widgets/custom_image.dart';
import 'package:flutter_template/views/widgets/heart._widget.dart';
import 'package:http/http.dart' as http;

class PubItem extends StatelessWidget {
  PubItem({
    Key? key,
    required this.data,
  }) : super(key: key);
  final ProductModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 90,
      height: SizeConfig.safeBlockVertical * 60,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 6,
            blurRadius: 1,
            offset: const Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CustomImage(
                data.image!,
                width: double.infinity,
                height: 220,
                radius: 15,
              ),
              Positioned(
                right: 5,
                top: 5,
                child: HeartWidget(product: data),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 2,
          ),
          Text(
            data.title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SizeConfig.kDefaultSize * 5,
              color: Palette.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 2,
          ),
          Text(
            data.description!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SizeConfig.kDefaultSize * 4,
              color: Palette.textColor,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
