import 'package:flutter/material.dart';
import 'package:web_app/models/RecentWork.dart';
import '../../../constants.dart';

const List<Color> _cardColors = [
  Color(0xFFE8F4FF),  // light blue
  Color(0xFFEAFFF2),  // light green
  Color(0xFFFFF8E7),  // light yellow
];

const List<Color> _accentColors = [
  kPrimaryColor,
  kAccentColor,
  kAccentYellow,
];

class RecentWorkCard extends StatefulWidget {
  const RecentWorkCard({
    Key? key,
    required this.index,
    required this.press,
  }) : super(key: key);

  final int index;
  final Function()? press;

  @override
  _RecentWorkCardState createState() => _RecentWorkCardState();
}

class _RecentWorkCardState extends State<RecentWorkCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final work = recentWorks[widget.index];
    final color = _cardColors[widget.index % _cardColors.length];
    final accent = _accentColors[widget.index % _accentColors.length];

    return InkWell(
      onTap: widget.press,
      onHover: (value) => setState(() => isHover = value),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 340,
        padding: EdgeInsets.all(kDefaultPadding * 1.5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [if (isHover) kHoverShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon circle
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                    color: Colors.black.withValues(alpha: 0.08),
                  ),
                ],
              ),
              child: Icon(Icons.phone_android_outlined, color: accent, size: 24),
            ),
            SizedBox(height: kDefaultPadding),
            // Category
            Text(
              work.category.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                color: accent,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: kDefaultPadding * 0.5),
            // Title
            Text(
              work.title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
                height: 1.3,
              ),
            ),
            SizedBox(height: kDefaultPadding * 0.8),
            // Description
            Text(
              work.description,
              style: TextStyle(
                fontSize: 13,
                color: kTextColor,
                height: 1.6,
              ),
            ),
            SizedBox(height: kDefaultPadding),
            // Tech chips
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: work.tech
                  .map((t) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: accent.withValues(alpha: 0.4)),
                        ),
                        child: Text(
                          t,
                          style: TextStyle(
                            fontSize: 11,
                            color: accent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
