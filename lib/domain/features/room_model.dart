class Room {
  final String roomId;
  late String roomName;
  final String creatorId;
  final List<String> participantIds;

  Room({
    required this.roomId,
    required this.roomName,
    required this.creatorId,
    required this.participantIds,
  });

  factory Room.fromMap(Map<String, dynamic> map) {
    print('fromMap: $map'); // デバッグプリント

    return Room(
      roomId: map['roomId'],
      roomName: map['roomName'] as String,
      creatorId: map['creatorId'] as String,
      participantIds:
          List<String>.from(map['participantIds'] as List<dynamic>? ?? []),
    );
  }
  Room copyWith({
    String? roomId,
    String? roomName,
    String? creatorId,
    List<String>? participantIds,
  }) {
    return Room(
      roomId: roomId ?? this.roomId,
      roomName: roomName ?? this.roomName,
      creatorId: creatorId ?? this.creatorId,
      participantIds: participantIds ?? this.participantIds,
    );
  }
}
