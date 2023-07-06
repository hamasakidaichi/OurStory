import 'package:go_router/go_router.dart';
import 'package:our_story/presentation/pages/page_auth.dart';
import 'package:our_story/presentation/pages/page_chat.dart';
import 'package:our_story/presentation/pages/page_calendar.dart';
import 'package:our_story/presentation/pages/page_create_room.dart';
import 'package:our_story/presentation/pages/page_home.dart';
import 'package:our_story/presentation/pages/page_join_room.dart';
import 'package:our_story/presentation/pages/page_mapping.dart';
import 'package:our_story/presentation/pages/page_select_rooms.dart';

final router = GoRouter(initialLocation: '/auth', routes: [
  GoRoute(
    path: '/selection',
    builder: (context, state) => PageSelectRoom(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const PageHome(),
  ),
  GoRoute(
    path: '/create',
    builder: (context, state) => const PageCreateRoom(),
  ),
  GoRoute(
    path: '/join',
    builder: (context, state) => const PageJoinRoom(),
  ),
  GoRoute(
    path: '/map',
    builder: (context, state) => const PageMapping(),
  ),
  GoRoute(
    path: '/calendar',
    builder: (context, state) => const PageCalendar(),
  ),
  GoRoute(
    path: '/chat',
    builder: (context, state) => const PageChat(),
  ),
  GoRoute(
    path: '/auth',
    builder: (context, state) => const PageAuth(),
  ),
]);
