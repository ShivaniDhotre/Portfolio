import 'package:flutter/material.dart';
import 'components/hero_content.dart';

class TopSection extends StatelessWidget {
  final void Function(int)? onNavTap;
  const TopSection({Key? key, this.onNavTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: screenHeight),
      decoration: const BoxDecoration(
        color: Color(0xFF2A7A8C),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/background.webp"),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 72), // reserve space for the floating NavBar
          HeroContent(onSeeMyWork: () => onNavTap?.call(3)),
        ],
      ),
    );
  }
}
