import 'package:flutter/material.dart';

class CustomBottom extends StatelessWidget {
  final String text;
  final double roundness;
  final double? horizontal;
  final double? vertical;
  final FontWeight fontWeight;
  final VoidCallback? onTap;
  final Color? colorText;
  final Color colorBottom;
  final Color? colorBorderBottom;
  final double? fontSize;
  final double? sizeCircular;
  final double? width;
  final double? height;
  final TextAlign? textAlign;
  final BorderRadius? borderRadius;
  final Widget? icon;
  final TextStyle? textStyle;

  const CustomBottom({
    Key? key,
    required this.text,
    this.roundness = 18,
    this.fontWeight = FontWeight.bold,
    this.onTap,
    this.colorText,
    this.textStyle,
    this.fontSize,
    required this.colorBottom,
    this.width,
    this.height,
    this.sizeCircular,
    this.horizontal,
    this.vertical,
    this.icon,
    this.borderRadius,
    this.colorBorderBottom, this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontal??0,vertical:vertical??0 ),
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: colorBorderBottom ?? colorBottom
            ),
          color: colorBottom,
          borderRadius:borderRadius?? BorderRadius.circular(sizeCircular??20)  ,
        ),
        width: width,
        height: height ?? 40,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style:textStyle??Theme.of(context).textTheme.headline2 ,
                  textAlign: textAlign,
                ),
                icon == null? Container():const SizedBox(width: 4,),
                icon??Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
