import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class InkWellWidget extends StatelessWidget {
  final String? image;
  final Function()? onTap;

  InkWellWidget({this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(defaultRadius),
        clipBehavior: Clip.hardEdge,
        child: Ink(
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 190,
              width: 140,
              child: CachedNetworkImage(
                imageUrl: image.validate(),
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) {
                  return Ink.image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ).cornerRadiusWithClipRRect(defaultRadius);
                },
                placeholder: (_, s) {
                  return PlaceHolderWidget(
                    height: 190,
                    alignment: Alignment.center,
                  ).cornerRadiusWithClipRRect(defaultRadius);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
