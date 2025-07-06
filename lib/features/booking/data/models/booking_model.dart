import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meeting_scheduler/features/booking/domain/entities/booking.dart';

class BookingModel extends Booking {
  BookingModel({
    String? bookingId,
    required super.userId,
    required super.roomId,
    required super.start,
    required super.end,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['bookingId'],
      userId: json['id'],
      roomId: json['roomId'],
      start: (json['start'] is Timestamp)
          ? (json['start'] as Timestamp).toDate()
          : DateTime.parse(json['start']),
      end: (json['end'] is Timestamp)
          ? (json['end'] as Timestamp).toDate()
          : DateTime.parse(json['end']),
    );
  }

  Map<String, dynamic> toJson() => {
        'bookingId': bookingId,
        'id': userId,
        'roomId': roomId,
        'start': Timestamp.fromDate(start),
        'end': Timestamp.fromDate(end),
      };

  BookingModel copyWith({
    String? bookingId,
    String? roomId,
    String? userId,
    DateTime? start,
    DateTime? end,
  }) {
    return BookingModel(
      bookingId: bookingId ?? this.bookingId,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  factory BookingModel.fromEntity(Booking booking) {
    return BookingModel(
      bookingId: booking.bookingId,
      roomId: booking.roomId,
      userId: booking.userId,
      start: booking.start,
      end: booking.end,
    );
  }

  Booking toEntity() {
    return Booking(
      bookingId: bookingId,
      roomId: roomId,
      userId: userId,
      start: start,
      end: end,
    );
  }
}
