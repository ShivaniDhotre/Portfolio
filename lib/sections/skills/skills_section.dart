import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_app/components/section_title.dart';
import 'package:web_app/constants.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 600;
        final isTablet = width < 900;

        final double hPad = isMobile
            ? kDefaultPadding
            : isTablet
                ? kDefaultPadding * 2
                : kDefaultPadding * 3;

        final double tileSize = isMobile ? 74 : isTablet ? 82 : 88;
        final double iconSize = isMobile ? 26 : isTablet ? 28 : 32;
        final double fontSize = isMobile ? 10.0 : 11.0;
        final double spacing = isMobile ? 8 : 12;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: kDefaultPadding * (isMobile ? 1.5 : 2.5),
            horizontal: isMobile ? hPad : 0,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(
                    title: "Skills",
                    subTitle: "Technologies I work with",
                    color: kPrimaryColor,
                  ),
                  SizedBox(height: kDefaultPadding * (isMobile ? 1 : 1.5)),
                  Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    alignment: WrapAlignment.start,
                    children: _skills
                        .map((s) => _SkillTile(
                              skill: s,
                              tileSize: tileSize,
                              iconSize: iconSize,
                              fontSize: fontSize,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SkillData {
  final String label;
  final String? svgAsset;
  final IconData? icon;
  final Color color;
  const _SkillData(this.label, this.color, {this.svgAsset, this.icon});
}

const List<_SkillData> _skills = [
  _SkillData("Flutter",    Color(0xFF54C5F8), svgAsset: 'assets/images/Flutter-Dark.svg'),
  _SkillData("Dart",       Color(0xFF00B4AB), svgAsset: 'assets/images/dartlang-icon.svg'),
  _SkillData("GetX",       Color(0xFF9B59B6), icon: Icons.settings_suggest_outlined),
  _SkillData("Provider",   Color(0xFF3498DB), icon: Icons.account_tree_outlined),
  _SkillData("Firebase",   Color(0xFFFFCA28), svgAsset: 'assets/images/Firebase-Dark.svg'),
  _SkillData("REST API",   Color(0xFF2ECC71), icon: Icons.api_outlined),
  _SkillData("SQLite",     Color(0xFF00B1FF), svgAsset: 'assets/images/SQLite.svg'),
  _SkillData("MySQL",      Color(0xFF4479A1), svgAsset: 'assets/images/MySQL-Dark.svg'),
  _SkillData("PostgreSQL", Color(0xFF336791), svgAsset: 'assets/images/PostgreSQL-Dark.svg'),
  _SkillData("Hive",       Color(0xFFFFB300), icon: Icons.hive_outlined),
  _SkillData("Git",        Color(0xFFF05033), svgAsset: 'assets/images/Git.svg'),
  _SkillData("GitHub",     Color(0xFFE0E0E0), svgAsset: 'assets/images/Github-Dark.svg'),
  _SkillData("GitLab",     Color(0xFFFC6D26), svgAsset: 'assets/images/GitLab-Dark.svg'),
  _SkillData("VS Code",    Color(0xFF007ACC), svgAsset: 'assets/images/VSCode-Dark.svg'),
  _SkillData("Figma",      Color(0xFFFF7262), svgAsset: 'assets/images/Figma-Dark.svg'),
  _SkillData("Postman",    Color(0xFFFF6C37), svgAsset: 'assets/images/Postman.svg'),
  _SkillData("Swagger",    Color(0xFF85EA2D), svgAsset: 'assets/images/swagger (1).svg'),
  _SkillData("Android",    Color(0xFF3DDC84), svgAsset: 'assets/images/AndroidStudio-Dark.svg'),
  _SkillData("Java",       Color(0xFFE76F00), svgAsset: 'assets/images/Java-Dark.svg'),
  _SkillData("C",          Color(0xFF5C6BC0), svgAsset: 'assets/images/C.svg'),
  _SkillData("C++",        Color(0xFF00599C), svgAsset: 'assets/images/CPP.svg'),
];

class _SkillTile extends StatefulWidget {
  final _SkillData skill;
  final double tileSize;
  final double iconSize;
  final double fontSize;

  const _SkillTile({
    required this.skill,
    required this.tileSize,
    required this.iconSize,
    required this.fontSize,
  });

  @override
  State<_SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<_SkillTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: widget.tileSize,
        height: widget.tileSize,
        decoration: BoxDecoration(
          color: _hovered ? kBgLighter : kBgLight,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hovered
                ? widget.skill.color.withValues(alpha: 0.5)
                : const Color(0xFFE0E8F0),
            width: 1.5,
          ),
          boxShadow: _hovered ? [kHoverShadow] : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                widget.skill.label,
                style: TextStyle(
                  color: kTextColor,
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (widget.skill.svgAsset != null) {
      return SvgPicture.asset(
        widget.skill.svgAsset!,
        width: widget.iconSize,
        height: widget.iconSize,
      );
    }
    return Icon(widget.skill.icon, color: widget.skill.color, size: widget.iconSize);
  }
}
