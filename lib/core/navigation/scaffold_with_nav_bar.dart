import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final navTheme = Theme.of(context).bottomNavigationBarTheme;
    final l10n = context.l10n;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: _onTap,
          backgroundColor: navTheme.backgroundColor,
          selectedItemColor: navTheme.selectedItemColor,
          unselectedItemColor: navTheme.unselectedItemColor,
          selectedLabelStyle: navTheme.selectedLabelStyle,
          unselectedLabelStyle: navTheme.unselectedLabelStyle,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.auto_stories_outlined),
              activeIcon: const Icon(Icons.auto_stories),
              label: l10n.navJournal,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.account_balance_outlined),
              activeIcon: const Icon(Icons.account_balance),
              label: l10n.navTemple,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.local_library_outlined),
              activeIcon: const Icon(Icons.local_library),
              label: l10n.navPortico,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.gavel_outlined),
              activeIcon: const Icon(Icons.gavel),
              label: l10n.navOrder,
            ),
          ],
        ),
      ),
    );
  }
}
