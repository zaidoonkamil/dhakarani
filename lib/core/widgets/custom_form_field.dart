import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormField extends StatelessWidget {
  CustomFormField(
      {Key? key,
        this.hintText,
        this.onTap,
        this.textInputType,
        this.width,
        this.height,
        this.validate,
        this.controller,
        this.onTapp,
        this.enabledBorder,
        this.onChanged,
        this.textAlign,
        this.prefixIcon,
        this.colorBorderContent,
        this.textStyleHint,
        this.maxLines,
        this.minLines,
        this.obscureText = false
      }) : super(key: key);

  void Function(String)? onTapp;
  void Function()? onTap;
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  double? width;
  double? height;
  bool? obscureText;
  TextInputType? textInputType;
  TextAlign? textAlign;
  TextStyle? textStyleHint;
  int? maxLines=1;
  int? minLines=1;
  Color? enabledBorder;
  Color? colorBorderContent;
  Widget? prefixIcon;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height:height?? 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: colorBorderContent??Theme.of(context).dividerColor,
          ),
          child: TextFormField(
            onChanged: onChanged,
            onFieldSubmitted: onTapp,
            onTap: onTap,
            controller: controller,
            keyboardType:textInputType?? TextInputType.text ,
            textAlign:textAlign?? TextAlign.right,
            textAlignVertical: TextAlignVertical.bottom,
            obscureText: obscureText!,
            validator: validate,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              hintText: hintText,
              hintStyle: textStyleHint?? Theme.of(context).textTheme.headline1,
              fillColor:  Theme.of(context).dividerColor,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0), // Border when focused
                borderRadius: BorderRadius.circular(14),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color:enabledBorder?? Theme.of(context).dividerColor, width: 1.0), // Border when not focused
              ),
            ),
          ),
        ),
      ],
    );
  }
}
