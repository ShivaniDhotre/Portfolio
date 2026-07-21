import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatefulWidget {
  final void Function(int)? onNavTap;
  const NavBar({Key? key, this.onNavTap}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _hoverIndex = -1;
  int _selectedIndex = 0;
  bool _menuOpen = false;

  final List<String> _items = [
    "About",
    "Experience",
    "Education",
    "Projects",
    "Skills",
    "Contact",
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;
    final hPad = isMobile ? 20.0 : width < 1024 ? 32.0 : 60.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          height: 72,
          padding: EdgeInsets.symmetric(horizontal: hPad),
          color: Colors.black.withValues(alpha: 0.25),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Row(
                children: [
                  // Brand
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Shivani ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "Dhotre",
                          style: TextStyle(
                            color: Color(0xFFCEE4FD),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (!isMobile) ...[
                    ...List.generate(_items.length, (i) => _buildNavItem(i)),
                    const SizedBox(width: 24),
                    _socialIcon("assets/images/github_logo.png",
                        "https://github.com/ShivaniDhotre"),
                    const SizedBox(width: 12),
                    _socialIcon("assets/images/linkdin_logo.png",
                        "https://www.linkedin.com/in/shivani-dhotre-226046175"),
                  ] else ...[
                    _socialIcon("assets/images/github_logo.png",
                        "https://github.com/ShivaniDhotre"),
                    const SizedBox(width: 10),
                    _socialIcon("assets/images/linkdin_logo.png",
                        "https://www.linkedin.com/in/shivani-dhotre-226046175"),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: () =>
                          setState(() => _menuOpen = !_menuOpen),
                      icon: Icon(
                        _menuOpen ? Icons.close : Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        // Mobile dropdown menu
        if (isMobile && _menuOpen)
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 220,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A4A5A).withValues(alpha: 0.55),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      border: Border.all(
                        color: const Color(0xFFCEE4FD).withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(
                        _items.length,
                        (i) => InkWell(
                          onTap: () => setState(() {
                            _selectedIndex = i;
                            _menuOpen = false;
                            widget.onNavTap?.call(i);
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            decoration: BoxDecoration(
                              color: _selectedIndex == i
                                  ? const Color(0xFFCEE4FD).withValues(alpha: 0.12)
                                  : Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                    color: const Color(0xFFCEE4FD)
                                        .withValues(alpha: 0.1)),
                              ),
                            ),
                            child: Row(
                              children: [
                                if (_selectedIndex == i)
                                  Container(
                                    width: 3,
                                    height: 18,
                                    margin: const EdgeInsets.only(right: 12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFCEE4FD),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                Text(
                                  _items[i],
                                  style: TextStyle(
                                    color: _selectedIndex == i
                                        ? const Color(0xFFCEE4FD)
                                        : Colors.white70,
                                    fontSize: 15,
                                    fontWeight: _selectedIndex == i
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNavItem(int i) {
    final bool active = _selectedIndex == i || _hoverIndex == i;
    return MouseRegion(
      onEnter: (_) => setState(() => _hoverIndex = i),
      onExit: (_) => setState(() => _hoverIndex = -1),
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedIndex = i);
          widget.onNavTap?.call(i);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: active ? Colors.white : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            _items[i],
            style: TextStyle(
              color: active ? Colors.white : Colors.white70,
              fontSize: 14,
              fontWeight: active ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(String asset, String? url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: url != null
            ? () => launchUrl(Uri.parse(url),
                mode: LaunchMode.externalApplication)
            : null,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white.withValues(alpha: 0.1),
          ),
          padding: const EdgeInsets.all(4),
          child: Image.asset(asset, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
