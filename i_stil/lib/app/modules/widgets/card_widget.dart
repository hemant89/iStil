import 'package:flutter/material.dart';
import 'package:i_stil/app/const/color_const.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.color = KColors.primaryColor,
  }) : super(key: key);
  final Widget child;
  final Function()? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: (MediaQuery.of(context).size.width / 2) - 42,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(child: child),
      ),
    );
  }
}
