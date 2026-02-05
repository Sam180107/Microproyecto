import 'dart:convert';
class ScoreEntry {
  final String nickname;
  final int attempts; 
  final int timeSeconds; 

  ScoreEntry({
    required this.nickname,
    required this.attempts,
    required this.timeSeconds,
  });
  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'attempts': attempts,
      'timeSeconds': timeSeconds,
    };
  }
  factory ScoreEntry.fromMap(Map<String, dynamic> map) {
    return ScoreEntry(
      nickname: map['nickname'],
      attempts: map['attempts'],
      timeSeconds: map['timeSeconds'],
    );
  }
  static String encode(List<ScoreEntry> scores) => json.encode(
        scores.map<Map<String, dynamic>>((score) => score.toMap()).toList(),
      );

  static List<ScoreEntry> decode(String scores) =>
      (json.decode(scores) as List<dynamic>)
          .map<ScoreEntry>((item) => ScoreEntry.fromMap(item))
          .toList();
}