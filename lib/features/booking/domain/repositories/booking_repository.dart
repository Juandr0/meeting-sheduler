import 'package:meeting_scheduler/features/booking/domain/entities/booking.dart';

abstract class BookingRepository {
  Future<List<Booking>> getBookings();
  Future<void> createBooking(Booking booking);
  Future<void> deleteBooking(Booking booking);
}
