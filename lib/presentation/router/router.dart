import 'package:go_router/go_router.dart';
import 'package:our_story/presentation/pages/page_calendar.dart';
import 'package:our_story/presentation/pages/page_home.dart';
import 'package:our_story/presentation/pages/page_mapping.dart';

final router = GoRouter(initialLocation: '/home', routes: [
  GoRoute(
    path: '/home',
    builder: (context, state) => const PageHome(),
  ),
  GoRoute(
    path: '/map',
    builder: (context, state) => const PageMapping(),
  ),
  GoRoute(
    path: '/calendar',
    builder: (context, state) => const PageCalendar(),
  ),
]);
