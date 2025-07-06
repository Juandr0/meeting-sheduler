import 'package:meeting_scheduler/features/booking/domain/entities/booking.dart';
import 'package:meeting_scheduler/features/booking/domain/repositories/booking_repository.dart';

class DeleteBookingUseCase {
  final BookingRepository _repository;
  DeleteBookingUseCase(this._repository);

  Future<void> call(Booking booking) {
    return _repository.deleteBooking(booking);
  }
}
