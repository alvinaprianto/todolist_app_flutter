import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class CustomSectionWidgetProfile extends StatelessWidget {
  const CustomSectionWidgetProfile(
      {Key? key,
      required this.icon,
      required this.title,
      required this.onPressed})
      : super(key: key);
  final String icon;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            image: Svg(icon),
            height: 24,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          const Spacer(),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
