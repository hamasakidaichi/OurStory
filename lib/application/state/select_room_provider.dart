import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomState extends StateNotifier<List<String>> {
  RoomState() : super([]);

  void updateRooms(List<String> newRooms) {
    state = newRooms;
  }
}

final selectedRoomProvider =
    StateNotifierProvider<RoomState, List<String>>((ref) => RoomState());
