import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_story/presentation/widgets/calendar_ui.dart';

class PageCalendar extends StatelessWidget {
  const PageCalendar({super.key});

  backHome(BuildContext context) {
    context.pop('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () => backHome(context),
        ),
      ),
      body: const CalendarUi(),
    );
  }
}
