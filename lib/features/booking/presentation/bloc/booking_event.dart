import 'package:equatable/equatable.dart';
import 'package:meeting_scheduler/features/booking/domain/entities/booking.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class LoadBookingsEvent extends BookingEvent {}

class CreateBookingEvent extends BookingEvent {
  final Booking booking;

  const CreateBookingEvent(this.booking);

  @override
  List<Object?> get props => [booking];
}

class DeleteBookingEvent extends BookingEvent {
  final Booking booking;

  const DeleteBookingEvent(this.booking);

  @override
  List<Object?> get props => [booking];
}
