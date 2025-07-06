import 'package:meeting_scheduler/features/booking/domain/entities/booking.dart';
import 'package:meeting_scheduler/features/booking/domain/repositories/booking_repository.dart';

class GetBookingsUseCase {
  final BookingRepository _repository;
  GetBookingsUseCase(this._repository);

  Future<List<Booking>>? call() {
    return _repository.getBookings();
  }
}
