import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:iconly/iconly.dart';
import 'package:workoutdiary/pages/exercise/routine_select.dart';
import 'package:workoutdiary/pages/exercise/workout.dart';
import 'package:workoutdiary/pages/stat/page.dart';
import 'package:workoutdiary/pages/today/page.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');

final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
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
              builder: (context, state) => const RoutineSelect(),
              routes: [
                GoRoute(
                  path: 'workout/:id',
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return WorkoutPage(id: id);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            GoRoute(
              path: '/today',
              builder: (context, state) => const TodayPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/stat',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: StatPage(),
              ),
              // routes: [
              //   GoRoute(
              //     path: 'details',
              //     builder: (context, state) => const DetailsScreen(label: 'B'),
              //   ),
              // ],
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
  runApp(const ProviderScope(child: MyApp()));
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
