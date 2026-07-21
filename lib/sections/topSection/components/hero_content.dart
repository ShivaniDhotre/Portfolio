import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroContent extends StatefulWidget {
  final VoidCallback? onSeeMyWork;
  const HeroContent({Key? key, this.onSeeMyWork}) : super(key: key);

  @override
  _HeroContentState createState() => _HeroContentState();
}

class _HeroContentState extends State<HeroContent>
    with TickerProviderStateMixin {
  bool _workHover = false;
  bool _emailHover = false;

  late AnimationController _fadeCtrl;
  late Animation<double> _fade;

  late AnimationController _floatCtrl;
  late Animation<double> _float;

  @override
  void initState() {
    super.initState();

    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700))
      ..forward();
    _fade = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);

    _floatCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 4))
      ..repeat(reverse: true);
    _float = Tween<double>(begin: -8, end: 8).animate(
        CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _floatCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;
    final isTablet = width >= 700 && width < 1024;

    final hPad = isMobile ? 20.0 : isTablet ? 32.0 : 60.0;
    final vPad = isMobile ? 32.0 : 50.0;

    return Container(
      constraints: BoxConstraints(minHeight: isMobile ? 0 : 580),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: FadeTransition(
            opacity: _fade,
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _avatar(isMobile: true),
                      const SizedBox(height: 32),
                      _leftContent(isMobile: true),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 6, child: _leftContent(isMobile: false)),
                      SizedBox(width: isTablet ? 24 : 48),
                      Expanded(flex: 4, child: _avatar(isMobile: false)),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  static const _shadow = [
    Shadow(color: Color(0x99000000), blurRadius: 8, offset: Offset(0, 2)),
  ];

  Widget _leftContent({required bool isMobile}) {
    final nameFontSize = isMobile ? 36.0 : 52.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 36,
            vertical: isMobile ? 28 : 40,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.18),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hello There!",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  shadows: _shadow,
                ),
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
              ),
              const SizedBox(height: 12),
              Text(
                "Shivani Dhotre",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: nameFontSize,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                  shadows: const [
                    Shadow(
                        color: Color(0xCC000000),
                        blurRadius: 12,
                        offset: Offset(0, 3)),
                  ],
                ),
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
              ),
              const SizedBox(height: 18),
              const Text(
                "Flutter Developer passionate about building cross-platform mobile applications with Flutter. Focused on clean code, intuitive UI, and delivering seamless user experiences.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.7,
                  shadows: _shadow,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 18),
              const Text(
                "Flutter Developer  —  Cross-Platform App Developer  —  Problem Solver",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  letterSpacing: 0.3,
                  shadows: _shadow,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment:
                    isMobile ? WrapAlignment.center : WrapAlignment.start,
                children: const [
                  "Flutter",
                  "Dart",
                  "Firebase",
                  "REST API",
                  "UI Design",
                ].map((s) => _Chip(label: s)).toList(),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 16,
                runSpacing: 12,
                alignment:
                    isMobile ? WrapAlignment.center : WrapAlignment.start,
                children: [
                  MouseRegion(
                    onEnter: (_) => setState(() => _workHover = true),
                    onExit: (_) => setState(() => _workHover = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      decoration: BoxDecoration(
                        color: _workHover
                            ? const Color(0xFFB8D8F8)
                            : const Color(0xFFCEE4FD),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: _workHover
                            ? [
                                BoxShadow(
                                  color: Colors.white.withValues(alpha: 0.3),
                                  blurRadius: 18,
                                  offset: const Offset(0, 4),
                                )
                              ]
                            : [],
                      ),
                      child: TextButton(
                        onPressed: widget.onSeeMyWork,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          "See my work",
                          style: TextStyle(
                            color: Color(0xFF1A1A2E),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  MouseRegion(
                    onEnter: (_) => setState(() => _emailHover = true),
                    onExit: (_) => setState(() => _emailHover = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              _emailHover ? Colors.white : Colors.white54,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          launchUrl(
                            Uri.parse(
                              'https://mail.google.com/mail/?view=cm&to=shivanidhotre609@gmail.com',
                            ),
                            webOnlyWindowName: '_blank',
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          "Email",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatar({required bool isMobile}) {
    final avatarSize = isMobile ? 220.0 : 360.0;
    final photoSize = isMobile ? 160.0 : 240.0;

    return Center(
      child: AnimatedBuilder(
        animation: _floatCtrl,
        builder: (context, _) {
          return Transform.translate(
            offset: Offset(0, _float.value),
            child: SizedBox(
              width: avatarSize,
              height: avatarSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Static rings - no rotation
                  _ring(avatarSize, 0.12),
                  _ring(avatarSize * 0.86, 0.15),
                  _ring(avatarSize * 0.72, 0.20),
                  // Photo with border
                  Container(
                    width: photoSize,
                    height: photoSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.5),
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.2),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/profile_image.jpeg",
                        fit: BoxFit.cover,
                        alignment: const Alignment(0, -0.3),
                        cacheWidth: photoSize.toInt() * 2,
                        cacheHeight: photoSize.toInt() * 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _ring(double size, double opacity) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: opacity),
            width: 1,
          ),
        ),
      );
}

class _Chip extends StatefulWidget {
  final String label;
  const _Chip({required this.label});

  @override
  State<_Chip> createState() => _ChipState();
}

class _ChipState extends State<_Chip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: _hovered
              ? Colors.white.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered ? Colors.white : Colors.white38,
          ),
        ),
        child: Text(
          widget.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
