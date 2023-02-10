import 'package:flutter/material.dart';

class CustomSectionProfile extends StatelessWidget {
  const CustomSectionProfile({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.white.withOpacity(0.6)),
      ),
    );
  }
}
