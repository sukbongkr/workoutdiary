import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:iconly/iconly.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');

final goRouter = GoRouter(
  initialLocation: '/',
  // * Passing a navigatorKey causes an issue on hot reload:
  // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
  // * However it's still necessary otherwise the navigator pops back to
  // * root on hot reload
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    // Stateful navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RootScreen(label: 'A', detailsPath: '/details'),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'A'),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/b',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RootScreen(label: 'B', detailsPath: '/b/details'),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'B'),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/c',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RootScreen(label: 'B', detailsPath: '/b/details'),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'B'),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

void main() {
  // turn off the # in the URLs on the web
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}

// Stateful navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ScaffoldWithNavigationBar(
        body: navigationShell,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
      );
    });
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(label: '운동하기', icon: Icon(IconlyLight.home)),
          NavigationDestination(
              label: '오늘의기록', icon: Icon(IconlyLight.setting)),
          NavigationDestination(label: '통계', icon: Icon(IconlyLight.setting)),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}

/// Widget for the root/initial pages in the bottom navigation bar.
class RootScreen extends StatelessWidget {
  /// Creates a RootScreen
  const RootScreen({required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab root - $label'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Screen $label',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () => context.go(detailsPath),
              child: const Text('View details'),
            ),
          ],
        ),
      ),
    );
  }
}

/// The details screen for either the A or B screen.
class DetailsScreen extends StatefulWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    Key? key,
  }) : super(key: key);

  /// The label to display in the center of the screen.
  final String label;

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

/// The state for DetailsScreen
class DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen - ${widget.label}'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Details for ${widget.label} - Counter: $_counter',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Increment counter'),
            ),
          ],
        ),
      ),
    );
  }
}
