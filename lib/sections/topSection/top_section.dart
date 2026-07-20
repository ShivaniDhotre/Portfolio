import 'package:flutter/material.dart';
import 'components/nav_bar.dart';
import 'components/hero_content.dart';

class TopSection extends StatelessWidget {
  final void Function(int)? onNavTap;
  const TopSection({Key? key, this.onNavTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/background.png"),
        ),
      ),
      child: Column(
        children: [
          NavBar(onNavTap: onNavTap),
          HeroContent(onSeeMyWork: () => onNavTap?.call(3)),
        ],
      ),
    );
  }
}
