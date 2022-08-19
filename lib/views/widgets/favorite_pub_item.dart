import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/model/product.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/views/widgets/custom_button.dart';
import 'package:flutter_template/views/widgets/custom_image.dart';
import 'package:flutter_template/views/widgets/heart._widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_template/viewModel/product_view_model.dart';
import 'package:provider/provider.dart';

class FavoritePubItem extends StatelessWidget {
  FavoritePubItem({
    Key? key,
    required this.data,
  }) : super(key: key);
  final ProductModel data;
  final _formKey = GlobalKey<FormState>();
  var _note = "";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: SizeConfig.safeBlockHorizontal * 90,
        height: SizeConfig.safeBlockVertical * 85,
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
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            TextFormField(
              controller: TextEditingController()..text = data.note!,
              decoration: const InputDecoration(
                hintText: 'Note',
                labelText: 'Add note',
              ),
              onSaved: (String? value) {
                _note = value.toString();
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "You should write a note";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            CustomButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  FocusManager.instance.primaryFocus?.unfocus();

                  await context.read<ProductViewModel>().addNote(data, _note);
                }
              },
              child: Text(
                "Save Note",
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.kDefaultSize * 5,
                ),
              ),
              height: SizeConfig.blockSizeVertical * 10,
              fontSize: SizeConfig.kDefaultSize * 5.5,
            ),
          ],
        ),
      ),
    );
  }
}
