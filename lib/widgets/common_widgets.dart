import 'package:flutter/material.dart';
import 'package:grayhatproject/common/colors.dart';

import '../constants/size_constants.dart';

Widget errorContainer() {
  return Container(
    clipBehavior: Clip.hardEdge,
    child: Image.asset(
      'assets/images/hand.png',
      height: Sizes.dimen_200,
      width: Sizes.dimen_200,
    ),
  );
}

Widget chatImage({required String imageSrc, required Function onTap}) {
  return Column(
      // onPressed: onTap(),
      children: [
        Image.network(
          imageSrc,
          width: Sizes.dimen_200,
          height: Sizes.dimen_200,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext ctx, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              width: Sizes.dimen_200,
              height: Sizes.dimen_200,
              child: Center(
                child: CircularProgressIndicator(
                  color: Mycolors().blue,
                  value: loadingProgress.expectedTotalBytes != null &&
                          loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (context, object, stackTrace) => errorContainer(),
        ),
        const SizedBox(
          height: 10,
        ),
      ]);
}

Widget messageBubble(
    {required String chatContent,
    required EdgeInsetsGeometry? margin,
    Color? color,
    Color? textColor}) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(Sizes.dimen_10),
        margin: margin,
        width: Sizes.dimen_200,
        decoration: BoxDecoration(
          color: color,

          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
          ),
          // borderRadius: BorderRadius.circular(Sizes.dimen_10),
        ),
        child: Text(
          chatContent,
          style: TextStyle(fontSize: Sizes.dimen_16, color: textColor),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}
