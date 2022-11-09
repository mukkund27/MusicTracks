// To parse this JSON data, do
//
//     final lyricsModel = lyricsModelFromJson(jsonString);

import 'dart:convert';

LyricsModel lyricsModelFromJson(String str) =>
    LyricsModel.fromJson(json.decode(str));

String lyricsModelToJson(LyricsModel data) => json.encode(data.toJson());

class LyricsModel {
  LyricsModel({
    this.message,
  });

  final Message? message;

  factory LyricsModel.fromJson(Map<String, dynamic> json) => LyricsModel(
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class Message {
  Message({
    this.header,
    this.body,
  });

  final Header? header;
  final Body? body;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        header: Header.fromJson(json["header"]),
        body: Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "header": header!.toJson(),
        "body": body!.toJson(),
      };
}

class Body {
  Body({
    this.lyrics,
  });

  final Lyrics? lyrics;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        lyrics: Lyrics.fromJson(json["lyrics"]),
      );

  Map<String, dynamic> toJson() => {
        "lyrics": lyrics!.toJson(),
      };
}

class Lyrics {
  Lyrics({
    this.lyricsId,
    this.explicit,
    this.lyricsBody,
    this.scriptTrackingUrl,
    this.pixelTrackingUrl,
    this.lyricsCopyright,
    this.updatedTime,
  });

  final int? lyricsId;
  final int? explicit;
  final String? lyricsBody;
  final String? scriptTrackingUrl;
  final String? pixelTrackingUrl;
  final String? lyricsCopyright;
  final String? updatedTime;

  factory Lyrics.fromJson(Map<String, dynamic> json) => Lyrics(
        lyricsId: json["lyrics_id"],
        explicit: json["explicit"],
        lyricsBody: json["lyrics_body"],
        scriptTrackingUrl: json["script_tracking_url"],
        pixelTrackingUrl: json["pixel_tracking_url"],
        lyricsCopyright: json["lyrics_copyright"],
        updatedTime: json["updated_time"],
      );

  Map<String, dynamic> toJson() => {
        "lyrics_id": lyricsId,
        "explicit": explicit,
        "lyrics_body": lyricsBody,
        "script_tracking_url": scriptTrackingUrl,
        "pixel_tracking_url": pixelTrackingUrl,
        "lyrics_copyright": lyricsCopyright,
        "updated_time": updatedTime,
      };
}

class Header {
  Header({
    this.statusCode,
    this.executeTime,
  });

  final int? statusCode;
  final double? executeTime;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        statusCode: json["status_code"],
        executeTime: json["execute_time"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "execute_time": executeTime,
      };
}
