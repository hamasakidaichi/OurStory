import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_story/application/state/event_list_provider.dart';
import 'package:our_story/application/state/focused_provider.dart';
import 'package:our_story/application/state/selected_provider.dart';
import 'package:our_story/presentation/router/eventList.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarUi extends ConsumerWidget {
  const CalendarUi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var focused = ref.watch(focusedProvider);
    final focusedNotifier = ref.read(focusedProvider.notifier);
    var selected = ref.watch(selectedProvider);
    final selectedNotifier = ref.read(selectedProvider.notifier);
    final eventListsNotifier = ref.read(eventListsProvider.notifier);
    final watchLists = ref.watch(eventListsProvider);
    List getEventForDay(DateTime day) {
      return eventListMap[day] ?? [];
    }

    return Center(
      child: Column(
        children: [
          TableCalendar(
            locale: 'ja_JP',
            firstDay: DateTime.utc(2023, 4, 1),
            lastDay: DateTime.utc(2026, 12, 31),
            focusedDay: focused,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
            selectedDayPredicate: (day) {
              return isSameDay(selected, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(selected, selectedDay)) {
                selectedNotifier.state = selectedDay;
                focusedNotifier.state = focusedDay;
              }

              eventListsNotifier.state = eventListMap[selectedDay] ?? [];
            },
            eventLoader: getEventForDay,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: watchLists.length,
            itemBuilder: (context, index) {
              final event = watchLists[index];
              return ListTile(
                title: Text(event),
              );
            },
          ),
        ],
      ),
    );
  }
}
