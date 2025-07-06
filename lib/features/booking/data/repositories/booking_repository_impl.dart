import 'package:meeting_scheduler/features/booking/data/datasources/remote/booking_remote_datasource.dart';
import 'package:meeting_scheduler/features/booking/data/models/booking_model.dart';
import 'package:meeting_scheduler/features/booking/domain/entities/booking.dart';
import 'package:meeting_scheduler/features/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource _remoteDataSource;
  BookingRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> createBooking(Booking booking) async {
    try {
      final model = BookingModel.fromEntity(booking);
      await _remoteDataSource.createBooking(model);
    } catch (e) {
      throw Exception('Error creating booking: $e');
    }
  }

  @override
  Future<void> deleteBooking(Booking booking) async {
    try {
      final model = BookingModel.fromEntity(booking);
      await _remoteDataSource.deleteBooking(model);
    } catch (e) {
      throw Exception('Error deleting booking: $e');
    }
  }

  @override
  Future<List<Booking>> getBookings() async {
    try {
      final bookings = await _remoteDataSource.getBookings();
      return bookings.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Error fetching bookings: $e');
    }
  }
}
