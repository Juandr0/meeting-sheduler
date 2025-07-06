import 'package:meeting_scheduler/features/booking/domain/entities/booking.dart';
import 'package:meeting_scheduler/features/booking/domain/repositories/booking_repository.dart';

class CreateBookingUseCase {
  final BookingRepository _repository;
  CreateBookingUseCase(this._repository);

  Future<void> call(Booking booking) {
    return _repository.createBooking(booking);
  }
}
