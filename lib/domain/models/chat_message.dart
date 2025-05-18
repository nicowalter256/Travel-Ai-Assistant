class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? sessionId;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.sessionId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'is_user': isUser,
        'timestamp': timestamp.toIso8601String(),
        'session_id': sessionId,
      };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json['id'],
        text: json['text'],
        isUser: json['is_user'],
        timestamp: DateTime.parse(json['timestamp']),
        sessionId: json['session_id'],
      );
}
