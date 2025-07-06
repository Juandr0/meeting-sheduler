class Booking {
  String? bookingId;
  String userId;
  String roomId;
  DateTime start;
  DateTime end;

  Booking(
      {this.bookingId,
      required this.userId,
      required this.roomId,
      required this.start,
      required this.end});
}
