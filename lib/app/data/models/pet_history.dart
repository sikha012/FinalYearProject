// To parse this JSON data, do
//
//     final petHistory = petHistoryFromJson(jsonString);

import 'dart:convert';

PetHistory petHistoryFromJson(String str) =>
    PetHistory.fromJson(json.decode(str));

String petHistoryToJson(PetHistory data) => json.encode(data.toJson());

class PetHistory {
  final int? historyId;
  final String? eventName;
  final String? eventDescription;
  final DateTime? eventDate;
  final int? petId;

  PetHistory({
    this.historyId,
    this.eventName,
    this.eventDescription,
    this.eventDate,
    this.petId,
  });

  factory PetHistory.fromJson(Map<String, dynamic> json) => PetHistory(
        historyId: json["history_id"],
        eventName: json["event_name"],
        eventDescription: json["event_description"],
        eventDate: json["event_date"] == null
            ? null
            : DateTime.parse(json["event_date"]),
        petId: json["pet_id"],
      );

  Map<String, dynamic> toJson() => {
        "history_id": historyId,
        "event_name": eventName,
        "event_description": eventDescription,
        "event_date": eventDate?.toIso8601String(),
        "pet_id": petId,
      };
}
