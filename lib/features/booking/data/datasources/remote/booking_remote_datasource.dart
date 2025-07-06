import 'package:meeting_scheduler/features/booking/data/models/booking_model.dart';

abstract class BookingRemoteDataSource {
  Future<void> createBooking(BookingModel booking);
  Future<void> deleteBooking(BookingModel booking);
  Future<List<BookingModel>> getBookings();
}
