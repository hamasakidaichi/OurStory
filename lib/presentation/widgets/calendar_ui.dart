import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_story/application/state/event_list_provider.dart';
import 'package:our_story/application/state/focused_provider.dart';
import 'package:our_story/application/state/selected_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:our_story/domain/features/events_model.dart';
import 'package:our_story/domain/types/roomid_holder.dart';
import 'package:our_story/domain/features/eventList.dart';
import 'package:table_calendar/table_calendar.dart';

//firestoreから取得する関数
// fetchAndPrintCalEvents()をbuildメソッド内で実行すると、EventModelを返し
// EventとDateとしてデバッグプリントへ表示。
// 取得したリストをUI表示の際に保存される変数へ初期値として与えることで、
// 多分UIとして描画される
// こではeventListMapへ初期値として与えればよいと思う、多分。
//本来ならStreamとしてfirestoreからのデータを非同期で取得する方法で、
//fitestoreからデータの取得と描画を行う。
//chatがその仕組みで実装しているので、詳しくはPageChatを参照。

void fetchAndPrintCalEvents() async {
  final roomId = RoomIdHolder.roomId;
  final path = '/rooms/$roomId/cal';
  final collectionRef = FirebaseFirestore.instance.collection(path);

  final snapshot = await collectionRef.get();
  final events = snapshot.docs.map((doc) {
    final event = doc['event'] as String;
    final date = doc['date'] as Timestamp;

    final dateTime = date.toDate();

    print('Event: $event, Date: $dateTime'); // デバッグプリント

    return EventModel(event: event, date: dateTime);
  }).toList();
}
//fetchAndPrintCalEventsをb

class CalendarUi extends ConsumerWidget {
  const CalendarUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    fetchAndPrintCalEvents();
    final focused = ref.watch(focusedProvider);
    final focusedNotifier = ref.read(focusedProvider.notifier);
    final selected = ref.watch(selectedProvider);
    final selectedNotifier = ref.read(selectedProvider.notifier);
    final eventListsNotifier = ref.read(eventListsProvider.notifier);
    final watchLists = ref.watch(eventListsProvider);
    final eventTextController = TextEditingController(); // 追加

    List getEventForDay(DateTime day) {
      return eventListMap[day] ?? [];
    }

    void addEvent(DateTime day, String event) {
      final roomId = RoomIdHolder.roomId; // ルームIDを設定する

      // Firestoreの参照パスを構築
      final path = '/rooms/$roomId/cal';

      // Firestoreの参照を取得
      final collectionRef = FirebaseFirestore.instance.collection(path);

      // イベントを追加
      collectionRef.add({'date': day, 'event': event});

      // イベントリストを更新
      eventListMap[day] = [...(eventListMap[day] ?? []), event];
      eventListsNotifier.state = eventListMap[selected] ?? [];
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
          FloatingActionButton(
            tooltip: 'Action!',
            child: const Icon(Icons.add),
            onPressed: () {
              final selectedDay = selectedNotifier.state;
              if (selectedDay != null) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Add Event'),
                      content: TextField(
                        controller: eventTextController, // 追加
                        onChanged: (value) {
                          // イベントの入力を受け取る
                          // eventText = value; // 削除
                        },
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            // 入力されたイベントを追加する
                            addEvent(
                                selectedDay, eventTextController.text); // 変更
                            Navigator.of(context).pop();
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
